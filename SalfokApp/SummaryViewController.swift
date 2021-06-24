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
    var takeInccorect = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainButton.layer.cornerRadius = 15
        scoreView.text = String(takeScore)
        correctView.text  = String(takeCorrect)
        incorrectView.text = String(takeInccorect)
    }
    


}
