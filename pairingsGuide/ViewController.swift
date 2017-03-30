//
//  ViewController.swift
//  pairingsGuide
//
//  Created by WilliamCastellano on 3/29/17.
//  Copyright © 2017 WilliamCastellano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  
  @IBOutlet var yearTextfield: UITextField!
  @IBOutlet var tournamentTextfield: UITextField!
  @IBOutlet var roundTextfield: UITextField!
  
  
  let yearPickerData = ["2017", "2016", "2015"]
  let tournamentPickerData = ["Valspar", "Mexico", "Masters", "Shell Houston Open"]
  let roundPickerData = ["1", "2", "3", "4"]
  
  @IBAction func submit(_ sender: Any) {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
     let picker = UIPickerView()
     tournamentTextfield.inputView = picker
     picker.delegate = self
    
  }
  
  // PICKER FUNCTIONS
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return tournamentPickerData.count
    
    
//    if (yearTextfield.tag == 1) {
//      return yearPickerData.count
//    } else if (tournamentTextfield.tag) == 2 {
//      return tournamentPickerData.count
//    } else {
//      return roundPickerData.count
//    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    return tournamentPickerData[row]
    
//    if (yearTextfield.tag == 1) {
//      return yearPickerData[row]
//    } else if (tournamentTextfield.tag == 2) {
//      return tournamentPickerData[row]
//    } else {
//      return roundPickerData[row]
//    }
    
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    tournamentTextfield.text = tournamentPickerData[row]
    
//    if (yearTextfield.tag == 1) {
//      yearTextfield.text = yearPickerData[row]
//    } else if (tournamentTextfield.tag) == 2 {
//      tournamentTextfield.text = tournamentPickerData[row]
//    } else {
//      roundTextfield.text = roundPickerData[row]
//    }
    
  }
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showSecondViewController" {
      let secondViewController = segue.destination as! SecondViewController
      
      secondViewController.year = yearTextfield.text!
      secondViewController.round = roundTextfield.text!
      secondViewController.tournamentID = tournamentTextfield.text!
      
    }
  }

}
