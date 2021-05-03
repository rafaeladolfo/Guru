# Guru

Guru challenge source code

### Stack
* Using SwiftUI 
* MVVM
* Localization

### Features
* Get stories feed from GuruAPI(based on supplied json)
* Opens the page using Safari view with readers mode enabled
* Carousel with progressbar for images
* Switch view context based on state (idle, loading, error, success)
* Using haptics

###
* Localizable strings for En-US and Pt-BR
* Strings in constant enum to avoid typo's:

```
enum LocalizationUtil {
    enum String {
        static let loading = NSLocalizedString("Loading", comment: "Message displayed when loading view is presented")
    }
}
```
