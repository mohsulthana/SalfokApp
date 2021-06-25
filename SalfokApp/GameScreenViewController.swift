//
//  GameScreenViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit
import AVFoundation

class GameScreenViewController: UIViewController {

    @IBOutlet weak var pointView: UILabel!
    @IBOutlet weak var fakeButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sameButton: UIButton!
    @IBOutlet weak var differentButton: UIButton!
    @IBOutlet weak var hurufLabel: UILabel!
    @IBOutlet weak var inisialisasiLabel: UILabel!
    
    var containerHuruf = [String]()
    var alphabet = ["a","c","e","o"]

    var counter = 10.0
    var timer = Timer()
    var currentHuruf: String = ""
    
    var bgSoundURI: URL?
    var bgAudioPlayer = AVAudioPlayer()
    var point :Int = 0
    var highScore: Int = 0
    var pointCorrect :Int = 0
    var pointIncorrect :Int = 0
    
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
        
        let defaults = UserDefaults.standard
        
        // check if there's a highscore
        if defaults.object(forKey: "highscore") != nil {
            highScore = defaults.integer(forKey: "highscore")
        }
    }
    
    @IBAction func startToPlay() {
        bgSound()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startGame() {
        
        let randomElem = alphabet.randomElement()
        containerHuruf.append(randomElem!)
        
        if containerHuruf.count == 1{
            self.inisialisasiLabel.isHidden = false
            inisialisasiLabel.text = "this is the first letter"
        }else if containerHuruf.count == 2{
            self.inisialisasiLabel.isHidden = false
            inisialisasiLabel.text = "this is the second letter"
        }
        
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
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.subtype = CATransitionSubtype.fromTop
        self.timerLabel.text = "\(minuteString):\(secondString)"
        animation.duration = 0.1
        self.timerLabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        
        if minute == 0 && second == 0 {
            timer.invalidate()
            
            let defaults = UserDefaults.standard
            
            // cek ketika score sekarang lebih tinggi dari high score
            if point > highScore || defaults.object(forKey: "highscore") == nil {
                defaults.set(point, forKey: "highscore")
            }
            
            _ = pointView.text
            _ = pointCorrect
            _ = pointIncorrect
            let vc = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
            
            vc.takeScore = point
            vc.takeInccorect = pointIncorrect
            vc.takeCorrect = pointCorrect
            
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
    
    
    @IBAction func sameButton(_ sender: Any) {
        
        let n = containerHuruf.count - 3
        let lastValue = containerHuruf.last
        let randomElem = alphabet.randomElement()
        
        if lastValue! == containerHuruf[n] {
            point += 10
            pointCorrect += 1
            pointView.text = "\(point)"
            print("Benar")
            self.pointView.text = "\(point)"
        } else {
            pointIncorrect += 1
            print("Salah")
            pointIncorrect += 1
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
            point += 10
            pointCorrect += 1
            pointView.text = "\(point)"
            pointCorrect += 1
            print("Benar")
        } else {
            pointIncorrect += 1
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
    func bgSound(){
        bgSoundURI = URL(fileURLWithPath: Bundle.main.path(forResource: "time2", ofType: "m4a")!)
       do {
           guard let uri = bgSoundURI else {return}
           bgAudioPlayer = try AVAudioPlayer(contentsOf: uri)
           bgAudioPlayer.numberOfLoops = -1
           bgAudioPlayer.play()
          
       } catch {
           print("something went wrong")
       }
   }
    func transferScore(){
        let dataScore = pointView.text
        let dataCorecct = pointCorrect
        let dataIncorecct = pointIncorrect
        let vct = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
        vct.takeScore = point
        vct.takeInccorect = pointIncorrect
        vct.takeCorrect = pointCorrect
        navigationController?.pushViewController(vct, animated: true)
    }
}
