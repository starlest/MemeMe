//
//  SentMemesCollectionViewController.swift
//  Meme Me
//
//  Created by Edwin Chia on 25/5/16.
//  Copyright © 2016 Edwin Chia. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustFlowLayout(self.view.frame.size)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    func adjustFlowLayout(size: CGSize) {
        let frameWidth = size.width
        let frameHeight = size.height
        let space: CGFloat = 1.50
        let dimension = frameHeight >= frameWidth ? (frameWidth - (2 * space)) / 3.0 : (frameWidth - (5 * space)) / 6.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedMeme = memes[indexPath.item]
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        controller.image = selectedMeme.memedImage
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if flowLayout != nil {
            adjustFlowLayout(size)
            flowLayout.invalidateLayout()
        }
    }
    
    @IBAction func addNewMeme(sender: AnyObject) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController?.presentViewController(controller, animated: true, completion: nil)
    }
}
