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

    var userAge:Float = 0.0
    var userSex:String = "Male"
    var userWeight:Float = 0.0
    var userHeight:Float = 0.0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        if let value = UserDefaultManager.shared.defaults.value(forKey: "age") as? Float {
            userAge = Float(value)
        }
        if let value = UserDefaultManager.shared.defaults.value(forKey: "sex") as? String {
            userSex = value
        }
        if let value = UserDefaultManager.shared.defaults.value(forKey: "height") as? Float {
            userHeight = Float(value)
        }
        if let value = UserDefaultManager.shared.defaults.value(forKey: "weight") as? Float {
            userWeight = Float(value)
        }
        ageValue.text = String(Int(userAge))
        sexValue.text = String(userSex)
        heightValue.text = String(Int(userHeight))
        weightValue.text = String(Int(userWeight))
        


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? UINavigationController
        let secondVC = navVC?.viewControllers.first as! DetailsEditViewController
        secondVC.detailsDelegate = self
        
        secondVC.defaultAge = String(Int(userAge))
        secondVC.defaultWeight = String(Int(userWeight))
        secondVC.defaultHeight = String(Int(userHeight))
        secondVC.defaultSex = String(userSex)
        
    }
}

extension DetailsViewController: DetailsDataDelegate {
    func passDetails(age: Float, sex: String, weight: Float, height: Float) {
        
        self.userAge = age
        self.userSex = sex
        self.userWeight = weight
        self.userHeight = height

        ageValue.text = String(Int(userAge))
        sexValue.text = String(userSex)
        heightValue.text = String(Int(userHeight))
        weightValue.text = String(Int(userWeight))
    }
    
    
}


class UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults(suiteName: "noahsyanahan")!
    
}
