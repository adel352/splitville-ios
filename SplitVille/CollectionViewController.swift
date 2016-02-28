//
//  CollectionViewController.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    let users = ["Nabil", "Franck", "Lea", "Adel", "Phil", "Marcus"]
    let userImages = ["nabil", "franck", "lea", "adel", "phil", "marcus"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView?.backgroundColor = UIColor.clearColor()
        self.collectionView?.backgroundView = UIView(frame: CGRectZero)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "clearFacesNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "clearFaces:", name: "clearFacesNotification", object: nil)
    }
    
    func clearFaces(notification: NSNotification) {
        self.collectionView?.visibleCells().forEach {
            let cell = $0 as! CollectionViewCell
            cell.userImageView.layer.borderWidth = 0
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.userImageView.image = UIImage(named: self.userImages[indexPath.row])
        cell.userImageView.layer.cornerRadius = cell.userImageView.bounds.width / 2
        cell.userImageView.layer.masksToBounds = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "cellTapped:"))
        
        cell.userNameLabel.text = self.users[indexPath.row]
    
        return cell
    }
    
    func cellTapped(recognizer: UIGestureRecognizer) {
        let cell = recognizer.view as! CollectionViewCell
        cell.userImageView.layer.borderWidth = 3
        cell.userImageView.layer.borderColor = colorWithHexString("#4B9E87").CGColor
    }
    
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
