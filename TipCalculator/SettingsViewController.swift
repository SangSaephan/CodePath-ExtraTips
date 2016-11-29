//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Sang Saephan on 11/28/16.
//  Copyright © 2016 Sang Saephan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultPercentageControl: UISegmentedControl!
    let percentage = [0.10, 0.15, 0.20]

    /*
    Saves the default tip percentage
    */
    @IBAction func percentageChanged(sender: AnyObject) {
        let defaultPercentage = NSUserDefaults.standardUserDefaults()
        defaultPercentage.setDouble(percentage[defaultPercentageControl.selectedSegmentIndex], forKey: "default_tip")
        defaultPercentage.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    Load the default percentage before the view loads
    */
    override func viewWillAppear(animated: Bool) {
        let defaultPercentage = NSUserDefaults.standardUserDefaults()
        let value = defaultPercentage.doubleForKey("default_tip")
        
        if value == 0.10 {
            defaultPercentageControl.selectedSegmentIndex = 0
        } else if value == 0.15 {
            defaultPercentageControl.selectedSegmentIndex = 1
        } else {
            defaultPercentageControl.selectedSegmentIndex = 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
