//
//  ViewController.swift
//  pairingsGuide
//
//  Created by WilliamCastellano on 3/29/17.
//  Copyright © 2017 WilliamCastellano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var yaerTextfield: UITextField!
  @IBOutlet var tournamentTextfield: UITextField!
  @IBOutlet var roundTextfield: UITextField!
  
  @IBAction func submit(_ sender: Any) {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showSecondViewController" {
      let secondViewController = segue.destination as! SecondViewController
      
      secondViewController.year = yaerTextfield.text!
    }
  }

}
