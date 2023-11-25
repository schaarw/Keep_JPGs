--[[----------------------------------------------------------------------------

Keep_JPGs.lua

Lightroom plugin to remove raw photos if jpg versions exist. 
Use it for your lower rated fotos.
Adjust the maximum rating (default =  '< 3') for which the raws should be removed.

------------------------------------------------------------------------------]]


--local LrView = import 'LrView'
local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'
local LrLogger = import 'LrLogger'
local LrFileUtils = import 'LrFileUtils'
--local LrSelection = import 'LrSelection'
local LrPathUtils = import 'LrPathUtils'

-- Create the logger and enable the print function.

local myLogger = LrLogger( 'libraryLogger' )
myLogger:enable( "print" ) -- Pass either a string or a table of actions

-- Write trace information to the logger.

local function outputToLog( format, parameter )
  local message = string.format(format, parameter )
	myLogger:trace( message )
end


LrTasks.startAsyncTask(function ()
  local catalog = LrApplication.activeCatalog()
  local photos = catalog:getTargetPhotos()
  local jpg_ratings = {}
  local message = string.format( "%q fotos selected, continue?", #photos )
  --outputToLog( "%s", message )
  local user_confirmation = LrDialogs.confirm( "Proceed?", message )
  --outputToLog( "%s", user_confirmation)
  if user_confirmation == "ok" then

    local i = 1
    while i <= #photos do
      local photo = photos[i]
      local filename  = photo:getFormattedMetadata("fileName")
      local available = photo:checkPhotoAvailability()
      local fileType  = photo:getFormattedMetadata("fileType")
      local rating    = photo:getRawMetadata("rating")
      if rating == nil then
        rating = 0
      end

      --outputToLog( "The selected photo's filename is %q", filename)
      --outputToLog( "Its availability is %q", available )
      --outputToLog( "Its type is %s", fileType )
      --outputToLog( "Its rating is %s", rating )

      local is_raw =  string.find(fileType, "NEF") or string.find(fileType, "DNG")
      --outputToLog("is_raw is %s", is_raw)

      -- rating < 3 = do not delete high rated raws by mistake
      if is_raw and available and rating < 3 then
        
        local path = photo:getRawMetadata("path")
        outputToLog( "%s", path )

        local jpg_version = LrPathUtils.replaceExtension( path, 'jpg' )

        --outputToLog( "%s", jpg_version )
        --outputToLog('Checking for %q',jpg_version)
        if LrFileUtils.exists( jpg_version ) then
          outputToLog("jpg version exists, would remove %s", path)
          if LrFileUtils.moveToTrash( path ) then
            outputToLog("Raw file %s moved successfully to the trash.", filename)
            jpg_ratings[jpg_version] = rating
          else
            outputToLog("Raw file %s could not be moved to the trash.", filename)
          end
        else
          outputToLog("%s", "jpg version does not exists, would do nothing")
        end

      end

      i = i + 1
    end


    -- adding the JPG version to the catalog and
    -- set the rating as it was on the DNG version
    catalog:withWriteAccessDo('ImportJPEGversions', function(context) 
      for path, rating in pairs(jpg_ratings) do 
        --outputToLog("%s",string.format("%q: %q",path,rating) )
        photo = catalog:addPhoto( path )
        if rating > 0 then
          photo:setRawMetadata( "rating", rating )
        end
      end 
      
    end ) 
    if #jpg_ratings > 0 then
      message = string.format( "%q raw photos moved to trash and jpg version imported. Please synch the folder.", #jpg_ratings )
    else
      message = "No raw photos removed."
    end
    LrDialogs.message( "Done", message , "info")


  end

end)
