//
//  ViewController.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 5/27/22.
//

import UIKit
import AVFoundation
import Foundation

class MainViewController: UIViewController {
    
    var settingBase: SettingBase = SettingBase()
    
    var quizBase: QuizBase?
        
    @IBOutlet weak var numberLabelView: UILabel!
    
    @IBOutlet weak var questionLabelView: UILabel!
        
    @IBOutlet weak var keywordsLabelView: UILabel!
    
    @IBOutlet weak var tipsLabelView: UILabel!
    
    @IBOutlet weak var answerLabelView: UILabel!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var questionSpeakButton: UIButton!
    
    @IBOutlet weak var answerSpeakButton: UIButton!
    
    var speakButtons: [UIButton] = []
    
    let synthesizer = AVSpeechSynthesizer()
    
    var ttsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBase  = QuizBase(forName: settingBase.setting!.getCurrentTestName())
        questionLabelView.setLabel()
        answerLabelView.setLabel()
        let currentQuestion = quizBase!.getCurrentQuestion()
        self.modalPresentationStyle = .fullScreen
        updateUI(question: currentQuestion)
        synthesizer.delegate = self
        speakButtons.append(questionSpeakButton)
        speakButtons.append(answerSpeakButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMenuPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSetting", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSetting" {
            let destinationVC = segue.destination as! SettingViewController
            destinationVC.speakingRate = settingBase.setting!.speakingRate
        }
    }
    @IBAction func unwindToViewController1(segue: UIStoryboardSegue) {
        let dest = segue.source as! SettingViewController
        settingBase.setSpeakingRate(dest.speakingRateSlider.value)
       // TODO: Use foo in view controller 1
    }
    
}

private func switchButtons(buttons: [UIButton]) {
    // swicth status of UserInteraction of group of UIbutton
    for button in buttons {
        button.isUserInteractionEnabled = !button.isUserInteractionEnabled
    }
}

extension UILabel {
    func setLabel() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}

//MARK: -TTS Functionality

extension MainViewController: AVSpeechSynthesizerDelegate {
    // to switch(disable/enable) speak buttons (all) when tts is speaking utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        if ttsCount > 1 {
            ttsCount -= 1
        } else {
            switchButtons(buttons: speakButtons)
        }
    }
    
    func speakText(text: String) {
        let textsToSpeech = text.components(separatedBy: " / ")
        ttsCount = textsToSpeech.count
        for i in 0..<textsToSpeech.count {
            let utterance = AVSpeechUtterance(string: textsToSpeech[i])
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = settingBase.setting!.speakingRate
            utterance.preUtteranceDelay = 0.5
            utterance.postUtteranceDelay = 0.5
            synthesizer.speak(utterance)
        }
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
    
    
}


//MARK: - Previous/Next Question Funtionality

extension MainViewController {
    func updateUI(question: Question) {
        numberLabelView.text = "Question: " + String(question.number)
        questionLabelView.text = question.getQuestion()
        keywordsLabelView.text = question.getKey()
        answerLabelView.text = question.getAnswer()
        tipsLabelView.text = question.getTips()
        progressBarView.progress = quizBase!.getCurrentProgress()
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        let previousQuestion = quizBase!.getPreviousQuestion()
        updateUI(question: previousQuestion)
    }
    
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        let nextQuestion = quizBase!.getNextQuestion()
        updateUI(question: nextQuestion)
    }
}

//MARK: - favorite question functionality
extension MainViewController {
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        // TODO add / remove from favorite as tapped
        print("Favorite")
    }
}


//MARK: - modified(question/answer) functionality
extension MainViewController {
    
    @IBAction func modifiedQuestionPressed(_ sender: UIButton) {
        print("Modified question")
        // TODO modified question as needed
    }
    @IBAction func modifiedAnswerPressed(_ sender: UIButton) {
        print("Modified answer")
        // TODO modified answer as needed
    }

}
