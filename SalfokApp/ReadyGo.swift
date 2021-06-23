//
//  ReadyGo.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit

class ReadyGo: UIViewController {

    @IBOutlet weak var readyGoLabel: UILabel!
    
    //    var counter = 3.0
//    var timer = Timer()
//
//    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //    @objc func runTimer(){
//        counter -=  0.1
//        print(counter)
//
//        let flooredCounter = Int(floor(counter))
//        var minute = flooredCounter / 60
//        var minuteString = "0\(minute)"
//
//        let second = flooredCounter % 60
//        var secondString = "\(second)"
//        if second < 10{
//            secondString = "0\(second)"
//        }
//
////        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
//
//        timerLabel.text = "\(minuteString):\(secondString)"
//
//        if minute == 0 && second == 0{
//            timer.invalidate()
//            counter = 60.0
//
//            let vc = storyboard?.instantiateViewController(identifier: "gameScreen") as! GameScreenViewController
//            vc.modalPresentationStyle = .fullScreen
////            present(vc,animated: true)
//
//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.type = CATransitionType.push
//            transition.subtype = CATransitionSubtype.fromRight
//            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//            view.window!.layer.add(transition, forKey: kCATransition)
//            present(vc, animated: false, completion: nil)
//
//        }
//

}
