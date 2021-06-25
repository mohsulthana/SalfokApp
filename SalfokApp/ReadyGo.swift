//
//  ReadyGo.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit

class ReadyGo: UIViewController {

    @IBOutlet weak var readyGoLabel: UILabel!
    
    @IBOutlet var lblTimer: UILabel!
    
    var counter = 3
    var timer = Timer()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func timerAction() {
        counter -= 1
        lblTimer.text = "\(counter)"
        GameScreenViewController.counter = 60.0
        if counter <= 0{
            timer.invalidate()
            lblTimer.text = " "
            
            let vc = storyboard?.instantiateViewController(identifier: "gameScreen") as! GameScreenViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
        
        if counter <= 1 {
            readyGoLabel.text = "GO !"
           
        }
        
        
    }
    

//         let vc = storyboard?.instantiateViewController(identifier: "gameScreen") as! GameScreenViewController
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
