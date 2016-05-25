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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (image != nil) {
            imageView.image = image
        }
    }
}
