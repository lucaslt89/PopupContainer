//
//  ViewController.swift
//  PopupContainerExample
//
//  Created by Lucas Diez de Medina on 3/12/15.
//  Copyright (c) 2015 Technopix. All rights reserved.
//

import UIKit
import PopupContainer

class ViewController: UIViewController {
    
    var aPopupContainer: PopupContainer?

    @IBAction func showFromXibButtonPressed(sender: AnyObject) {
        let xibView = NSBundle.mainBundle().loadNibNamed("XibPopup", owner: nil, options: nil)[0] as! XibPopup
        PopupContainer.generatePopupWithView(xibView).show()
    }
    
    @IBAction func showFromCodedUIViewButtonPressed(sender: AnyObject) {
        let codedView = UIView(frame: CGRectMake(0, 0, 100, 100))
        codedView.backgroundColor = UIColor.blackColor()
        let closeButton = UIButton(frame: CGRectMake(0, 0, 80, 50))
        closeButton.center = codedView.center
        closeButton.setTitle("Close!", forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closePopup", forControlEvents: UIControlEvents.TouchUpInside)
        codedView.addSubview(closeButton)
        
        self.aPopupContainer = PopupContainer.generatePopupWithView(codedView)
        self.aPopupContainer?.show()
    }
    
    func closePopup() {
        self.aPopupContainer?.close()
    }
}

