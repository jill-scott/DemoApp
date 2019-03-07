# DemoApp

  First commit - 3/1/2019 by Jill Scott
  
  This is a Demo Application meant to serve as a standard for future projects. It will include app architecture as well as step-by-step instructions on starting a project, submitting to the app store, and various other general project related tasks.
  
## Project requirements
- Xcode 9.x
- CocoaPods
  
## General Project Setup
1. clone this repo
2. Install carthage dependency manager. Instructions at: https://github.com/Carthage/Carthage
2. cd DemoApp/DemoApp
3. carthage update
4. open DemoApp.xcodeproj
  
  # Dependency Managers
  
  When it comes to dependency managers, CocoaPods is the most widely used for library distribution. Carthage, however, is much simpler and does not need to rebuild every time. It also does not change project settings. We should use Carthage wherever possible, as CocoaPods tends to cause more merge conflicts and untraceable issues. Carthage takes a long time to install schemes initially, but saves time building in the long run.
  
  Note on using custom frameworks in addition to imported libraries: The library projects themselves must be referenced in the project files. Otherwise they are not built correctly. All dependencies must be established in the build phases for each target. The library projects should be included in the Target Dependencies for the primary app target. Otherwise NOTHING WILL BE FOUND AT RUNTIME. This was a big timesuck to figure out, and is not immediately intuitive. Also make sure to embed frameworks, including the libraries and custom framework targets as needed. See the demo app build phases and library folder for an example of how this is structured.
  
  # Carthage
  
  1. From the Carthage Documentation: https://github.com/Carthage/Carthage
  
  2. Get Carthage by running brew install carthage or choose another installation method
  
  3. Create a Cartfile in the same directory where your .xcodeproj or .xcworkspace is
  
  4. List the desired dependencies in the Cartfile, for example:
  
  github "Alamofire/Alamofire" ~> 4.7.2
  
  5. Run carthage update
  
  6. A Cartfile.resolved file and a Carthage directory will appear in the same directory where your .xcodeproj or .xcworkspace is
  
  7. Drag the built .framework binaries from Carthage/Build/<platform> into your application’s Xcode project.
  
  8. If you are using Carthage for an application, follow the remaining steps, otherwise stop here.
  
  9. On your application targets’ Build Phases settings tab, click the + icon and choose New Run Script Phase. Create a Run Script in which you specify your shell (ex: /bin/sh), add the following contents to the script area below the shell:
  
  /usr/local/bin/carthage copy-frameworks
  
  10. Add the paths to the frameworks you want to use under “Input Files". For example:
  
  $(SRCROOT)/Carthage/Build/iOS/Alamofire.framework
  
  11. Add the paths to the copied frameworks to the “Output Files”. For example:
  
  $(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Alamofire.framework
  
  12. For an in depth guide, read on from Adding frameworks to an application
  
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
 
5. Run the pod install command. This will install the SDKs specified in the Podspec, along with any dependencies they may have.  $ pod update
  
6. Open your app's .xcworkspace file to launch Xcode. Use this file for all development on your app
  
  Note: Sometimes Cocoapods provides the warning target overrides the `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES`... To fix this, go to project settings in xcode, find the app target that says "Yes" in this build setting, and change to other... $(inherited)\
  Note: I was having issues with a framework not recognizing a pod. A pod repo update fixed the issue.\
  Note: Another problem I encountered was targets overriding Framework Search Paths and Heading Search Paths. All targets should have $(inherited) for these settings; Framework should also have $(PROJECT_DIR)
  
## Signing Certs and Bitrise - May need revisiting

Signing Certificates:

There are a few places we need to tinker with to get our app ready for distribution. Assuming we are using bitrise for deployment, these are:

- Keychain access
- Xcode
- Apple developer accounts
- Bitrise
- and indirectly, Github

A developer provisioning profile with a matching signing certificate should be enough for a bitrise build, but if we want to use bitrise.io for deployment, we need to use a distribution profile and cert.

On developer.apple.com, access account, and certificates. If we do not already have a distribution cert, create one for use in our app. Now move to Provisioning profiles section. Create a new provisioning profile for in house distribution. It should use our enterprise account and the distribution cert we just created (or that we already have). Download both the cert and the provisioning profile.

In xcode, go to preferences to manage our accounts. Add the necessary accounts and certs for development and distribution.

Downloaded certs should be accessible in the keychain, and available for export. When you export the certificate, leave the password blank. This will let the bitrise build work as intended. Return to bitrise and in workflow -> code signing, upload the provisioning profile you downloaded and the matching cert you exported.

For any builds to work, let alone deployment, your bitrise account must be connected to your project. Avoid linking the two through SSH keys in a personal github account. Rather, an admin on the github repo should add the SSH key to the repo settings.

Kicking off a build with a Pull Request:

To trigger a build in bitrise on a PR, go to Bitrise code and add a new github webhook. A github project admin will need to add this to the settings of the repo, and select “push” and “pull request” in the events. In the workflow -> triggers, add the repo events you want to trigger a build
  
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

## Merging into Master

1. Save stash with changes
2. Pull latest code from master
3. Apply stash and resolve any conflicts or rebase as needed
4. Check your xcode build warnings. The project should have none! This includes linter warnings, which can be helpful for finding mistakes that could turn into bugs before they happen.
5. Do your due diligence; check your new feature by running on a real iPhone
6. Make a pull request on github
7. Get one of your teammates to review your code for the feature and approve your PR.
8. Squash and merge to master
9. Delete old branch from repo

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
}

## Programmatic

1. Identify user-facing strings in the swift file.
2. If the string is not already in the “Text Strings - iAqualink” sheet, add it to the sheet. Give the string a unique key.
3. If the String is a String literal without any read-in values, replace the string in the code with NSLocalizedString(“[key for string]”, comment: “”).
4. If instead the string includes any values, use string specifiers, for example, String(format: NSLocalizedString(“[key for string]”, comment: “”), [variable]). The string in the Google sheet should correspondingly read, “[Desired string] %s”.

## Accessibility

For storyboard text:

- Font should be one of the stylized fonts, e.g., Subhead or Body
- Lines should be 0
- Automatically Adjusts Font should be checked
- Line break should be word wrap
- If content is in code, it should be wrapped with AppStr
- If content is in storyboard, user runtime attribute should be added

## Sources

- Example source code is based upon the book, https://www.raywenderlich.com/8477-introducing-advanced-ios-app-architecture
- Using Subjects/Variables - BehaviorSubject has a wrapper that works best for use in the iOS UI called Variable (compile-time guarantees, executes in main thread, etc.). The Variable is going to be deprecated (see [here](https://medium.com/koolicar-engineering/rxswift-behaviorrelay-over-variable-182865ce10e0 "Deprecated Variable")), and its replacement in RxSwift 4.x and above is BehaviorRelay.
