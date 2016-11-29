//
//  ViewController.swift
//  TipCalculator
//
//  Created by Sang Saephan on 11/26/16.
//  Copyright © 2016 Sang Saephan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var percentageControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var onePersonLabel: UILabel!
    @IBOutlet weak var splitTextField: UITextField!
    @IBOutlet weak var splitLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make the keyboard appear before anything else
        billTextField.becomeFirstResponder()
        
        // Allow functionality when keyboard appears
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow"), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    /*
    Load the default percentage before the view loads
    */
    override func viewWillAppear(animated: Bool) {
        let defaultPercentage = NSUserDefaults.standardUserDefaults()
        let value = defaultPercentage.doubleForKey("default_tip")
        
        if value == 0.10 {
            percentageControl.selectedSegmentIndex = 0
        } else if value == 0.15 {
            percentageControl.selectedSegmentIndex = 1
        } else {
            percentageControl.selectedSegmentIndex = 2
        }
        
        calculateTip(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    Closes the keyboard and brings in the total for additional people
    */
    @IBAction func tapGesture(sender: AnyObject) {
        
        view.endEditing(true)
        
        let numOfPeople = Int(splitTextField.text!) ?? 0
        
        if numOfPeople != 0 {
            UIView.animateWithDuration(1) { () -> Void in
                self.splitLabel.alpha = 1
            }
        } else {
            UIView.animateWithDuration(1) { () -> Void in
                self.splitLabel.alpha = 1
                self.splitLabel.text = "Invalid number of people!"
            }
        }
    }

    /*
    Calculates the tip and total
    */
    @IBAction func calculateTip(sender: AnyObject) {
        
        let bill = Double(billTextField.text!) ?? 0
        let percentages = [0.10, 0.15, 0.20]
        let tip = bill * percentages[percentageControl.selectedSegmentIndex]
        let total = bill + tip
        let numOfPeople = Double(splitTextField.text!) ?? 0
        
        tipLabel.text = String(format: "$%.2f", tip)
        onePersonLabel.text = String(format: "$%.2f", total)
        
        // Split bill among party
        if numOfPeople != 0 {
            splitLabel.text = String(format: "$%.2f" + "/person", total / numOfPeople)
        }
    }
    
    func keyboardWillShow() {
        splitLabel.alpha = 0
    }
    
}

