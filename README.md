# NASA-Rovers
### Description
This app shows the most recent photos of NASA's rovers(curiosity, opportunity, spirit). It uses the web service https://api.nasa.gov/mars-photos/api/v1 to provide its data, and all is done using the architecture Clean Swift https://clean-swift.com/.

## Platform
iOS
- Minimum Version: 11.0

## Configuration
To manage the dependencies of the project was used [Cocoa Pods](https://cocoapods.org/).

First, it's necessary to clone the project.

`- git clone https://github.com/cardoso19/NASA-Rovers.git`

If you don't have Cocoa Pods installed on your computer yet, run the code below on the terminal to install it:

`sudo gem install cocoapods`

After the project had been cloned, inside of the generated directory, using Terminal execute the command:

`pod install`

With the dependencies management has been made by Cocoa Pods, to run the project you need to open it by clicking on the file NASA Probes.xcworkspace.

## Third-party Libraries Used
- [Alamofire](https://github.com/Alamofire/Alamofire): Was chosen by his easy utilization and for his reliability with requests on all of the kind of types. It was used on each request that the app does to the backend.
