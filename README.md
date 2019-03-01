# DemoApp

  First commit - 3/1/2019 by Jill Scott
  
  This is a Demo Application meant to serve as a standard for future projects. It will include app architecture as well as step-by-step instructions on starting a project, submitting to the app store, and various other general project related tasks.
  
## Project requirements
- Xcode 9.x
- CocoaPods
  
## General Project Setup
1. clone this repo
2. cd inboard-ios
3. pod install
4. open DemoApp.xcworkspace
  
  
# CocoaPods
  
## Adding CocoaPods to a Project
  
CocoaPods is used to install and manage dependencies in existing Xcode projects.
1. Create an Xcode project, and save it to your local machine.
2. Open terminal and cd to the directory containing podfile. ($ cd <path-to-project>/project/) This file defines your project's dependencies, and is commonly referred to as a Podspec.
4. Run command pod init
3. Open Podfile, and add your dependencies. A simple Podspec is shown here: 
  
  #Uncomment the next line to define a global platform for your project\
  platform :ios, '9.0'
  
  #Comment the next line if you're not using Swift and don't want to use dynamic frameworks\
  use_frameworks!
  
  #ignore all warnings from all pods\
  inhibit_all_warnings!
  
  target "DemoApp" do  \
  #Pods for DemoApp  \
  pod 'PromiseKit'  \
  pod 'Kingfisher'  \
  pod 'RxSwift'  \
  end  

4. Save the file.
 
5. Run the pod install command. This will install the SDKs specified in the Podspec, along with any dependencies they may have.\  $ pod update
  
6. Open your app's .xcworkspace file to launch Xcode. Use this file for all development on your app
  
  Note: Sometimes Cocoapods provides the warning target overrides the `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES`... To fix this, go to project settings in xcode, find the app target that says "Yes" in this build setting, and change to other... $(inherited)\
  Note: I was having issues with a framework not recognizing a pod. A pod repo update fixed the issue.\
  Note: Another problem I encountered was targets overriding Framework Search Paths and Heading Search Paths. All targets should have $(inherited) for these settings; Framework should also have $(PROJECT_DIR)
  
  
# GitHub
  
## Starting a project

1. Create a new repo in github. In the Create a new repository page, check the box to initialize with a readme and select "Swift" in "Add .gitignore". Update the readme for a first commit.
2. Clone the project to your local machine. The steps that follow detail this process using Tower, the source control GUI.

3. In terminal, cd to the directory where your project is located and do a git init
4. Drag the project folder to tower
5. In Github, go to Clone or download and copy the provided url using SSH key and passphrase.
6. In Tower, open local repo and go to Repository -> Add new remote repository. Paste the URL to connect project to remote.
7. Pull master, then branch off and publish any local changes.
  Note: Sometimes Git doesn't recognize gitignore changes right away. Run these lines through the terminal (stash changes you want to keep first):\
  git rm -r --cached .\
  git add .\
  git commit -m "fixed untracked files"

# Project Maintenance

# Commits

Git Tower documentations provides these rules for commits. They apply to our projects.\
https://www.git-tower.com/learn/git/ebook/en/command-line/basics/working-on-your-project

## THE GOLDEN RULES OF VERSION CONTROL
## No. 1: Commit Only Related Changes

When crafting a commit, it's very important to only include changes that belong together. You should never mix up changes from multiple, different topics in a single commit. For example, imagine wrapping both some work for your new login functionality and a fix for bug #122 in the same commit:
- Understanding what all those changes really mean and do gets hard for your teammates (and, after some time, also for yourself). Someone who's trying to understand the progress of that new login functionality will have to untangle it from the bugfix code first.
- Undoing one of the topics gets impossible. Maybe your login functionality introduced a new bug. You can't undo just this one without undoing your work for fix #122, also! \
Instead, a commit should only wrap related changes: fixing two different bugs should produce (at the very least) two separate commits; or, when developing a larger feature, every small aspect of it might be worth its own commit. Small commits that only contain one topic make it easier for other members of your team to understand the changes - and to possibly undo them if something went wrong.

## No. 2: Write Good Commit Messages

Time spent on crafting a good commit message is time spent well: it will make it easier to understand what happened for your teammates (and after some time also for yourself).
Begin your message with a short summary of your changes (up to 50 characters as a guideline). Separate it from the following body by including a blank line. The body of your message should provide detailed answers to the following questions: What was the motivation for the change? How does it differ from the previous version?

## No. 3: Use Branches Extensively

