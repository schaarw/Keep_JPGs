# Keep JPGs
Keep JPGs is a Adobe Lightroom Classic CC plug-in to remove raw files of low rated photos and stay with the jpeg version. This helps to save disk space and processing time.
Tested successfully with Smartphone JPG+DNG files. You may use the code for your own plugin.

Usage of this plugin at your own risk. Always ensure proper backup of your photos.

# Background
I like to take photos (https://500px.com/p/Wolfgang_Schaar?view=photos) and I'm taking the photos in RAW+JPEG. Only for the good ones I want to keep the raw version. For the vast majority of my fotos JPEG is totally sufficient. 

Recently I switched from Windows to macOS so I couldn't continue to use my powershell script https://github.com/schaarw/copy-raw.

I have exactly the same requirement as explained in https://community.adobe.com/t5/lightroom-classic-discussions/plugin-for-deleting-nef-raw-files-based-on-rating/m-p/5480321. Because I found no existing solution I tried to write a plugin by myself. Here it is. Thanks to https://akrabat.com/writing-a-lightroom-classic-plug-in/ for a introduction to Lightroom plugin creation.

# Installation

Download the latest release from [GitHub Releases page](https://github.com/schaarw/KeepJPGs/releases) and unzip it.

> File -> Plug-in Manager -> Add -> [Pick KeepJPGs.lrdevplugin file]

*NOTE:* Since Adobe Lightroom Classic CC doesn't copy plug-in files on installation to any safe place, you normally should choose a place your not going to delete plug-in file from.
Usually for plugins is used `~/Library/Application\ Support/Adobe/Lightroom/Plugins/` or something like that.

# Usage

You may select one or more photos which are named like photo_name.dng+JPEG. Then 

> Library -> Plug-in Extras -> Keep JPGs

The plugin shows the number of selected fotos and after confirmation each photo is checked if it is available and a JPEG version exists for the RAW photo. If this is the case and the rating is low (default < 3) the RAW version is moved to the trash, the JPEG version is imported into the catalog and the rating is re-applied. Depending on the amount of selected photos it may take a while because the jpeg photo import is done each by each. After finishing a dialog appears.

Usage of this plugin at your own risk. Always ensure proper backup of your photos.