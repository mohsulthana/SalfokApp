//
//  MainScreen.swift
//  SalfokApp
//
//  Created by Tenti Atika Putri on 22/06/21.
//

import UIKit

class MainScreen: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    var highScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 15
        
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "highscore") != nil {
            highScore = defaults.integer(forKey: "highscore")
        }
    }
    
    @IBAction func startPlayToInfo(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "info") as! FirstInstructions
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
