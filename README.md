# SimpleSelectionMenu

[![CI Status](https://img.shields.io/travis/puneetonly12@gmail.com/SimpleSelectionMenu.svg?style=flat)](https://travis-ci.org/puneetonly12@gmail.com/SimpleSelectionMenu)
[![Version](https://img.shields.io/cocoapods/v/SimpleSelectionMenu.svg?style=flat)](https://cocoapods.org/pods/SimpleSelectionMenu)
[![License](https://img.shields.io/cocoapods/l/SimpleSelectionMenu.svg?style=flat)](https://cocoapods.org/pods/SimpleSelectionMenu)
[![Platform](https://img.shields.io/cocoapods/p/SimpleSelectionMenu.svg?style=flat)](https://cocoapods.org/pods/SimpleSelectionMenu)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SimpleSelectionMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleSelectionMenu'
```

## Author

puneetonly12@gmail.com, Puneet Mahajan

## License

SimpleSelectionMenu is available under the MIT license. See the LICENSE file for more info.

## Usage

// Initialize SelectionController with the parameters
/**
 items: array of string,
 multipleSelection: if you want to select only single item, then pass 'false' and if you want to select multiple    items then pass 'true'
 optional screenTitle: String
 */
let vc = SelectionController(items: ["First", "Second"], multipleSelection: true, screenTitle: "Select Option")

'screenTitle' is optional

// For multiple selection

vc.multipleResult = { items in
    
    for item in items {
        print(item)
    }
}

// For single selection
vc.singleResult = { index, item in
    
    print("Found: \(item) at index: \(index)")
}

let nvc = UINavigationController(rootViewController: vc)
self.present(nvc, animated: true, completion: nil)
