//
//  AlcoholFieldTableViewCell.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 05/05/22.
//

import UIKit

class AlcoholFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "AlcoholFieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AlcoholFieldTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var alcoholField: UITextField!
    
    @IBOutlet weak var alcoholLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //alcoholField.delegate = self
        alcoholLabel.text = "Alcohol %"
        
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        //print("\(textField.text ?? "")")
//        self.alcoholField.text = textField.text
//        print(self.alcoholField.text!)
//
//        textField.resignFirstResponder()
//
//
//
//        return true
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
