//
//  ProfileTourismViewController.swift
//  TourismApps
//
//  Created by Ghazian Fadhli Fakhrusy on 30/11/20.
//

import UIKit

class ProfileTourismViewController: UIViewController {

    @IBOutlet weak var highlightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        
        highlightLabel?.layer.cornerRadius = 10
        highlightLabel?.layer.masksToBounds = true
    }

}
