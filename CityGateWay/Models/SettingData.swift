//
//  SettingData.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/3/22.
//

import Foundation

struct SettingData: Codable {
    var speakingRate: Float
    var state: String
    var customTestNames: [String]
    var currentTest: String
    
    mutating func setSpeakingRate(_ rate: Float) {
        speakingRate = rate
    }
    
    mutating func setState(_ state: String) {
        self.state = state
    }
    
    mutating func setCustomTestNames(_ names: [String]) {
        customTestNames = names
    }
    
    mutating func setCurrentTest(_ test: String) {
        currentTest = test
    }
    
}
