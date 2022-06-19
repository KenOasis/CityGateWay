//
//  CivilDataManager.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/15/22.
//

import Foundation
protocol CivilManagerDelegate {
    func didCivilDataUpdated(civilDataManager: CivilDataManager, updateQuestions: [UpdatedQuestion])
    func didFailWithError(_ error: Error)
}

// struct to hold updated question number and the updated ansewer from the API
struct UpdatedQuestion {
    var number: Int
    var answer: [String]
    
    mutating func addAnswer(_ answer: String) {
        self.answer.append(answer)
    }
}

struct CivilDataManager {
    
    var delegate: CivilManagerDelegate?
        
    let url = "https://www.googleapis.com/civicinfo/v2/representatives?key=AIzaSyC6A1uEt0CfONTLVT5ncxoag_0yyr25Gd0"
    
    let capitalList = ["AL":"Montgomery", "AK":"Juneau", "AZ":"Phoenix", "AR":"Little Rock", "CA":"Sacramento", "CO":"Denver", "CT":"Hartford", "DE":"Dover", "FL":"Tallahassee", "GA":"Atlanta", "HI":"Honolulu", "ID":"Boise", "IL":"Springfield", "IN":"Indianapolis", "IA":"Des Monies", "KS":"Topeka", "KY":"Frankfort", "LA":"Boton Rouge", "ME":"Augusta", "MD":"Annapolis", "MA":"Boston", "MI":"Lansing", "MN":"Saint Paul", "MS":"Jackson", "MO":"Jefferson City", "MT":"Helena", "NE":"Lincoln", "NV":"Carson City", "NH":"Concord", "NJ":"Trenton", "NM":"Santa Fe", "NY":"Albany", "NC":"Raleigh", "ND":"Bismarck", "OH":"Columbus", "OK":"Oklahoma City", "OR":"Salem", "PA":"Harrisbug", "RI":"Providence", "SC":"Columbia", "SD":"Pierre", "TN":"Nashville", "TX":"Austin", "UT":"Salt Lake City", "VT":"Montpelier", "VA":"Richmond", "WA":"Olympia", "WV":"Chaleston", "WI":"Madison", "WY":"Cheyenne", "DC": "D.C has no capital"]
    
    func fetchData(address: String) {
        var addressQuery = address
        if address.split(separator: " ").count > 1 {
            addressQuery = address.split(separator: " ").joined(separator: "+")
        }
        let urlWithQuery = "\(url)&address=\(addressQuery)"
        performRequest(urlString: urlWithQuery)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    let jsonData = self.parseJSON(civilData: safeData)
                    let updateQuestions = self.getUpdateQuestions(civilData: jsonData!)
                    self.delegate?.didCivilDataUpdated(civilDataManager: self, updateQuestions: updateQuestions)
                }
            }
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(civilData: Data) -> CivilData? {
        let decoder = JSONDecoder()
        do {
        let jsonData = try decoder.decode(CivilData.self, from: civilData)
            return jsonData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func getUpdateQuestions(civilData: CivilData) -> [UpdatedQuestion] {
        var updatedQuestions: [UpdatedQuestion] = []
        let keyInfos = [28: "President of the United States", 29: "Vice President of the United States", 20: "U.S. Senator", 23: "U.S. Representative", 43: "Governor"]
                
        for keyInfo in keyInfos {
            if let indice = civilData.offices.firstIndex(where: {$0.name.hasPrefix(keyInfo.value)}) {
                var question = UpdatedQuestion(number: keyInfo.key, answer: [])
                question.addAnswer(civilData.officials[indice].name)
                updatedQuestions.append(question)
            }
        }
        
        // Add question 44 answer : What is the captial of your state?
        let state = civilData.normalizedInput.state
        var question = UpdatedQuestion(number: 44, answer: [])
        question.addAnswer(capitalList[state]!)
        updatedQuestions.append(question)
        
        // Add question 46 answer : What party of the president now ?
        if let indice = civilData.offices.firstIndex(where: {$0.name.hasPrefix("President of the United States")}) {
            var question = UpdatedQuestion(number: 46, answer: [])
            question.addAnswer(civilData.officials[indice].party)
            updatedQuestions.append(question)
        }
        // TODO question 47: (Speaker of the house)
        
        return updatedQuestions
    }
}
