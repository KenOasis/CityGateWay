//
//  QuizBase.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/2/22.
//

import Foundation

struct QuizBase {
    var questions: [Question]
    var category: String
    var currentQuestion: Int
    
    init(forName: String) {
        let jsonData: QuizData? = loadJson(fileName: forName)
        if jsonData == nil {
            fatalError("File Not Found")
        }
        questions = jsonData!.quiz
        category = jsonData!.category
        currentQuestion = 1
    }
    
    
    
    mutating func getNextQuestion() -> Question {
        var currentNumber = currentQuestion
        if currentQuestion == questions.count {
            currentNumber = 0
        }
        currentQuestion = currentNumber + 1
        return questions[currentQuestion - 1]
    }
    
    mutating func getPreviousQuestion() -> Question {
        var currentNumber = currentQuestion
        if currentQuestion == 1 {
            currentNumber = questions.count + 1
        }
        currentQuestion = currentNumber - 1
        return questions[currentQuestion - 1]
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentQuestion - 1]
    }
    
    func getCurrentProgress() -> Float {
        return Float(currentQuestion) / Float(questions.count)
    }
    
    
}

private func loadJson(fileName: String) -> QuizData? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(QuizData.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
