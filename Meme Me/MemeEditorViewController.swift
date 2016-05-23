//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Edwin Chia on 22/5/16.
//  Copyright © 2016 Edwin Chia. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    var memedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = false
        setUpTextField(topTextField)
        setUpTextField(bottomTextField)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        // Suscribe to the keyboard notification, to allow the view to raise when necessary
        suscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        unsuscribeToKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        setUpPickerController(.PhotoLibrary)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        setUpPickerController(.Camera)
    }
    
    func setUpPickerController(source: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        presentViewController(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activity, success, items, error) in
            self.save()
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage
    {
        // Hide bars
        toggleBarsVisibility()
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
                                     afterScreenUpdates: true)
        let memedImage: UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Show Bars
        toggleBarsVisibility()

        return memedImage
    }

    func toggleBarsVisibility() {
        bottomToolBar.hidden = !bottomToolBar.hidden
        topToolBar.hidden = !topToolBar.hidden
    }

    func save() {
        // Create the meme
        let topText = topTextField.text!
        let bottomText = bottomTextField.text!
        let originalImage = imagePickerView.image
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage!, memedImage: memedImage!)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        SetUIToDefaultState()
    }
    
    func SetUIToDefaultState() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.enabled = false
    }
}

