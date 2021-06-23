//
//  GameScreenViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit

class GameScreenViewController: UIViewController {

    @IBOutlet weak var fakeButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sameButton: UIButton!
    @IBOutlet weak var SwipeToContinue: UILabel!
    @IBOutlet weak var differentButton: UIButton!
    @IBOutlet weak var hurufLabel: UILabel!
    
    var containerHuruf = [String]()
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

    var counter = 60.0
    var timer = Timer()
    var currentHuruf: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sameButton.isHidden = true
        self.differentButton.isHidden = true
        sameButton.layer.cornerRadius = 15
        differentButton.layer.cornerRadius = 15
        
        timer = Timer.scheduledTimer(timeInterval: 3,
                target: self,
                selector: #selector(GameScreenViewController.startGame),
                userInfo: nil,
                repeats: true)
    }
    
    @IBAction func startToPlay() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startGame() {
        let randomElem = alphabet.randomElement()
        containerHuruf.append(randomElem!)
        
        if containerHuruf.count > 2 {
            timer.invalidate()
            self.currentHuruf = randomElem!
            self.sameButton.isHidden = false
            self.differentButton.isHidden = false
            startToPlay()
        } else {
            hurufLabel.text = randomElem
        }
    }
    
    @objc func runTimer() {
        counter -=  0.1
        
        let flooredCounter = Int(floor(counter))
        let minute = flooredCounter / 60
        let minuteString = "0\(minute)"
        
        let second = flooredCounter % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
//        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.subtype = CATransitionSubtype.fromTop
        self.timerLabel.text = "\(minuteString):\(secondString)"
        animation.duration = 0.1
        self.timerLabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        
        if minute == 0 && second == 0 {
            timer.invalidate()
            counter = 6000.0
            
            let vc = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
            vc.modalPresentationStyle = .fullScreen
//            present(vc,animated: true)
        }
    }
    
    
    @IBAction func sameButton(_ sender: Any) {
        
        let n = containerHuruf.count - 3
        let lastValue = containerHuruf.last
        let randomElem = alphabet.randomElement()
        
        if lastValue! == containerHuruf[n] {
            print("Benar")
        } else {
            print("Salah")
        }
        containerHuruf.append(randomElem!)
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        self.hurufLabel.text = randomElem
        animation.duration = 0.25
        self.hurufLabel.layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    
    @IBAction func differentButton(_ sender: Any) {
        let n = containerHuruf.count - 3
        let lastValue = containerHuruf.last
        let randomElem = alphabet.randomElement()
        
        if lastValue! != containerHuruf[n] {
            print("Benar")
        } else {
            print("Salah")
        }
        containerHuruf.append(randomElem!)

        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        self.hurufLabel.text = randomElem
        animation.duration = 0.25
        self.hurufLabel.layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    @IBAction func pauseGame(_ sender: Any) {
        timer.invalidate()
        let alert = UIAlertController(title: "Are you sure want to quit?", message: "The game will be reset after you quit the game", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Quit", style: UIAlertAction.Style.default, handler: {item in
            let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainScreen
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Continue Game", style: UIAlertAction.Style.cancel, handler: {_ in
            self.startToPlay()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
