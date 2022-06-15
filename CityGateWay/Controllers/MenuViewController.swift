//
//  MenuViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/2/22.
//

import UIKit

class MenuViewController: UIViewController {

    var currentTest: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func civilTestPressed(_ sender: UIButton) {
        currentTest = 1
        self.performSegue(withIdentifier: "goToCustom", sender: self)
    }
    @IBAction func customeTestPressed(_ sender: UIButton) {
        currentTest = 0
        self.performSegue(withIdentifier: "goToCustom", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCustom" {
            let mvc = segue.destination as! MainViewController
            mvc.settingBase.setCurrentTest(currentTest)
        }
    }

}


