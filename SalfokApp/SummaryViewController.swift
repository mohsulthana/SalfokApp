//
//  SummaryViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var scoreView: UILabel!
    @IBOutlet weak var correctView: UILabel!
    @IBOutlet weak var incorrectView: UILabel!
    var takeScore = Int()
    var takeCorrect = Int()
    @IBOutlet var btnPlayAgain: UIButton!
    var takeInccorect = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainButton.layer.cornerRadius = 15
        scoreView.text = String(takeScore)
        correctView.text  = String(takeCorrect)
        incorrectView.text = String(takeInccorect)
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure want to quit?", message: "you will be back to mainscreen", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Yes, quit to mainscreen", style: UIAlertAction.Style.default, handler: {item in
            let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainScreen
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "No, stay here", style: UIAlertAction.Style.cancel, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func playGameAgain(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "readyGo") as! ReadyGo
                vc.modalPresentationStyle = .fullScreen
        
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                present(vc, animated: false, completion: nil)
    }
}
