//
//  UpdateViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/17/22.
//

import UIKit

class UpdateViewController: UIViewController, UITextFieldDelegate, CivilManagerDelegate {
        
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var labelVIew: UILabel!
    
    var civilDataManager = CivilDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        civilDataManager.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        addressTextField.endEditing(true)
    }
    @IBAction func backToMenuPressed(_ sender: UIButton) {
        self.dismiss(animated: true )
    }
    func didCivilDataUpdated(civilDataManager: CivilDataManager, updateQuestions: [UpdatedQuestion]) {
        print(updateQuestions)
        // TODO change question in database 
        DispatchQueue.main.sync {
            labelVIew.text = "Updated Civil Question Successfully"
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("RunError")
        print(error)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print(addressTextField.text!)
        civilDataManager.fetchData(address: addressTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressTextField.endEditing(true)
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
