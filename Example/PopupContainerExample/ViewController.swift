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

    @IBAction func showFromXibButtonPressed(_ sender: AnyObject) {
        let xibView = Bundle.main.loadNibNamed("XibPopup", owner: nil, options: nil)?[0] as! XibPopup
        PopupContainer.generatePopupWithView(xibView).show()
    }
    
    @IBAction func showFromCodedUIViewButtonPressed(_ sender: AnyObject) {
        let codedView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        codedView.backgroundColor = UIColor.black
        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        closeButton.center = codedView.center
        closeButton.setTitle("Close!", for: UIControlState())
        closeButton.addTarget(self, action: #selector(ViewController.closePopup), for: UIControlEvents.touchUpInside)
        codedView.addSubview(closeButton)
        
        self.aPopupContainer = PopupContainer.generatePopupWithView(codedView)
        self.aPopupContainer?.show()
    }
    
    func closePopup() {
        self.aPopupContainer?.close()
    }
}

