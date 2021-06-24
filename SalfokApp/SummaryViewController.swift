//
//  SummaryViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 23/06/21.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var closeSummaryButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainButton.layer.cornerRadius = 15
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure want to quit?", message: "you will be back to mainscreen", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Quit", style: UIAlertAction.Style.default, handler: {item in
            let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainScreen
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Back to Summary", style: UIAlertAction.Style.cancel, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
