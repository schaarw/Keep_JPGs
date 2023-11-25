--[[----------------------------------------------------------------------------

Info.lua
Summary information for Keep JPGs plug-in.

Adds menu items to Lightroom.

------------------------------------------------------------------------------]]

return {
	
	LrSdkVersion = 3.0,
	LrSdkMinimumVersion = 1.3, -- minimum SDK version required by this plug-in

	LrToolkitIdentifier = 'com.github.schaarw.keep_jpgs',

	LrPluginName = LOC "$$$/RemoveRaw/PluginName=Keep JPEGs",
	
	-- Add the menu item to the File menu.
	
	LrExportMenuItems = {
		title = "Keep JPGs",
		file = "Keep_JPGs.lua",
	},

	-- Add the menu item to the Library menu.
	
	LrLibraryMenuItems = {
		{	title = LOC "$$$/Keep_JPGs/Keep_JPGs=Keep JPGs",
			file = "Keep_JPGs.lua",
		},
	},
	VERSION = { major=13, minor=0, revision=0, build="202309270914-5a1c6485", },

}


	
