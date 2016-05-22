//
//  ViewController+TextFieldBehavior.swift
//  Meme Me
//
//  Created by Edwin Chia on 23/5/16.
//  Copyright © 2016 Edwin Chia. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func setUpTextFields() {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.whiteColor(),
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 38)!,
            NSStrokeWidthAttributeName : 10
        ]
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}