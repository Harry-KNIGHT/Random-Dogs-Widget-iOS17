# Widget-with-button-iOS17

Welcome to **Random Dogs**, your gateway to enjoying adorable dog images right on your iOS 17 home screen!

Thanks to the new iOS 17 widget feature called AppIntent, we've added a special twist – buttons to widgets!

<img src="https://github.com/Harry-KNIGHT/ImageGifVideoForReadme/blob/main/gifs/RandomDog.gif" width="200">

## Table of Contents
- [Apple Documentation](#apple-documentation)
- [Acknowledgments](#acknowledgments)
- [Special Thanks](#special-thanks)
- [Technical Documentation](#technical-documentation)
    - [DogApi](#dogapi)
    - [Widget Extension](#widget-extension)

## Apple Documentation
Explore the [Apple Doc](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities) and [Apple WWDC video](https://developer.apple.com/wwdc22/10032) for more details on adding interactivity to widgets and live activities.


## Acknowledgments
We extend our gratitude to the Dog API for generously allowing us to use their API for free. Discover their offerings at [Dog API](https://dog.ceo/dog-api/).

## Special Thanks
A big shoutout to Baptiste D. for being an inspiration in this subject, and Mickaël M. for diving into the WWDC videos and documentation with me.

## Technical Documentation

### DogApi
**DogApi** is a Swift package designed to fetch data from remote URLs. This architectural choice helps us consolidate code for API calls across the main app and the widget extension, ensuring code efficiency.


In anticipation of potential future requirements, we've kept the door open for further expansion with an **ApiManager**, though currently, we employ a simple approach since only one API request is required. This approach is implemented through **DogService**, which provides an interface for our implementation.

We have **DogServiceDefault** for live data and **DogServiceDefaultMock** for unit testing with JSON mocked data.

### Widget Extension
Creating the widget extension was a straightforward process. We opted for a classic widget setup without selecting any additional options during creation.

To add the button, we followed Apple's guidelines as outlined in their [documentation](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities). Here's the essential code snippet:

```swift
Button(intent: DogSearch()) {
  Image(systemName: "shuffle")
    .foregroundStyle(.white)
    .font(.title3)
    .frame(maxWidth: .infinity)
}
```

Feel free to dive into the code and reach out to us with any questions or feedback on [LinkedIn](https://www.linkedin.com/in/elliot-knight-134679182/).

Enjoy your widget and the delightful world of random dogs on your iOS 17 home screen! 🐾



