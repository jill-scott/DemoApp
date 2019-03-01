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
  
  #Uncomment the next line to define a global platform for your project
  platform :ios, '9.0'
  
  #Comment the next line if you're not using Swift and don't want to use dynamic frameworks\
  use_frameworks!
  
  #ignore all warnings from all pods
  inhibit_all_warnings!
  
  target "DemoApp" do  
  #Pods for DemoApp  
  pod 'PromiseKit'  
  pod 'Kingfisher'  
  pod 'RxSwift'  
  end  

4. Save the file.
 
5. Run the pod install command. This will install the SDKs specified in the Podspec, along with any dependencies they may have.  $ pod update
  
  
  
6. Open your app's .xcworkspace file to launch Xcode. Use this file for all development on your app
  
  Note: Sometimes Cocoapods provides the warning target overrides the `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES`... To fix this, go to project settings in xcode, find the app target that says "Yes" in this build setting, and change to other... $(inherited)
  Note: I was having issues with a framework not recognizing a pod. A pod repo update fixed the issue.
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
  Note: Sometimes Git doesn't recognize gitignore changes right away. Run these lines through the terminal (stash changes you want to keep first):
  git rm -r --cached .
  git add .
  git commit -m "fixed untracked files"
