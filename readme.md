# iOs Adidas Challenge

Devoloped with Swift4 using Clean Code

## Installation

I'm using Pods in this project. You don't need to install it, they are inside the repo

## Keep in mind

Don't open __.xcodeproj__ file, open __xcworkspace__ instead. Otherwise, you will come across different compiling issues.

## Features implemented

- SpeechRecognizer to listen to user questions
- Created and configured a Natural Language Recognition application
- Speech to WIT.ai
- Retrieve information from WIT.ai
- Query to a Forecast API
- Retrieve the Forecast information
- Displays the forecast information from his given question
- Displays a message from his given question

## External API's used

- [WIT.ai][1]: for the Natural Language Recognition
- [Darksky][2]: for the Forecast

## Pods

- Pulsator
- ObjectMapper
- Alamofire
- CRNotifications
- ALLoadingView

## TODO's

- Multiple language
- Multiple metric (km/h -> mi/h, ...)

[1]: https://wit.ai/eriscoand/AdidasChallenge
[2]: https://darksky.net/dev