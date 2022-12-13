# G2L_Asset_Selector

Assets selection widget for imguigml allowing to scan existing assets (object, sprite, audio, shader…), display them in a sortable list and allow user to pick one.



### Use case
I build a simple user interface on top of Evoleo’s LDtk parser. https://github.com/evolutionleo/LDtkParser
In the process, I included a Selector feature that would allow the user to choose an object, a level or a tileset from Game Maker project to define conversion mappings between LDtk and Game Maker (mappings dictate rules like ‘this LDtk entity should convert to that Game Maker object’…). The list would scan all assets existing in the currently running project to prevent any error in defining mappings. My code became quite hard to follow so I decided to package this in an imguigml widget, to extend its features (adding sorting and filtering options) and to share it with whoever is interested.
 

### Feature
Asset_Selector is quite straightforward, it is set on a specific asset_type.
From there, it will display the list of all the assets associated to that type. Clicking an asset in the list will return an array with two values “à la” imguigml. The first one is a Boolean that will be true when user clicks an item in the list. The second is the asset_index associated to the clicked item.

Above the list, two buttons [Az] and [Za] allow to sort the list alphabeticaly (ascending and descending) and an input field allows to filter the list on items containing the specified string (case INsensitive).
Due to the memory limit of imguigml_list_box, the list is split in pages. You can navigate with [0] [1] [x] wich will bring you to the associated page.
The number of items per page is defined by the G2L_ITEMS_PER_PAGE #macro.

If you have enabled it when creating the Selector, a combo box will be displayed below the list to allow the user to change the asset_type, which will rescan the assets accordingly.
Asset_Selector supports : object, sprite, audio, shader, (script not really), tileset, room, animcurve, sequence. All of them are scanned in the running project, except for layer that will scan layers in the current room.
 

### License
G2L is fully free. Do whatever you want with it.
 

### Version and Platform
G2L is tested on Game Maker LTS and on windows platform.
 

### Installation
G2L_Asset_Selector is just one class.
If you already have imguigml in your project, you can just copy the code for this class from G2L_Asset_Selector script and paste it into any script of your project.
If you need to import both imguigml and G2L_Asset_Window, you can import the bundle as a local package in your Game Maker project.
- Download the .yymp file from GITHUB.
- Import it inside your project. You can do this by dragging the *. yymp file from an explorer window onto the GameMaker IDEor by clicking "Import Local Package" within the Tools Menu. In both case, a window will pop up to define import parameters. Click “add all” and “OK”. This will create a new folders in your Asset Browser labeled “G2L”. You are all set.
Do not forget the include file which is imguigml font. 

### How to use
Create a struct of the Asset Selector class, the first argument defines the asset type (using asset_xx constant from Game Maker), the second argument, when set to true, allows user to change the asset type anytime.
Call the imguigml_step() method for this struct (exactly like you would do when calling imguigml_combo() or imguigml_list_box())
This method will return an array [change, index]
- change: true/false, true when an item is selected in the list
- index : asset_index of the selected item
You can then use this in your code for example to play the associated sound, set an instance’s sprite to the associated asset, navigate to a specific room…

Please remember; Asset Selector requires imguigml and imguigml_step() needs to be called within your imguigml instructions.
 
Example:
>// Create event:
>
>my_window = new G2L_Asset_Window();
>
>//  Imguigml instructions – in the step event of your code
>
>Var _ret = my_window.imguigml_step()
>
>If _ret[0] show_debug_message(“You clicked asset with index “ + string(_ret[1]));


### Behind the hood – how does it work
This is really little.
I relies on Rousr's imguigml for the user interface part. imguigmgl is a wrapper of dearimgui library that allows to build user interface in no time. You can download it here: https://imguigml.rou.sr/
I got the idea for Asset Selector from Hyomoto asset_scan script. https://github.com/Hyomoto/ImguiGMLWrapper/blob/b636082fc035b2df8fbd63e06ee5393709add849/scripts/assets_scan/assets_scan.gml
From their concept, I hardcoded all existing asset_types to allow to scan anything.
The results are stored in two datasets, instead of repreocessing the scan, the filtering and the sorting every step:
- an array of asset_names for the current page which is required by imguigml_list_box and convenient for sorting and filtering.
- a struct linking asset_names to the asset_id and a display flag. So all the code work with names and convert to asset_id when returning the clicked ite. The displya flag is there to save the filtered assets and only serve those to imguigml_list_box.

To prevent any lag, the scan is processed in multiple step. Each step processes a bucket of 1 000 id. You can change this with the associated G2L_SCAN_PER_STEP #macro.
I build pages to stay under imguigml memory limitation for imguigml_list_box(), so only 100 assets names are displayed at a time.
