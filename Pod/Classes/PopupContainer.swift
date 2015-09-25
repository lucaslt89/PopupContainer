// PopupContainer.swift
//
// Copyright (c) 2015 Technopix ( http://www.technopix.com.ar )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

private let kDialogViewCornerRadius : CGFloat = 3

public class PopupContainer: UIView {
    
    let kMotionEffectExtent : CGFloat = 10

    var dialogView : UIView!
    
    public class func generatePopupWithView(view: UIView) -> PopupContainer{
        let popupContainer = PopupContainer()
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(
            popupContainer,
            selector: "interfaceOrientationChanged:",
            name: UIDeviceOrientationDidChangeNotification,
            object: nil)
        
        popupContainer.dialogView = view;
        popupContainer.dialogView.layer.cornerRadius = kDialogViewCornerRadius
        
        return popupContainer;
    }
    
    // MARK: - Initialization and deinitialization methods
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
    }
    
    // MARK: Setup UI methods
    
    func applyMotionEffects() {
        let horizontalEfect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalEfect.minimumRelativeValue = -kMotionEffectExtent
        horizontalEfect.maximumRelativeValue = kMotionEffectExtent
        
        let verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = -kMotionEffectExtent
        verticalEffect.maximumRelativeValue = kMotionEffectExtent
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalEfect, verticalEffect]
        
        self.dialogView.addMotionEffect(motionEffectGroup)
    }
    
    func interfaceOrientationChanged(notification: NSNotification) {
        var rotationAngle : CGFloat = 0
        
        switch UIApplication.sharedApplication().statusBarOrientation {
        case .LandscapeLeft: rotationAngle = CGFloat(M_PI_2) * 3
        case .LandscapeRight: rotationAngle = CGFloat(M_PI_2)
        case .Portrait: rotationAngle = 0
        case .PortraitUpsideDown: rotationAngle = CGFloat(M_PI)
        default: rotationAngle = 0
        }
        
        UIView.animateWithDuration(
            0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                let window = UIApplication.sharedApplication().delegate!.window!
                self.center = CGPointMake(window!.frame.size.width / 2, window!.frame.size.height / 2)
                if self.isInIOS8() == false {
                    self.transform = CGAffineTransformMakeRotation(rotationAngle)
                }
            }, completion: nil)
    }
    
    // MARK: - Interaction Methods
    
    public func show() {
        self.applyMotionEffects()
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let largerSide = screenWidth > screenHeight ? screenWidth : screenHeight
        
        //For the black background
        self.frame = CGRectMake(0, 0, largerSide * 2, largerSide * 2)
        
        self.dialogView.layer.opacity = 0.5
        self.dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.0)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        self.addSubview(self.dialogView)
        
        self.dialogView.center = self.center
        
        let window = UIApplication.sharedApplication().delegate!.window!
        window?.addSubview(self)
        self.center = CGPointMake(window!.frame.size.width / 2, window!.frame.size.height / 2)
        
        let interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        switch (interfaceOrientation) {
        case .LandscapeLeft: self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2) * 3)
        case .LandscapeRight: self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        case .Portrait: self.transform = CGAffineTransformMakeRotation(0)
        case .PortraitUpsideDown: self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        default: break;
        }
        
        // iOS8 Fix: Transformations are applied only in an animation block. Don't know why...
        if self.isInIOS8() {
            UIView.animateWithDuration(0.001, animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
    
        UIView.animateWithDuration(
            0.2,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
                self.dialogView.layer.opacity = 1
                self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: nil)
    }
    
    public func close() {
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
        self.dialogView.layer.opacity = 1.0
        
        UIView.animateWithDuration(
            0.2,
            delay: 0.0,
            options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
                self.dialogView.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1)
                self.dialogView.layer.opacity = 0
            }) { (finished: Bool) -> Void in
            self.removeFromSuperview()
        }
    }
    
    func isInIOS8() -> Bool {
        return (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8
    }

}
