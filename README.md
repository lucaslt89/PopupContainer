# PopupContainer

[![CI Status](http://img.shields.io/travis/Lucas/PopupContainer.svg?style=flat)](https://travis-ci.org/Lucas/PopupContainer)
[![Version](https://img.shields.io/cocoapods/v/PopupContainer.svg?style=flat)](http://cocoadocs.org/docsets/PopupContainer)
[![License](https://img.shields.io/cocoapods/l/PopupContainer.svg?style=flat)](http://cocoadocs.org/docsets/PopupContainer)
[![Platform](https://img.shields.io/cocoapods/p/PopupContainer.svg?style=flat)](http://cocoadocs.org/docsets/PopupContainer)

## NOTE

Since Version 0.0.2 is adapted to Swift 1.2. If you want to use this library with previous Swift versions, force the pod version to 0.0.1

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Before using PopupContainer, import the module to your file:

    import PopupContainer

To create a popup, use any UIView you have created, either from Xib or from code, and then do

    PopupContainer.generatePopupWithView(yourView).show()

To close a popup, just call close() function of PopupContainer.

    class ViewController: UIViewController {
        var aPopupContainer: PopupContainer?

        @IBAction func showFromXibButtonPressed(sender: AnyObject) {
            let xibView = NSBundle.mainBundle().loadNibNamed("XibPopup", owner: nil, options: nil)[0] as XibPopup
            self.aPopupContainer = PopupContainer.generatePopupWithView(xibView)
            self.aPopupContainer?.show()
        }

        func closePopup() {
            self.aPopupContainer?.close()
        }
    }

## Requirements

iOS 8.0+

## Installation

PopupContainer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "PopupContainer"
    
## Examples

This screenshots were taken from the example project:

Portrait:

![Portrait popup small](https://github.com/lucaslt89/PopupContainer/blob/master/Screenshots/1.jpg)
![Protrait popup big](https://github.com/lucaslt89/PopupContainer/blob/master/Screenshots/2.jpg)

Landscape:

![Landscape popup small](https://github.com/lucaslt89/PopupContainer/blob/master/Screenshots/3.jpg)
![Landscape popup big](https://github.com/lucaslt89/PopupContainer/blob/master/Screenshots/4.jpg)

## Author

Lucas Diez de Medina @ Technopix Argentina, lucas.diez@technopix.com.ar


