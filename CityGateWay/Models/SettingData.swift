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
    var testList: [String]
    var currentTest: Int
    
    mutating func setSpeakingRate(_ rate: Float) {
        speakingRate = rate
    }
    
    mutating func setState(_ state: String) {
        self.state = state
    }
    
    // TODO add test / remove test from testList
    
    mutating func setCurrentTest(_ test: Int) {
        currentTest = test
    }
    
    func getCurrentTestName() -> String {
        return testList[currentTest]
    }
}
