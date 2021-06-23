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
    var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

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
            hurufLabel.text = randomElem
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
        
        timerLabel.text = "\(minuteString):\(secondString)"
        
        if minute == 0 && second == 0 {
            timer.invalidate()
            counter = 60.0
            
            let vc = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
            vc.modalPresentationStyle = .fullScreen
//            present(vc,animated: true)
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            present(vc, animated: false, completion: nil)
        }
    }
    
    
    @IBAction func sameButton(_ sender: Any) {
        let randomElem = alphabet.randomElement()
        containerHuruf.append(randomElem!)
        let n = containerHuruf.count - 2
        let lastValue = containerHuruf.last
        
        if lastValue! == containerHuruf[n] {
            print("Benar")
            hurufLabel.text = randomElem
        } else {
            print("Salah")
            hurufLabel.text = randomElem
        }
    }
    
    
    @IBAction func differentButton(_ sender: Any) {
        let randomElem = alphabet.randomElement()
        containerHuruf.append(randomElem!)
        let n = containerHuruf.count - 2
        let lastValue = containerHuruf.last
        
        if lastValue! != containerHuruf[n] {
            print("Benar")
            hurufLabel.text = randomElem
        } else {
            print("Salah")
            hurufLabel.text = randomElem
        }
    }
}
