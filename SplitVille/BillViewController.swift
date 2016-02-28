//
//  BillViewController.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class BillViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    let billItems = ["Fiji Lg", "Grapefruit Juice", "L Foie Crostini", "L Sashimi", "L Wild Arugula", "Mushro Risotto",
    "Strawberry Champ"]
    let billItemsPrices = ["8.95", "7.00", "12.00", "22.00", "17.00", "27.00", "15.00"]
    var cellTapped = 0
    let userImages = ["nabil", "franck", "lea", "adel", "phil", "marcus"]
    
    @IBOutlet weak var billItemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BillItemCell", forIndexPath: indexPath) as! BillItemCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.faceImageView.image = UIImage(named: "noface")
        cell.itemNameLabel.text = self.billItems[indexPath.row]
        cell.itemPriceLabel.text = self.billItemsPrices[indexPath.row]
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapped:"))
        
        return cell
    }
    
    func imageTapped(recognizer: UIGestureRecognizer) {
        let cell = recognizer.view as! BillItemCell
        cell.faceImageView.image = UIImage(named: self.userImages[self.cellTapped])
        cell.faceImageView.layer.cornerRadius = cell.faceImageView.bounds.width / 2
        cell.faceImageView.layer.masksToBounds = true
        
        self.cellTapped = (self.cellTapped + 1) % self.userImages.count
        NSNotificationCenter.defaultCenter().postNotificationName("clearFacesNotification", object: nil)
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        let popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("RewardsViewController"))! as UIViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(400,150)
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRectMake(100,100,0,100)
        
        self.presentViewController(nav, animated: true, completion: {
            let dimmedView = UIView(frame: self.view.frame)
            dimmedView.backgroundColor = UIColor.whiteColor()
            dimmedView.alpha = 0.7
            self.view.addSubview(dimmedView)
        })
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
