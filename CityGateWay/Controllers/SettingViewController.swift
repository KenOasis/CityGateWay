//
//  SettingViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/3/22.
//

import UIKit



class SettingViewController: UIViewController {
        
    var speakingRate: Float = 0.3
    @IBOutlet weak var speakingRateSlider: UISlider!
    @IBOutlet weak var speakingRateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        speakingRateSlider.minimumValue = 0.1
        speakingRateSlider.maximumValue = 0.5
        speakingRateSlider.value = speakingRate
        speakingRateLabel.text = String(format: "%.1f", speakingRate)
    }
    
    @IBAction func speakingRateSliderChanged(_ sender: UISlider) {
        speakingRateLabel.text = String(format: "%.1f", speakingRateSlider.value)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

