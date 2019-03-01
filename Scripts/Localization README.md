## Localization Update Script Notes
localization_update.py is located in the scripts folder in the iaqualink-ios folder. To update localization.strings files using this script, export localization from Google sheets as json and put this file in the scripts folder:

1. To build formatted locale data, start by exporting the latest locale data in the Google document.

2. Open the export menu in the document, through the the Add-ons > Export Sheet Data > Open Sidebar from the toolbar. Install the plugin if prompted to enable export.

3. Select Current Sheet Only, and check Force string values, name file textStrings.json, and Export. If the export fails, use Visualize and copy the data into the locale-unformatted.json in the iAqualink\scripts folder.

Run the script using terminal, using the following:

1. preface file with Python3. Python 3 will need to be installed (to do so, go here: https://www.python.org/downloads/):
    $ Python3 update_localization.py
2. without anything supplied for optional arguments, script runs with the following defaults:
    -update all languages that have .lproj folders
    -only search the default directory (iAqualink) for these folders
3. required arguments include:
    --file "[filename].json" (specify file name for the json to be read from)
4. other arguments include:
    --userpath "[pathname]"  (specify path to search for .lproj folders)
    --file "[filename].json" (specify file if named something other than textStrings.json)
    flagging any of the following to specify which languages to update (if flagging specific languages, ONLY those languages will be updated):
    --EN (update English)
    --DE (update German)
    --ES (update Spanish)
    --FR (update French)
    --IT (update Italian)
    --NL (update Dutch)
    --PT (update Portuguese)

##Localiztaion Method Notes
Localize User-Facing Text


Storyboards

1. Go through each scene in the storyboard to locate objects with strings
2. Identify whether each string is already present in the “Text Strings - iAqualink” sheet on Drive. If not, add the string to the end of the list. Give it a unique key.
3. This key will, in most cases, be added to the object’s “User-Defined Runtime Attributes”
Select the object. Most objects (buttons, labels, etc.) will have one string. In the Identity Inspector, add a new Runtime Attribute. Key Path = localizedKey. Type = String. Value = the key you defined for that string in the Google Sheet.
4. Some objects require their own steps for localization:
--For Segmented Control, there is one string per segment. Follow the steps above, but for the “Value” section of the Runtime Attribute, put each string’s corresponding key, separated by commas. (E.g., for a segmented control with “Shared” and “Dual”, your Runtime Attribute Value may read “shared,dual”).
--For table section headers and footers, you must edit the code directly. Identify the section of the table with the header or footer. Sections are numbered starting at 0. Navigate to the scene’s View Controller. Add the following code, entering appropriate values where necessary. The case # should correspond to the section with the header/footer. Cases without a header/footer can return nil:

extension [NameOfViewController]{
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return NSLocalizedString(“[key for string in footer]”, comment: "")
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return NSLocalizedString(“[key for string in header]”, comment: "")
        default:
            return nil
        }
    }
}

Swift Files

1. Identify user-facing strings in the swift file.
2. If the string is not already in the “Text Strings - iAqualink” sheet, add it to the sheet. Give the string a unique key.
3. If the String is a String literal without any read-in values, replace the string in the code with NSLocalizedString(“[key for string]”, comment: “”).
4. If instead the string includes any values, use string specifiers, for example, String(format: NSLocalizedString(“[key for string]”, comment: “”), [variable]). The string in the Google sheet should correspondingly read, “[Desired string] %s”.
