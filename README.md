<!-- Author: Emrah Kinay -->
<a name="readme-top"></a>
<div align="center">
  <a href="https://apps.apple.com/ca/app/active/id6445869038">
        <h3 align="center">Active</h3>
        <p align="center">Drop-In Activities at City of Ottawa Recreation Facilities</p>
  </a>
</div>

## About The Project
Active is a mobile application that allows users to browse and search drop-in activities at City of Ottawa Recreation Facilities.

There is no API provided by the city for the drop-in activities and the data for the application is collected using Python web scraper and published using Spring Boot REST API Server on Docker.


Download the app on [AppStore](https://apps.apple.com/ca/app/active/id6445869038).
<div align="left">
  <a href="https://apps.apple.com/ca/app/active/id6445869038">
    <img src="https://raw.githubusercontent.com/simulacrumus/active-docker/b34e74ed74f9a552ceac620087c1eb40eb67a312/Download_on_the_App_Store_Badge_US-UK_RGB_blk_092917.svg" alt="AppStore Download">
  </a>
</div>

### Built With

* Swift
* SwiftUI

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

Please follow the instructions below to get started with Active.

### Installation
* Clone the repo
    ```sh
    git clone https://github.com/simulacrumus/active-ios
    ```

* Open in Xcode

* Enter your keys in `Production.xcconfig` and `Development.xcconfig` file
    ```conf
    API_HOST = <IP_ADDRESS>
    API_PORT = <PORT>
    API_DEFAULT_PATH = <PATH>
    API_KEY = <API_KEY>
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

Emrah Kinay - [@emrahkinay](https://www.linkedin.com/in/emrahkinay/)

Project Link: [https://github.com/simulacrumus/active-ios](https://github.com/simulacrumus/active-ios)

<p align="right">(<a href="#readme-top">back to top</a>)</p>