Branching is one of Git’s most powerful features – and this is not by accident: quick and easy branching was a central requirement from day one. Branches are the perfect tool to help you avoid mixing up different lines of development. You should use branches extensively in your development workflows: for new features, bug fixes, experiments, ideas…

## No. 4: Never Commit Half-Done Work

You should only commit code when it’s completed. This doesn’t mean you have to complete a whole, large feature before committing. Quite the contrary: split the feature’s implementation into logical chunks and remember to commit early and often. But don’t commit just to get half-done work out of your way when you need a "clean working copy". For these cases, consider using Git’s “Stash” feature instead.

# Pull Requests

## Rebase Steps

1. Create new branch from existing branch that you’ve finished working on
2. Checkout that branch, go to Working copy -> rebase
3. Rebase off develop
4. Create pull request for that branch
5. Delete old branch if necessary

# Localization

## Localization Update Script

I wrote a script to make localization a little simpler. These steps assume you have a Google sheets doc with codes corresponding to strings in different languages, organized by columns headed by the language code.

localization_update.py is located in the scripts folder in the main directory. To update localization.strings files using this script, export localization from Google sheets as json and put this file in the scripts folder:

1. To build formatted locale data, start by exporting the latest locale data in the Google document.

2. Open the export menu in the document, through the the Add-ons > Export Sheet Data > Open Sidebar from the toolbar. Install the plugin if prompted to enable export.

3. Select Current Sheet Only, and check Force string values, name file textStrings.json, and Export. If the export fails, use Visualize and copy the data into the locale-unformatted.json in the iAqualink\scripts folder.

Run the script using terminal, using the following:

1. preface file with Python3. Python 3 will need to be installed (to do so, go here: https://www.python.org/downloads/):
$ Python3 update_localization.py
2. without anything supplied for optional arguments, script runs with the following defaults:
- update all languages that have .lproj folders
- only search the default directory (iAqualink) for these folders
3. required arguments include:
--file "[filename].json" (specify file name for the json to be read from)
4. other arguments include:\
--userpath "[pathname]"  (specify path to search for .lproj folders)\
--file "[filename].json" (specify file if named something other than textStrings.json)\
flagging any of the following to specify which languages to update (if flagging specific languages, ONLY those\ languages will be updated):\
--EN (update English)\
--DE (update German)\
--ES (update Spanish)\
--FR (update French)\
--IT (update Italian)\
--NL (update Dutch)\
--PT (update Portuguese)

## Storyboards

1. Go through each scene in the storyboard to locate objects with strings
2. Identify whether each string is already present in the “Text Strings - iAqualink” sheet on Drive. If not, add the string to the end of the list. If needed, use Google Translate to provide a temporary translation. Give the string a unique key.
3. This key will, in most cases, be added to the object’s “User-Defined Runtime Attributes”
4. Select the object. Most objects (buttons, labels, etc.) will have one string. In the Identity Inspector, add a new Runtime Attribute. Key Path = localizedKey. Type = String. Value = the key you defined for that string in the Google Sheet.
5. Some objects require their own steps for localization:
- For Segmented Control, there is one string per segment. Follow the steps above, but for the “Value” section of the Runtime Attribute, put each string’s corresponding key, separated by commas. (E.g., for a segmented control with “Shared” and “Dual”, your Runtime Attribute Value may read “shared,dual”).
- For table section headers and footers, you must edit the code directly. Identify the section of the table with the header or footer. Sections are numbered starting at 0. Navigate to the scene’s View Controller. Add the following code, entering appropriate values where necessary. The case # should correspond to the section with the header/footer. Cases without a header/footer can return nil:

extension [NameOfViewController]{\
override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {\
switch section {\
case 0:\
return NSLocalizedString(“[key for string in footer]”, comment: "")\
default:\
return nil\
}\
}

override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {\
switch section {\
case 0:\
return NSLocalizedString(“[key for string in header]”, comment: "")\
default:\
return nil\
}\
}\
}\

## Programatic

1. Identify user-facing strings in the swift file.
2. If the string is not already in the “Text Strings - iAqualink” sheet, add it to the sheet. Give the string a unique key.
3. If the String is a String literal without any read-in values, replace the string in the code with NSLocalizedString(“[key for string]”, comment: “”).
4. If instead the string includes any values, use string specifiers, for example, String(format: NSLocalizedString(“[key for string]”, comment: “”), [variable]). The string in the Google sheet should correspondingly read, “[Desired string] %s”.
