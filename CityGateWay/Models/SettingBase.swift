//
//  SettingData.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/3/22.
//

import Foundation

struct SettingBase {
    var setting: SettingData?
    let states = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"]
    let settingFileName = "PersonalSetting"
    
    init() {
        setting = loadJson(fileName: settingFileName)
    }
    mutating func setState(_ state: String) {
        if states.contains(state) {
            setting?.setState(state)
        } else {
            // loggging error ?
        }
        saveJson(fileName: settingFileName, data: setting!)
    }
    
    mutating func setSpeakingRate(_ rate: Float) {
        setting?.setSpeakingRate(rate)
        saveJson(fileName: settingFileName, data: setting!)
    }

    // TODO add remove test
    
    mutating func setCurrentTest(_ test: Int) {
        setting?.setCurrentTest(test)
        saveJson(fileName: settingFileName, data: setting!)
    }
    
}

private func loadJson(fileName: String) -> SettingData? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(SettingData.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

private func saveJson(fileName: String, data: SettingData) {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let encoder = JSONEncoder()
            let encodeData = try encoder.encode(data)
            try encodeData.write(to: url)
        } catch {
            print("Failed to write JSON data:\(error.localizedDescription )")
        }
    }
}

//private func saveJson(dataObj: SettingData,fileName: String) {
//    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let result = try
//        } catch {
//            print("error:\(error)")
//        }
//    }
//}
