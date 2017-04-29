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
  @IBOutlet var tournamentLabel: UILabel!
  @IBOutlet var roundLabel: UILabel!
  
  @IBOutlet var tournamentPickedLabel: UILabel!
  @IBOutlet var roundPickedLabel: UILabel!
  
  @IBOutlet var showPairingsButton: UIButton!
  @IBOutlet var loadPairingsButton: UIButton!
  
  let yearPickerData = ["2017", "2016", "2015"]
  let tournamentPickerData = ["Valspar", "Mexico", "Masters", "Shell Houston Open"]
  let roundPickerData = ["1", "2", "3", "4"]
  
  var playersInLeaderboard = ["name": "name", "roundOneScore": 0, "roundTwoScore": 0, "roundThreeScore": 0] as [String : Any]
  var allLeaderboardPlayersArray = [Dictionary<String, Any>]()
  var leaderboardPlayerName = ""
  var scoreOne = "0"
  var scoreTwo = "0"
  var scoreThree = "0"
  var tournamentID = ""
  
  @IBAction func loadData(_ sender: Any) {
    
    
    if tournamentTextfield.text  == "Valspar" {
      tournamentID = "df42e950-c6a7-4b3d-8b93-41efa1bfdf82"
    } else if tournamentTextfield.text == "Masters" {
      tournamentID = "c0f3aba7-ead2-41bb-8b84-0dbf39370099"
    } else if tournamentTextfield.text == "Mexico" {
      tournamentID = "deb641b0-3480-42d0-bbcb-46f19d469fc3"
    } else {
      tournamentID = "efa623e0-36a9-4644-b5a1-c1276c8f04b5"
    }
    
    
    let scoresURL = URL(string: "https://api.sportradar.us/golf-t2/leaderboard/pga/2017/tournaments/" + tournamentID + "/leaderboard.json?api_key=7u7dbzq8trnxccu7zb2s3hnf")!
    
    let scoresTask = URLSession.shared.dataTask(with: scoresURL) { (sData, sResponse, sError) in
      
      if sError != nil {
        print(sError!)
      } else {
        
        if let scoresURLContent = sData {
          do {
            let scoresJsonResult = try JSONSerialization.jsonObject(with: scoresURLContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            
            if let scoresArray = (scoresJsonResult["leaderboard"] as? NSArray) {
              
              for index in 0...(scoresArray.count - 1) {
                
                if let leaderboardPlayer = scoresArray[index] as? NSDictionary {
                  let firstName = (leaderboardPlayer["first_name"] as? String)
                  let lastName = (leaderboardPlayer["last_name"] as? String)
                  
                  self.leaderboardPlayerName = (firstName! + " " + lastName!)
                  
                  if let playerScoresArray = leaderboardPlayer["rounds"] as? NSArray {
                    
                    for index in (0...playerScoresArray.count - 1) {
                      if index == 0 {
                        
                        let score = ((playerScoresArray[index] as? NSDictionary)!["strokes"])! as! Int
                        self.scoreOne = String(score)
                        
                      } else if index == 1 {
                        let score = ((playerScoresArray[index] as? NSDictionary)!["strokes"])! as! Int
                        self.scoreTwo = String(score)
                        
                      } else if index == 2 {
                        let score = ((playerScoresArray[index] as? NSDictionary)!["strokes"])! as! Int
                        self.scoreThree = String(score)
                      } else {
                        // Should never get here
                      }
                    }
                    self.playersInLeaderboard = ["name": self.leaderboardPlayerName, "roundOneScore": self.scoreOne, "roundTwoScore": self.scoreTwo, "roundThreeScore": self.scoreThree]
                    self.allLeaderboardPlayersArray.append(self.playersInLeaderboard)
                    
                  }
                }
              }
            }
          } catch {
            print("AN ERROR HAS OCCURED")
          }
        }
      }
      // print(self.allLeaderboardPlayersArray)
    }
    scoresTask.resume()
    
    tournamentTextfield.alpha = 0
    roundTextfield.alpha = 0
    tournamentLabel.alpha = 0
    roundLabel.alpha = 0
    loadPairingsButton.alpha = 0
    
    tournamentPickedLabel.text = "Tournament: " + tournamentTextfield.text!
    tournamentPickedLabel.alpha = 1
    
    roundPickedLabel.text = "Round: " + roundTextfield.text!
    roundPickedLabel.alpha = 1
    
    showPairingsButton.alpha = 1
    
    roundTextfield.resignFirstResponder()
    print("players scores loaded")
    
  }
  
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
    
    if (yearTextfield.tag == 1) {
      yearTextfield.text = yearPickerData[row]
    } else if (tournamentTextfield.tag) == 2 {
      tournamentTextfield.text = tournamentPickerData[row]
    } else {
      roundTextfield.text = roundPickerData[row]
    }
    
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
      print(tournamentID)
      secondViewController.tournamentID = tournamentID
      
      secondViewController.allLeaderboardPlayersArray = allLeaderboardPlayersArray
      
    }
  }

}
