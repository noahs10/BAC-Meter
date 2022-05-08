//
//  AddDrinkViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 30/04/22.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol AlcoholDataDelegate {
    func didTapButton(concentration: Float, volume: Float)
}



// MARK: - Class
class AddDrinkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var alcoholDelegate: AlcoholDataDelegate? = nil
    
    var didSelectVolume: Bool = false
    var didInputPercentage: Bool = false
    
    private var alcoholVolume:Float = 0.0
    
    public var alcoholPercent: Float? = 0.0
    
    @IBOutlet weak var addDrinkTableView: UITableView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    let data = [["Alcohol %"],
                ["40 mL", "350 mL","500 mL", "640 mL"]]
    let volumes: [Float] = [40, 350, 500, 640]
    let dataDetails = ["one shot/sloki", "small can/bottle, wine glass",
                       "tall can, large bottle",
                       "large bottle"]
    let sectionHeader = ["Input Alcohol Concentration",
                         "Choose Drink Amount"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDrinkTableView.register(AddDrinkTableViewCell.nib(), forCellReuseIdentifier: AddDrinkTableViewCell.identifier)
        
        addDrinkTableView.register(AlcoholFieldTableViewCell.nib(), forCellReuseIdentifier: AlcoholFieldTableViewCell.identifier)
        
        addDrinkTableView.dataSource = self
        addDrinkTableView.dataSource = self
 
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        addDrinkTableView.tableHeaderView = header
        addDrinkTableView.tableFooterView = footer

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        
        confirmButton.isEnabled = false
        
    }
    
    
    // MARK: - Navigation Items
    
    @IBAction func cancelAddDrink(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmAddDrink(_ sender: Any) {
        


        if self.alcoholDelegate != nil {
            self.alcoholDelegate?.didTapButton(concentration: alcoholPercent ?? 0, volume: alcoholVolume)
        }
        
        dismiss(animated: true, completion: nil)
        
    }


// MARK: - Table View Data Source

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
        addDrinkTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            didSelectVolume = true
            
            if didInputPercentage == true {
                self.confirmButton.isEnabled = true
            } else {
                self.confirmButton.isEnabled = false
            }
            
            alcoholVolume = volumes[indexPath.row]
            print("selected alcohol volume is \(alcoholVolume)")
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
        addDrinkTableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section > 0 {
        
        let customCell = addDrinkTableView.dequeueReusableCell(withIdentifier: AddDrinkTableViewCell.identifier, for: indexPath) as! AddDrinkTableViewCell
    
        customCell.configure(with: data[indexPath.section][indexPath.row], titleDetail: dataDetails[indexPath.row])
        
            return customCell
            
        } else {
        
        let cell = addDrinkTableView.dequeueReusableCell(withIdentifier: AlcoholFieldTableViewCell.identifier, for: indexPath) as! AlcoholFieldTableViewCell

            cell.alcoholField.delegate = self
        
        return cell
            
        }
    }
// MARK: - TextField Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if didSelectVolume == true {
            self.confirmButton.isEnabled = true
        } else {
            self.confirmButton.isEnabled = false
        }
        
        self.alcoholPercent = Float(textField.text!) ?? 0.0
        
        didInputPercentage = true
        
        textField.resignFirstResponder()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = ".1234567890"
        let allowedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharactersSet.isSuperset(of: typedCharacterSet)
        
    }

    
}
    

