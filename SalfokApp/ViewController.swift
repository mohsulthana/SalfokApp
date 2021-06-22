//
//  ViewController.swift
//  SalfokApp
//
//  Created by Mohammad Sulthan on 17/06/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var infoHowToPlayButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scoringLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var charLabel: UILabel!
    @IBOutlet weak var sameButton: UIButton!
    @IBOutlet weak var differentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sameButton.layer.cornerRadius = 15
        differentButton.layer.cornerRadius = 15
    }


}

