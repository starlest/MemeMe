//
//  SentMemesTableViewController.swift
//  Meme Me
//
//  Created by Edwin Chia on 25/5/16.
//  Copyright © 2016 Edwin Chia. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    var memes: [Meme] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = memes[indexPath.row]
        cell.imageView?.contentMode = UIViewContentMode.ScaleToFill
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedMeme = memes[indexPath.row]
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        controller.image = selectedMeme.memedImage
        controller.index = indexPath.row
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func addNewMeme(sender: AnyObject) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController?.presentViewController(controller, animated: true, completion: nil)
    }
}
