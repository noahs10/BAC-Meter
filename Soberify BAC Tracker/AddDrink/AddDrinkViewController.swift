//
//  AddDrinkViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 30/04/22.
//

import Foundation
import UIKit

class ChecklistItem {
    let title: String
    var isChecked: Bool = false
    
    init(title: String) {
        self.title = title
    }
}


class AddDrinkViewController: UIViewController {
    
    @IBOutlet weak var addDrinkTableView: UITableView!
    
    let data = [["Alcohol %"],
                ["350 mL","500 mL", "640 mL", "40 mL"]]
    
    let sectionHeader = ["Input Alcohol Concentration",
                         "Choose Drink Amount"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDrinkTableView.dataSource = self
        addDrinkTableView.dataSource = self
 
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        addDrinkTableView.tableHeaderView = header
        addDrinkTableView.tableFooterView = footer
        
    }
    
    
    @IBAction func cancelAddDrink(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAddDrink(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        //bacValue = bacValue + 0.3
        
    }
}
    
extension AddDrinkViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
}
extension AddDrinkViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addDrinkTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = data[indexPath.section][indexPath.row]

        cell.detailTextLabel?.text = "Yay"

        return cell
        
        
    }
    
    
}
