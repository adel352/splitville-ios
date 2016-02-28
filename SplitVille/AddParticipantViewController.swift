//
//  AddParticipantViewController.swift
//  SplitVille
//
//  Created by Zoumite Franck Armel Mamboue on 2016-02-27.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit

class AddParticipantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var participantsTableView: UITableView!
    
    let participantsPictures = ["lea", "nabil", "franck", "marcus", "adel"]
    
    let participantsNames = ["Lea Abboud", "Nabil Maadarani", "Franck Mamboue", "Chui Marcus", "Adel Araji"]
    
    let participantsDistance = ["20m away", "25m away", "30m away", "30m away", "300m away"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.participantsPictures.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("participantCell", forIndexPath: indexPath) as! ParticipantCell
        cell.participantImageView.image = UIImage(named: self.participantsPictures[indexPath.row])

        cell.participantImageView.layer.cornerRadius = cell.participantImageView.bounds.width / 2
        cell.participantImageView.layer.masksToBounds = true
        
        cell.participantName.text = self.participantsNames[indexPath.row]
        
        cell.participantDistance.text = self.participantsDistance[indexPath.row]
        
        return cell
    }

}
