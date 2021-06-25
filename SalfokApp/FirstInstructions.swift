//
//  FirstInstructionsVC.swift
//  SalfokApp
//
//  Created by Tenti Atika Putri on 22/06/21.
//

import UIKit



class FirstInstructions: UIViewController {

    
    @IBOutlet weak var closeButton: UIButton!
    
    static var isNotFromMain: Bool!
    static var remainingSecond: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func swipeFunc(gesture:UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            
            if FirstInstructions.isNotFromMain == false{
                print("swiped left")
    //            performSegue(withIdentifier: "Second Instructions", sender: self)
                
                let vc = storyboard?.instantiateViewController(identifier: "readyGo") as! ReadyGo
                vc.modalPresentationStyle = .fullScreen
    //            present(vc,animated: true)
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                present(vc, animated: false, completion: nil)
            }else{
//                func continueToPlay(remainingTime: Double){
//                    GameScreenViewController.counter = remainingTime
//                }
                GameScreenViewController.counter = FirstInstructions.remainingSecond
//                GameScreenViewController.musicAfterInfo = true
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                dismiss(animated: false, completion: nil)
            }
           
            
        }

    }
    
    @IBAction func goToMainscreen(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure want to quit?", message: "you will be back to mainscreen", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Quit", style: UIAlertAction.Style.default, handler: {item in
            let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainScreen
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Back to How to Play", style: UIAlertAction.Style.cancel, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
