//
//  ViewController.swift
//  AddOne
//
//  Created by Rodrigo Pecchio on 11/17/20.
//

import UIKit

class GameViewController: UIViewController {
    
    // time components of the game
    var timer:Timer? // optional it can be nil
    var seconds = 60
    
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = String(score)
    }
    
    func updateNumberLabel() {
        numberLabel?.text = String.randomNumber(length: 4)
    }
    
    @IBAction func inputFieldDidChange() {
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else {
            return
        }
        
        guard inputText.count == 4 else {
            return
        }
        
        var isCorrect = true
        
        for n in 0..<4 {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            
            if input == 0 { // special case for number 9
                input = 10
            }
            
            if input != number + 1 { // check if user answered correctly
                isCorrect = false
                break
            }
            
        }
        
        // update scores
        if isCorrect {
            score += 1
        } else {
            score -= 1
        }
        
        // update UI
        updateNumberLabel()
        updateScoreLabel()
        // reset input field
        inputField?.text = ""
        
        // creates and starts timer to determine whether player is out of time (interval=1)
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds == 0 { // if time is out finish the game
                    self.finishGame()
                } else if self.seconds <= 60 { // if not at the minute
                    self.seconds -= 1 // decrease time by 1 second
                    self.updateTimeLabel()
                }
            }
        }
    }
    
    func updateTimeLabel() { // we calculate how many minutes and seconds remaining then add that to min and sec constants which we use to update the timer label
        // establish minute unit
        let min = (seconds/60) % 60
        // establish second unit
        let sec = seconds % 60
        // set time label text
        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
        
    }
    
    // takes care of game when game is finished
    func finishGame() {
        // resets timer
        timer?.invalidate()
        timer = nil
        
        // notifies user of score
        let alert = UIAlertController(title: "Your time is up!", message: "Your final score for this round is \(score) points. Thanks for playing!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start new game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        // resets score and time
        score = 0
        seconds = 60
        
        updateTimeLabel()
        updateScoreLabel()
        updateNumberLabel()
    }




}

