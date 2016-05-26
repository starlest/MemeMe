//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Edwin Chia on 26/5/16.
//  Copyright © 2016 Edwin Chia. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeImage = image{
            imageView.image = safeImage
        }
    }
    
    @IBAction func deleteMeme(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.removeAtIndex(index!)
        navigationController?.popViewControllerAnimated(true)
    }
}
