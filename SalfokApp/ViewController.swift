//
//  ViewController.swift
//  SalfokApp
//
//  Created by Mohammad Sulthan on 17/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fakeButton: UIButton!
    
    @IBOutlet weak var infoHowToPlayButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scoringLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var charLabel: UILabel!
    @IBOutlet weak var sameButton: UIButton!
    @IBOutlet weak var differentButton: UIButton!
    
    
    var counter = 60.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sameButton.layer.cornerRadius = 15
        differentButton.layer.cornerRadius = 15
    }

    
    @IBAction func startToPlay(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    @objc func runTimer(){
        counter -=  0.1
        print(counter)
        
        let flooredCounter = Int(floor(counter))
        var minute = flooredCounter / 60
        var minuteString = "0\(minute)"
        
        let second = flooredCounter % 60
        var secondString = "\(second)"
        if second < 10{
            secondString = "0\(second)"
        }
        
//        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerLabel.text = "\(minuteString):\(secondString)"
        
        if minute == 0 && second == 0{
            timer.invalidate()
            counter = 60.0
            
            let vc = storyboard?.instantiateViewController(identifier: "summary") as! SummaryViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
            
        }
    }
    
}

