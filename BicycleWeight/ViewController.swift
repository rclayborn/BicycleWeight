//
//  ViewController.swift
//  BicycleWeight
//
//  Created by Randall Clayborn on 9/3/16.
//  Copyright © 2016 claybear39. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControlMF: UISegmentedControl!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var wristLabel: UILabel!
    
    @IBOutlet weak var FeetInput: UITextField!
    @IBOutlet weak var inchInput: UITextField!
    @IBOutlet weak var poundsTextField: UITextField!
    
    @IBOutlet weak var InchLabel: UILabel!
    @IBOutlet weak var cmLabel: UILabel!
    
    @IBOutlet weak var leanLabel: UILabel!
    @IBOutlet weak var idealBodyFat: UILabel!
    @IBOutlet weak var targetWeightLabel: UILabel!
    @IBOutlet weak var bodyFatLabel: UILabel!
    @IBOutlet weak var finalTargetWeightLabel: UILabel!
    
    var largeFrame = false
    var smallFrame = false
    var mediumFrame = false
    var male = true
    var female = false
    
//-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        genderLabel.text = "Male";
        InchLabel.text = "0"
        cmLabel.text = "0"
        male = true
        female = false
    }
//need to intragate this method
    @IBAction func segmentedControlMFAction(_ sender: AnyObject) {
        
        if(segmentedControlMF.selectedSegmentIndex == 0)
        {
            genderLabel.text = "Male";
            //one more pound per inch
            male = true
            female = false
        }
        else if(segmentedControlMF.selectedSegmentIndex == 1)
        {
            genderLabel.text = "Female";
            //one less pound per inch
            female = true
            male = false
            //do math for female
        }
    }
//-------------------------------------------
    @IBAction func SmallWrist(_ sender: AnyObject) {
        smallFrame = true
        wristLabel.text = "You have a Small Frame"
        //Subtract 10% off your target weight
    }
    
    @IBAction func mediumWrist(_ sender: AnyObject) {
        mediumFrame = true
    wristLabel.text = "You have a Medium Frame"
        //keep your target weight. do nothing.
    }
    
    @IBAction func largeWrist(_ sender: AnyObject) {
        largeFrame = true
    wristLabel.text = "You have a Large Frame"
        //add 10% to your target weight
    }

    @IBAction func CalculateButton(_ sender: AnyObject) {
        self.hideKeyboardWhenTappedAround()
        
        let firstInteger = Float(FeetInput.text!)
        let secondInteger = Float(inchInput.text!)
        let thirdInteger = Float(poundsTextField.text!)
        
        if firstInteger == 5.0 {
            let fiveFoot = Float(106)
            let baseWeight = (fiveFoot + secondInteger! * 6)
        
            idealBodyFat.text = "\(baseWeight)"
            
            let totalInches = (firstInteger! * 12) + secondInteger!
            //total inches for feet and inches given
            InchLabel.text = "Height-Inches:\(totalInches)"
            //putting inches into Cm
            let totalCm = totalInches * 2.55
            //putting it in a label
            cmLabel.text = "Height-Cm:\(totalCm)"
            
            idealBodyFat.text = "Base line Weight\(idealBodyFat)"
            
            //give option for user input
            let BMI = (baseWeight * 703) / (totalInches * 2)
            
            let poundsOfFat = thirdInteger! * BMI
            bodyFatLabel.text = "Pounds of body fat \(poundsOfFat)"
            
            let leanBodyMass = poundsOfFat - thirdInteger!
            leanLabel.text = "Your lean Body Mass:\(leanBodyMass)"
            
            let goalbodyFat = 0.18
            let bodyFatMath  = 1.00 - goalbodyFat
            
            let finalWeight = Float(leanBodyMass) / Float(bodyFatMath)
            finalTargetWeightLabel.text = "Your Best cycling Weight: \(finalWeight)"
            
            
            //must intergrate this method
            if largeFrame == true {
                let largeFrame = Float(finalWeight + (finalWeight * 0.10))
                 targetWeightLabel.text = "Target Weight: \(largeFrame)"
            }
            if mediumFrame == true {
                targetWeightLabel.text = "Target Weight: \(finalWeight)"
                
            }
            if smallFrame == true {
                let smallFrame = finalWeight - (finalWeight / 0.10)
                targetWeightLabel.text = "Target Weight:\(smallFrame)"
            }
        }
    }
    
    
}
    //end of Class beginning of extension.
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        func dismissKeyboard() {
            view.endEditing(true)
        }
}
