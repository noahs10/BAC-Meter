//
//  ViewController.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 27/04/22.
//

import UIKit

// MARK: - User Details Model
struct Details {
    let age: Float
    let gender: String
    let weight: Float
    let height: Float

    init(age: Float, gender: String, weight: Float, height: Float){
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
    }
    
    func calculateTBW() -> Float {
        var qValue: Float = 0
        if gender == "Male" {
            qValue = (0.3362*weight) + (0.1074*height) - (0.09516*age) + 2.447
        } else {
            qValue = (0.2466*weight) + (0.1069*height) - 2.097
        }
        return qValue
    }
}

// MARK: - Main View Controller

class ViewController: UIViewController {
    @IBOutlet weak var bacPercentage: UILabel!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var SoberStatusView: UIView!
    @IBOutlet weak var messageSymbol: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var ProgressView: UIProgressView!
    @IBOutlet weak var AddDrinkButton: UIButton!
    
    var bacValue: Float = 0
    var addedBacValue: Float = 0
    var alcoholVolume: Int = 0
    
    var userAge:Float = 0
    var userSex:String = ""
    var userWeight:Float = 0
    var userHeight:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        undoButton.isEnabled = false
        
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
}
    
// MARK: - View Controller Function
    
//progress time func
    @objc func setupProgress(){
        
        if bacValue >= 0.0 {
        //subtract 0.015% bac each 0.1 second
            bacValue = bacValue - 0.00000416
        }
        //update bacValue value after subtracted
        self.ProgressView.progress = Float(bacValue)
        if bacValue != 1.0 {
        //time delay for BAC subtraction. decrease to fast forward
            self.perform(#selector(setupProgress), with: nil, afterDelay: 0.001)
        }
        self.changeBarColor()
        self.changeMessage()
        self.disableButton()
        
        let roundedBacValue = round(bacValue*100)/1000.0
        
        if bacValue < 0 {
            self.bacPercentage.text = "0.000%"
        } else {
            self.bacPercentage.text = String(abs(roundedBacValue)) + "%"
        }
        

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
                
                //self.view.backgroundColor = UIColor.systemBackground
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.view.backgroundColor = UIColor.systemBackground})
                self.messageLabel.text = "You're Good, Drink Responsibly"
            } else if self.bacValue <= 0.8 {
                //Orange View Control
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.SoberStatusView.layer.borderColor = UIColor.systemOrange.cgColor})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.SoberStatusView.layer.backgroundColor = UIColor.systemBackground.cgColor})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.messageSymbol.tintColor = UIColor.systemOrange})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.view.backgroundColor = UIColor.systemBackground})
                self.messageLabel.text = "Time to Slow Down"
            } else {
                //Pink View Control
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.SoberStatusView.layer.borderColor = UIColor.systemPink.cgColor})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.SoberStatusView.layer.backgroundColor = UIColor.systemPink.cgColor})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.messageSymbol.tintColor = UIColor.white})
                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {self.view.backgroundColor = UIColor.init(red: 0.65, green: 0.01, blue: 0.10, alpha: 1.0)})
                //self.view.backgroundColor = UIColor.init(red: 0.65, green: 0.01, blue: 0.10, alpha: 1.0)
                self.messageLabel.text = "Stop now!"
            }
        }
    }

// MARK: - Navigation and Delegation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? UINavigationController
        let secondVC = navVC?.viewControllers.first as! AddDrinkViewController
        secondVC.alcoholDelegate = self
        
    }
//AddDrink Button
@IBAction func addDrink(_ sender: UIButton) {
    
}

    

    @IBAction func undoAddDrink(_ sender: Any) {
        
        bacValue -= (addedBacValue*10)
        undoButton.isEnabled = false
    }
}




extension ViewController: AlcoholDataDelegate {
    func didTapButton(concentration: Float, volume: Float) {
        let mass = calculateMass(volume: volume, conc: concentration)
    
        let user = Details(age: userAge, gender: userSex, weight: userWeight, height: userHeight)
        
        //bacCalculation
        let tbw = user.calculateTBW()
        addedBacValue = calculateWatson(alcMass: mass, qValue: tbw)
        print("total body water is = \(tbw)")
        print("added bacValue is = \(addedBacValue)")
        bacValue += (addedBacValue*10)
        undoButton.isEnabled = true
    }
    
    func calculateMass(volume: Float, conc: Float) -> Float {
        let mass = volume*conc/100*0.789
        return mass
    }
    func calculateWatson(alcMass:Float, qValue: Float) -> Float{
        let bac = 0.844*alcMass/qValue/10
        return bac
    }
}




