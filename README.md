![MainImage](https://github.com/roshiki/RsDevPanel/assets/9011106/17231617-0808-4426-a810-a26cb803a50b)

![Platform](https://img.shields.io/badge/platform-iOS-white)
![SPM compatible](https://img.shields.io/badge/SPM-compatible-green)

Dynamic, customizable iOS developer toolbar for rapid development, debugging, and testing.

The panel allows you to embed controls in arbitrary places of the application for quick interaction with the code through the panel interface.

Main purpose: for temporary embedding and debugging. But it can also be used as a permanent solution, or as part of an existing debug menu you already have. Some additional functionality for static integration is planned for future releases.

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate RSDevPanel into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/roshiki/RsDevPanel.git", .upToNextMajor(from: "1.0.0"))
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate RSDevPanel into your project manually.

In development: you can also connect the developer panel all-in-one file: RSDevPanelAll.swift (if your project already has a SnapKit connected)

## What does it look like
![RSDevPanelLook](https://github.com/roshiki/RsDevPanel/assets/9011106/fc2e6170-2176-458b-90e9-dfe869600b3f)

## Elements

### Basic elements

A basic set of elements is provided, such as:

| Descriprion | Class |
| ----------- | ----------- |
|Button|RSDevPanelButtonElement|
|Group of horizontal buttons|RSDevPanelKeysElement|
|Numeric value selection slider|RSDevPanelSliderElement|

### Creating custom elements

You can implement your own elements by extending the appropriate RSDevPanelBaseElement class. For example... an element for displaying the latest news without breaking away from development!

Read more in the section "Creating your own element"

## Usage

### Quick Start

```swift
import RSDevPanel

class SomeClass: UIViewController {
    override func viewDidLoad() {
        RSDevPanel.add(.button(.init(title: "Say hello", action: {
            print("Hello")
        })), self)
        RSDevPanel.shared.simpleStorage["name"] = "Joen Doe"
        RSDevPanel.add(.button(.init(title: "Print name", action: {
            print(RSDevPanel.shared.simpleStorage["name"])
        })), self)

        // Show panel
        RSDevPanel.shared.toggleShow()
    }
}
```
### Showing and hiding the panel
```
RSDevPanel.shared.show()
RSDevPanel.shared.hide()
RSDevPanel.shared.toggleShow()
RSDevPanel.shared.isVisible // get current status
```

### Data storage 

Temporary data storage (in application memory) for configuring your logic

```swift
// Set
RSDevPanel.shared.simpleStorage["name"] = "Totoro"
RSDevPanel.shared.simpleStorage["model"] = Person()
RSDevPanel.shared.simpleStorage["isHidden"] = true

// Get
let name = RSDevPanel.shared.simpleStorage["name"] as? String
let model = RSDevPanel.shared.simpleStorage["model"] as? Person
let isHidden = RSDevPanel.shared.simpleStorage["isHidden"] as? Bool
```

### Alternative Methods

```swift
// The shortest method without alias
RSDevPanel.add(.button(.init(title: "Title", action: {
    print("action")
})), self)

// Same thing, but adding an array of elements
RSDevPanel.add([
    // elements:
    // .button
    // .button
], self)

// You can use an alias for RSDevPanel
RSDP.add(.button(.init(title: "Title", action: {
    print("action")
})), self)

// Complete method for adding an element
RSDevPanel.shared.addElement(RSDevPanelButtonElement(RSDevPanelButtonElementConfig(title: "Title", action: {
    print("action")
}), holder: self))

// Same thing, but adding an array of elements
RSDevPanel.shared.addElements([
    // elements
    // RSDevPanelButtonElement.init
    // RSDevPanelButtonElement.init
])
```

## Creating your own element

```swift
class MyTotoro: RSDevPanelBaseElement {
    override var id: String { "totoro" }

    private let view: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "\nI am your Totoro!\nThis is a user-created element.\n"
        return label
    }()

    override func getView() -> UIView {
        view
    }
}

// Additionally, you can extend the RSDevPanelFastAdd class to quickly add an element
extension RSDevPanelFastAdd {
    static func myTotoro() -> RSDevPanelFastAdd {
        let element = MyTotoro(holder: nil)
        return Self(element: element)
    }
}
```
Result:

![RSDevPanelMyTotoro](https://github.com/roshiki/RsDevPanel/assets/9011106/917d1b11-dc7e-4404-916e-767b7da9b316)

## Requirements

- iOS 14.0+
- Swift 5.0+



