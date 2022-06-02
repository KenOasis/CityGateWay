//
//  ViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 5/27/22.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {

    var quizBase: QuizBase = QuizBase(forName: "PersonalInfo")
    let synthesizer = AVSpeechSynthesizer()
    var ttsCount = 0

    @IBOutlet weak var numberLabelView: UILabel!
    
    @IBOutlet weak var questionLabelView: UILabel!
        
    @IBOutlet weak var keywordsLabelView: UILabel!
    
    @IBOutlet weak var tipsLabelView: UILabel!
    
    @IBOutlet weak var answerLabelView: UILabel!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var questionSpeakButton: UIButton!
    
    @IBOutlet weak var answerSpeakButton: UIButton!
    
    var speakButtons: [UIButton] = []
    
    override func viewDidLoad() {
        
        initUIStyle()
        let currentQuestion = quizBase.getCurrentQuestion()

        updateUI(question: currentQuestion)
        super.viewDidLoad()
        synthesizer.delegate = self
        speakButtons.append(questionSpeakButton)
        speakButtons.append(answerSpeakButton)
        // Do any additional setup after loading the view.
    }
    
    func initUIStyle() {
        questionLabelView.setLabel()
        answerLabelView.setLabel()
        
    }
    
    func updateUI(question: Question) {
        numberLabelView.text = "Question: " + String(question.number)
        questionLabelView.text = question.getQuestion()
        keywordsLabelView.text = question.getKey()
        answerLabelView.text = question.getAnswer()
        tipsLabelView.text = question.getTips()
        progressBarView.progress = quizBase.getCurrentProgress()
        
    }
    
    func speakText(text: String) {
        
        let textsToSpeech = text.components(separatedBy: " / ")
        ttsCount = textsToSpeech.count
        for i in 0..<textsToSpeech.count {
            let utterance = AVSpeechUtterance(string: textsToSpeech[i])
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.3
            utterance.preUtteranceDelay = 0.5
            utterance.postUtteranceDelay = 0.5
            synthesizer.speak(utterance)
        }
        
    }
    
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        let previousQuestion = quizBase.getPreviousQuestion()
        updateUI(question: previousQuestion)
    }
    
    
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        let nextQuestion = quizBase.getNextQuestion()
        updateUI(question: nextQuestion)
    }
    
    
    @IBAction func questionSpeakPressed(_ sender: UIButton) {
        let questionText = questionLabelView.text!
        switchButtons(buttons: speakButtons)
        speakText(text: questionText)
    }
    @IBAction func answerSpeakPressed(_ sender: UIButton) {
        let answerText = answerLabelView.text!
        switchButtons(buttons: speakButtons)
        speakText(text: answerText)
    }
    
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        // TODO add / remove from favorite as tapped
        print("Favorite")
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        // TODO setting the database or starting the test or anything else.
    }
    
    
    @IBAction func modifiedQuestionPressed(_ sender: UIButton) {
        print("Modified question")
        // TODO modified question as needed
    }
    @IBAction func modifiedAnswerPressed(_ sender: UIButton) {
        print("Modified answer")
        // TODO modified answer as needed
    }
    
    func switchButtons(buttons: [UIButton]) {
        // swicth status of UserInteraction of group of UIbutton
        for button in buttons {
            button.isUserInteractionEnabled = !button.isUserInteractionEnabled
        }
    }
}


extension UILabel {
    func setLabel() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}


extension ViewController: AVSpeechSynthesizerDelegate {
    // to switch(disable/enable) speak buttons (all) when tts is speaking utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        if ttsCount > 1 {
            ttsCount -= 1
        } else {
            switchButtons(buttons: speakButtons)
        }
    }
    
}



