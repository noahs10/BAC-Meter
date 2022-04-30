//
//  ViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bacPercentage: UILabel!
    
    @IBOutlet weak var SoberStatusView: UIView!
    @IBOutlet weak var messageSymbol: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBOutlet weak var ProgressView: UIProgressView!
    private var observation: NSKeyValueObservation?
    
    @IBOutlet weak var AddDrinkButton: UIButton!
    
    
    var bacValue: Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddDrinkButton.isEnabled = true
        
        //bacPercentage Control
        bacPercentage.text = String(bacValue)
        
        
        //Scale Up progress View
        ProgressView.transform = ProgressView.transform.scaledBy(x: 1, y: 5)
        
        //progressView control
        self.perform(#selector(setupProgress), with: nil, afterDelay: 1)
        
        //progress View Color Change
        self.perform(#selector(setupProgress), with: nil, afterDelay: 1)
        
       // ProgressView.progressTintColor = progressColor
        
        //soberStatusView Control
        SoberStatusView.layer.backgroundColor = UIColor.systemBackground.cgColor
        SoberStatusView.layer.borderWidth = 1
        SoberStatusView.layer.borderColor = UIColor.systemBrown.cgColor
        SoberStatusView.layer.cornerRadius = 20
        
        //messageSymbol Control
        messageSymbol.image = messageSymbol.image?.withRenderingMode(.alwaysTemplate)
        messageSymbol.tintColor = UIColor.systemBrown
        
        print(bacValue)
        
}
    
//FUNCTIONS
//progress time func
    @objc func setupProgress(){
        if bacValue > 0.0 {
            bacValue = bacValue - 0.0001
        }
        
        self.ProgressView.progress = Float(bacValue)
        if bacValue != 1.0 {
            self.perform(#selector(setupProgress), with: nil, afterDelay: 0.002)
        }
        self.changeBarColor()
        self.changeMessage()
        self.disableButton()
        let roundedBacValue = round(bacValue*100)/1000.0
        self.bacPercentage.text = String(abs(roundedBacValue)) + "%"
        print(bacValue)
    }
// change Color Function
    @objc func changeBarColor(){
        let deadline = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            if self.bacValue < 0.5 {
                self.ProgressView.progressTintColor = UIColor.systemBrown
            } else if self.bacValue < 0.8 {
                self.ProgressView.progressTintColor = UIColor.systemOrange
            } else {
                self.ProgressView.progressTintColor = UIColor.systemPink
            }
        }
    }
    
//button disable/enable function
    @objc func disableButton(){
        let deadline = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            if self.bacValue <= 0.8 {
                self.AddDrinkButton.isEnabled = true
            } else {
                self.AddDrinkButton.isEnabled = false
            }
        }
    }
//message text change function
    @objc func changeMessage(){
        let deadline = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            if self.bacValue < 0.5 {
                self.SoberStatusView.layer.borderColor = UIColor.systemBrown.cgColor
                self.SoberStatusView.layer.backgroundColor = UIColor.systemBackground.cgColor
                self.messageSymbol.tintColor = UIColor.systemBrown
                self.view.backgroundColor = UIColor.systemBackground
                self.messageLabel.text = "You're Good, Drink Responsibly"
            } else if self.bacValue <= 0.8 {
                self.SoberStatusView.layer.borderColor = UIColor.systemOrange.cgColor
                self.SoberStatusView.layer.backgroundColor = UIColor.systemBackground.cgColor
                self.messageSymbol.tintColor = UIColor.systemOrange
                self.view.backgroundColor = UIColor.systemBackground
                self.messageLabel.text = "Time to Slow Down"
            } else {
                self.SoberStatusView.layer.borderColor = UIColor.systemPink.cgColor
                self.SoberStatusView.layer.backgroundColor = UIColor.systemPink.cgColor
                self.messageSymbol.tintColor = UIColor.white
                self.view.backgroundColor = UIColor.init(red: 0.65, green: 0.01, blue: 0.10, alpha: 1.0)
                self.messageLabel.text = "Stop now!"
            }
        }
    }
//AddDrink Button
@IBAction func addDrink(_ sender: UIButton) {
    //if butt
    bacValue = bacValue + 0.3
}
    
    

}
