//
//  DetailsViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 28/04/22.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var ageValue: UILabel!
    @IBOutlet weak var sexValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    
    let details1 = ["Age", "Sex"]
    let details2 = ["Height", "Weight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        // Do any additional setup after loading the view.
        
       
        ageValue.text = "25"
        sexValue.text = "Female"
        heightValue.text = "180"
        weightValue.text = "175"
    }

}
