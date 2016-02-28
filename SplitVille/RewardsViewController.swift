//
//  RewardsViewController.swift
//  SplitVille
//
//  Created by Zoumite Franck Armel Mamboue on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Well Done!"
        
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        doneButton.target = self
        doneButton.action = "doneAction:"
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
