//
//  AddDrinkTableViewCell.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 01/05/22.
//

import UIKit

class AddDrinkTableViewCell: UITableViewCell {
    
    
    
    static let identifier = "volumeCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AddDrinkTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, titleDetail: String) {
        volumeTitle.text = title
        volumeDetail.text = titleDetail
        
    }
    
    @IBOutlet weak var volumeTitle: UILabel!
    @IBOutlet weak var volumeDetail: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
