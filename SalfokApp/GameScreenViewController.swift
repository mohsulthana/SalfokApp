//
//  GameScreenViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit
import AVFoundation

class GameScreenViewController: UIViewController {
    
    @IBOutlet var notif: UIImageView!
    @IBOutlet var btnInfo: UIButton!
    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var pointView: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sameButton: UIButton!
    @IBOutlet weak var differentButton: UIButton!
    @IBOutlet weak var hurufLabel: UILabel!
    @IBOutlet weak var inisialisasiLabel: UILabel!
    @IBOutlet weak var whiteRectangle: UIImageView!
    
    var containerHuruf = [String]()
    var alphabet = ["a","c","e","o"]

    var counter = 60.0
    var timer = Timer()
    var currentHuruf: String = ""
    
    var bgSoundURI: URL?
    var audioNotification: URL?
    var bgAudioPlayer = AVAudioPlayer()
    var bgAudioNotif = AVAudioPlayer()
    let generator = UINotificationFeedbackGenerator()
    var point :Int = 0
    var highScore: Int = 0
    var pointCorrect :Int = 0
    var pointIncorrect :Int = 0
    

    var image =
        ["notifA.png","notifB.png","notifC.png","notifD.png","notifE.png","notifF.png"]
    var backSound =
        ["time2","bgsound1","bgsound2","bgsound3","bgsound4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(tapGestureRecognizer:)))
            notif.isUserInteractionEnabled = true
            notif.addGestureRecognizer(tapGestureRecognizer)
        
        self.vwContainer.alpha = 0.0
        self.vwContainer.layer.cornerRadius = 5.0

        self.sameButton.isHidden = true
        self.differentButton.isHidden = true
        sameButton.layer.cornerRadius = 15
        differentButton.layer.cornerRadius = 15
        
        timer = Timer.scheduledTimer(timeInterval: 1,
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
    
    
    
    @objc func tapView(tapGestureRecognizer: UITapGestureRecognizer) {
               
        let alert = UIAlertController(title: "Oh, No!!", message: "You just got distracted 😱", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default) {
                (action) in
                print(action)
            }
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
        print("tap is success!!")
    }
    
    
    @IBAction func startToPlay() {
        
        bgSound()
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func notification() {
        
        let number = Int.random(in: 0..<6)
        notif.image = UIImage(named: image[number])
        
        
        audioNotification = URL(fileURLWithPath: Bundle.main.path(forResource: "audioNotif1", ofType: "mp3")!)
           do {
               guard let uri = audioNotification else {return}
               bgAudioNotif = try AVAudioPlayer(contentsOf: uri)
               bgAudioNotif.play()

           } catch {
               print("something went wrong")
           }
        
        //heptic function
        let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.warning)
        
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut , animations: {
                self.vwContainer.alpha = 1.0
            })
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 04.0) { // Change `2.0` to the desired number of seconds.
               // Code you want to be delayed
                UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut , animations: {
                    self.vwContainer.alpha = 0.0
            })

        }
        
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
        
        inisialisasiLabel.isHidden = true
        
        let flooredCounter = Int(floor(counter))
        let minute = flooredCounter / 60
        let minuteString = "0\(minute)"
        
        let second = flooredCounter % 60
        var secondString = "\(second)"
        
        if second < 10 {
            secondString = "0\(second)"
        }
        
        if second % 12 == 0 && second != 60  {
            notification()
            bgAudioPlayer.pause()
        }else{
            bgAudioPlayer.play()
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
            bgAudioPlayer.stop()
            
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
            self.pointView.text = "\(point)"
            generator.notificationOccurred(.success)
            whiteRectangle.image = UIImage(named: "RectangleHijau")
            Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(changeBackgroundDefault), userInfo: nil, repeats: false)
        } else {
            pointIncorrect += 1
            generator.notificationOccurred(.error)
            whiteRectangle.image = UIImage(named: "RectangleMerah")
            Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(changeBackgroundDefault), userInfo: nil, repeats: false)
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
    
    @objc func changeBackgroundDefault() {
        whiteRectangle.image = UIImage(named: "WhiteRectangle-1")
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
            generator.notificationOccurred(.success)
            whiteRectangle.image = UIImage(named: "RectangleHijau")
            Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(changeBackgroundDefault), userInfo: nil, repeats: false)
        } else {
            pointIncorrect += 1
            generator.notificationOccurred(.error)
            whiteRectangle.image = UIImage(named: "RectangleMerah")
            Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(changeBackgroundDefault), userInfo: nil, repeats: false)
            
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
            self.bgAudioPlayer.stop()
        }))
        
        alert.addAction(UIAlertAction(title: "Continue Game", style: UIAlertAction.Style.cancel, handler: {_ in
            self.startToPlay()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func bgSound(){
        
        let number = Int.random(in: 0..<5)
        var type = ""
        if number == 0 {
            type = "m4a"
        }else{
            type = "mp3"
        }
        
        bgSoundURI = URL(fileURLWithPath: Bundle.main.path(forResource: backSound[number], ofType: type)!)
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
        _ = pointView.text
        _ = pointCorrect
        _ = pointIncorrect
        let vct = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
        vct.takeScore = point
        vct.takeInccorect = pointIncorrect
        vct.takeCorrect = pointCorrect
        navigationController?.pushViewController(vct, animated: true)
    }
}
