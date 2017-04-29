//
//  PairingsTableViewCell.swift
//  pairingsGuide
//
//  Created by WilliamCastellano on 4/17/17.
//  Copyright © 2017 WilliamCastellano. All rights reserved.
//

import UIKit

class PairingsTableViewCell: UITableViewCell {
  @IBOutlet var teeTime: UILabel!

  @IBOutlet var playerTwoName: UILabel!
  @IBOutlet var playerOneName: UILabel!
  @IBOutlet var playerThreeName: UILabel!
  @IBOutlet var playerOneHometown: UILabel!
  @IBOutlet var playerTwoHometown: UILabel!
  @IBOutlet var playerThreeHometown: UILabel!
  
  @IBOutlet var playerOneRoundOne: UILabel!
  @IBOutlet var playerOneRoundTwo: UILabel!
  @IBOutlet var playerOneRoundThree: UILabel!
  @IBOutlet var playerOneTotal: UILabel!
  
  @IBOutlet var playerTwoRoundOne: UILabel!
  @IBOutlet var playerTwoRoundTwo: UILabel!
  @IBOutlet var playerTwoRoundThree: UILabel!
  @IBOutlet var playerTwoTotal: UILabel!
  
  @IBOutlet var playerThreeRoundOne: UILabel!
  @IBOutlet var playerThreeRoundTwo: UILabel!
  @IBOutlet var playerThreeRoundThree: UILabel!
  @IBOutlet var playerThreeTotal: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
