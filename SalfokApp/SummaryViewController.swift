//
//  SummaryViewController.swift
//  SalfokApp
//
//  Created by Ramona Lily Artha Lubis on 22/06/21.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainButton.layer.cornerRadius = 15
        
    }
    
    

}
