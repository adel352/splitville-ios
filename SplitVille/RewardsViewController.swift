//
//  RewardsViewController.swift
//  SplitVille
//
//  Created by Zoumite Franck Armel Mamboue on 2016-02-28.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    @IBAction func stayCool(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Well Done!"
    }
}
