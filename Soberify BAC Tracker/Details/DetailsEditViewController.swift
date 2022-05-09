//
//  DetailsEditViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 28/04/22.
//

import UIKit


// MARK: - Protocol

protocol DetailsDataDelegate {
    func passDetails(age: Float, sex: String, weight: Float, height: Float)
}


// MARK: - Class
class DetailsEditViewController: UITableViewController, UITextFieldDelegate {

    var detailsDelegate: DetailsDataDelegate? = nil
    
    
    @IBOutlet var editDetailsTableView: UITableView!
    
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    var genders = ["Male", "Female"]
    var pickerView = UIPickerView()
    
    var defaultAge = ""
    var defaultSex = ""
    var defaultWeight = ""
    var defaultHeight = ""
    

    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageField.text = defaultAge
        weightField.text! = defaultWeight
        heightField.text! = defaultHeight
        sexField.text! = defaultSex
        
        DoneButton.isEnabled = true
        
        ageField.delegate = self
        weightField.delegate = self
        heightField.delegate = self

        pickerView.delegate = self
        pickerView.dataSource = self
        
        sexField.inputView = pickerView
    }

    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath.init(row: 1, section: 0){
            print("Gender selected")
            
        
        }
    }
    
    
    // MARK: - Navigation Buttons
    
    @IBAction func cancelEditing(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func doneEditing(_ sender: Any) {
        
        let userAge = Float(ageField.text!) ?? 0.0
        let userSex = String(sexField.text!)
        let userWeight = Float(weightField.text!) ?? 0.0
        let userHeight = Float(heightField.text!) ?? 0.0
        
        UserDefaultManager.shared.defaults.setValue(userAge, forKey: "age")
        UserDefaultManager.shared.defaults.setValue(userSex, forKey: "sex")
        UserDefaultManager.shared.defaults.setValue(userHeight, forKey: "height")
        UserDefaultManager.shared.defaults.setValue(userWeight, forKey: "weight")
        
//        print(userAge)
//        print(userWeight)
//        print(userHeight)
//        print(userSex)
        
        if self.detailsDelegate != nil {
            self.detailsDelegate?.passDetails(age: userAge, sex: userSex, weight: userWeight, height: userHeight)
        }
        

        HapticsManager.shared.vibrate(for: .success)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - TextField Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(textField.text!)
        
        textField.resignFirstResponder()
        
        return true
    }
}


// MARK: - PickerView Delegate

extension DetailsEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexField.text = genders[row]
        sexField.resignFirstResponder()
    }
}

