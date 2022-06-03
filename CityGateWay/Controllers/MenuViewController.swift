//
//  MenuViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/2/22.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func customeTestPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCustom", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCustom" {
            _ = segue.destination as! MainViewController
        }
    }

}


