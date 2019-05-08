# NASA-Probes
### Description
This app shows the most recent photos of NASA's rovers(curiosity, opportunity, spirit). It uses the web service https://api.nasa.gov/mars-photos/api/v1 to provide its data.

## Platform
iOS
- Minimum Version: 11.0

## Configuration
To manage the dependencies of the project was used [Cocoa Pods](https://cocoapods.org/).

First, it's necessary to clone the project.

`- git clone https://github.com/cardoso19/NASA-Probes.git`

If you don't have Cocoa Pods installed on your computer yet, run the code below on the terminal to install it:

`sudo gem install cocoapods`

After the project had been cloned, inside of the generated directory, using Terminal execute the command:

`pod install`

With the dependencies managemend has been made by Cocoa Pods, to run the project you need to open it by clicking on the file "NASA Probes.xcworkspace".

## Third-party Libraries Used
- [Alamofire](https://github.com/Alamofire/Alamofire): Was choosed by his easy utilization and for his confiability with request on all of kind of types. It was used on each request that the app do to the backend.