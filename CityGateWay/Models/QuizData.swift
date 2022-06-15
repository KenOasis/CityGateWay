//
//  QuizData.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 5/29/22.
//

import Foundation

import Foundation

struct QuizData: Codable {
    var quiz: [Question]
}
struct Question: Codable {
    var number: Int
    var questions: [String]
    var keys: [String]
    var answers: [String]
    var tips: [String]
    
    func getQuestion() -> String {
        var description = ""
        let questionsLen = questions.count
        for q in 0..<questionsLen {
            description.append(questions[q])
            if q < questionsLen - 1 && questionsLen > 1 {
                description.append(" / ")
            }
           
        }
        return description
    }
    
    func getKey() -> String {
        var description = "🤔: "
        let keysLen = keys.count
        for q in 0..<keysLen {
            description.append("\"")
            description.append(keys[q])
            description.append("\"")
            if q < keysLen - 1 && keysLen > 1 {
                description.append(" + ")
            }
           
        }
        return description
    }
    
    func getAnswer() -> String {
        var description = ""
        let answersLen = answers.count
        for q in 0..<answersLen {
            description.append(answers[q])
            if q < answersLen - 1 && answersLen > 1 {
                description.append(" / ")
            }
           
        }
        return description
    }
    
    func getTips() -> String {
        var description = "💡"
        let tipsLen = tips.count
        for q in 0..<tipsLen {
            description.append(tips[q])
            if q < tipsLen - 1 && tipsLen > 1 {
                description.append(" / ")
            }
           
        }
        return description
    }
    
    
}
