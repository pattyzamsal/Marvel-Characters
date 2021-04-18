# Marvel-Characters
This is a repository with an app that shows a list of marvel characters and where you can access the details of each of them

![appExampleToRepository](https://user-images.githubusercontent.com/4505476/115136981-f1081580-9fe8-11eb-8c4f-7b6f63110b57.gif)

## Dependencies
You need to install the following tools to run the project:
- [Xcode 12.0 or newer](https://developer.apple.com/download)
- [HomeBrew](https://brew.sh/)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen#installing)
- [Marvel Account](https://developer.marvel.com/)

## Installation

### Step 1 - Install dependencies
In a terminal run `./build_project.sh` 

### Step 2 - Open the project in Xcode
You can open it using your terminal with this command `open MarvelCharacters.xcodeproj`

### Step 3 - Configurate the project
Follow these steps of the following image:

<img width="1680" alt="Screen Shot 2021-04-11 at 12 44 19 AM" src="https://user-images.githubusercontent.com/4505476/115137783-bce32380-9fed-11eb-8120-ee29b72f14bd.png">

You need to be sure that the target "PROD" have the "PROD.xcconfig" and "STG" have "STG.xcconfig"

### Step 4 - Add your Public and Private Key of your Marvel Account
In Xcode, you need to search following comments:
`// TODO you need to add your own public key here`

`// TODO you need to add your own private key here`
and in that place, you need to paste your keys

**Note:** This management of keys is for protection and security because this keys are vulnerable. This protection doesn't allow to expose the keys for hackers when they try to decompile the app. For this reason, Marvel's API requires to use MD5 for any request.

## How to run
After the installation, you can run the project in Xcode without any problem. Press the play button or press `cmd+R` in your keyboard.

### Architecture
This project uses Clean to do connections with API and use MVP with States and View Models to manage communication between Views and Controllers. For testing: project provides unit tests for each layer in the architecture.

![clean](https://user-images.githubusercontent.com/4505476/115137836-ff0c6500-9fed-11eb-981a-90104bd5d939.jpeg)
![mvvm](https://user-images.githubusercontent.com/4505476/115137891-498de180-9fee-11eb-9d99-0c1e6958fe6c.jpeg)

### Third-party library
All dependencies are managed using Swift Package Manager.

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
