//
//  SecondViewController.swift
//  pairingsGuide
//
//  Created by WilliamCastellano on 3/29/17.
//  Copyright © 2017 WilliamCastellano. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tableview: UITableView!

  var year = ""
  var tournamentID = ""
  var round = ""
  let apiKey = "7u7dbzq8trnxccu7zb2s3hnf"
  
  var pairingsCount = 1
  
  var teeTimes = [String]()
  var playersInPairing = ["playerOne": "name1", "playerTwo": "name2", "playerThree": "name3"]
  var allPairingsArray = [Dictionary<String, Any>]()
  
  // var playersPlusScores = ["playerOne": "name1", "PlayerOneRoundOne": "score", "PlayerOneRoundTwo": "score", "PlayerOneRoundThree": "score", "playerTwo": "name2", "PlayerTwoRoundOne": "score", "PlayerTwoRoundTwo": "score", "PlayerTwoRoundThree": "score", "playerThree": "name3", "PlayerThreeRoundOne": "score", "PlayerThreeRoundTwo": "score", "PlayerThreeRoundThree": "score"]
  var completePairingsArray = [Dictionary<String, Any>]()
  
//  var playersInLeaderboard = ["name": "name", "roundOneScore": 0, "roundTwoScore": 0, "roundThreeScore": 0] as [String : Any]
  var allLeaderboardPlayersArray = [Dictionary<String, Any>]()
//
  var nameOne = ""
  var nameTwo = ""
  var nameThree = ""
//
//  var leaderboardPlayerName = ""
//  var scoreOne = 0
//  var scoreTwo = 0
//  var scoreThree = 0
  
  @IBAction func getScoresForPlayers(_ sender: Any) {
     }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      print(tournamentID)
      
      // URL USED WHEN IMPORTING DATA FROM VIEW CONTROLLER 1
        let pairingsURL = URL(string: "https://api.sportradar.us/golf-t2/teetimes/pga/2017/tournaments/" + tournamentID + "/Rounds/" + round + "/teetimes.json?api_key=" + apiKey)!
      
      
      let task = URLSession.shared.dataTask(with: pairingsURL) { (data, response, error) in
        if error != nil {
          print(error!)
        } else {
          
          if let urlContent = data {
            do {
              let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            
              if let pairingsArray = (((jsonResult["round"] as? NSDictionary)?["courses"] as? NSArray)?[0] as? NSDictionary)?["pairings"] as? NSArray {
                 self.pairingsCount = pairingsArray.count
              
                for index in 0...(self.pairingsCount - 1) {
                
                  if let pairing = ((((jsonResult["round"] as? NSDictionary)?["courses"] as? NSArray)?[0] as? NSDictionary)?["pairings"] as? NSArray)?[index] as? NSDictionary {
                    
                    self.teeTimes.append(pairing["tee_time"]! as! String)
                    
                    if let playersArray = pairing["players"] as? NSArray {
                    
                      for index in 0...(playersArray.count - 1) {
                        
                        if let pairingPlayers = (pairing["players"] as? NSArray)?[index] as? NSDictionary {
                          
                          if index == 0 {
                            self.nameOne = (pairingPlayers["first_name"] as! String) + " " + (pairingPlayers["last_name"] as! String)
                            
                          } else if index == 1 {
                            self.nameTwo = (pairingPlayers["first_name"] as! String) + " " + (pairingPlayers["last_name"] as! String)
                            
                          } else if index == 2 {
                            self.nameThree = (pairingPlayers["first_name"] as! String) + " " + (pairingPlayers["last_name"] as! String)
                            
                          } else {
                            // Should never get here
                          }
                        }
                      }
                      self.playersInPairing = ["playerOne": self.nameOne, "playerTwo": self.nameTwo, "playerThree": self.nameThree]
                      self.allPairingsArray.append(self.playersInPairing)
                    }
                  }
                }
              }
            } catch {
            // process errors
            }
          }
        }
        
        print(self.allPairingsArray.count)
        
        for num in 0...(self.allPairingsArray.count - 1) {
          
          var playersPlusScores = ["playerOne": "", "playerOneRoundOne": "", "playerOneRoundTwo": "", "playerOneRoundThree": "", "playerOneTotal": "", "playerTwo": "", "playerTwoRoundOne": "", "playerTwoRoundTwo": "",  "playerTwoRoundThree": "", "playerTwoTotal": "", "playerThree": "", "playerThreeRoundOne": "", "playerThreeRoundTwo": "", "playerThreeRoundThree": "", "playerThreeTotal": ""]
          
          var playerOne = ""
          var playerOneRoundOne = ""
          var playerOneRoundTwo = ""
          var playerOneRoundThree = ""
          var playerOneTotal = ""
          
          var playerTwo = ""
          var playerTwoRoundOne = ""
          var playerTwoRoundTwo = ""
          var playerTwoRoundThree = ""
          var playerTwoTotal = ""
          
          var playerThree = ""
          var playerThreeRoundOne = ""
          var playerThreeRoundTwo = ""
          var playerThreeRoundThree = ""
          var playerThreeTotal = ""
          
          
          for index in 0...(self.allLeaderboardPlayersArray.count - 1) {
            
            let playerOneInPairing = self.allPairingsArray[num]["playerOne"] as? String
            let playerTwoInPairing = self.allPairingsArray[num]["playerTwo"] as? String
            let playerThreeInPairing = self.allPairingsArray[num]["playerThree"] as? String
            
            let leaderboardPlayer = self.allLeaderboardPlayersArray[index]["name"] as? String
            let leaderboardPlayerRoundOne = self.allLeaderboardPlayersArray[index]["roundOneScore"]
            let leaderboardPlayerRoundTwo = self.allLeaderboardPlayersArray[index]["roundTwoScore"]
            let leaderboardPlayerRoundThree = self.allLeaderboardPlayersArray[index]["roundThreeScore"]
            
            if playerOneInPairing == leaderboardPlayer {
              
              playerOne = leaderboardPlayer!
              playerOneRoundOne = leaderboardPlayerRoundOne as! String
              playerOneRoundTwo = leaderboardPlayerRoundTwo as! String
              playerOneRoundThree = leaderboardPlayerRoundThree as! String
              
              let roundOneInt = Int(playerOneRoundOne)
              let roundTwoInt = Int(playerOneRoundTwo)
              let roundThreeInt = Int(playerOneRoundThree)
              
              if self.round == "3" {
                playerOneTotal = String((roundOneInt)! + (roundTwoInt)!)
              } else {
                playerOneTotal = String((roundOneInt)! + (roundTwoInt)! + (roundThreeInt)!)
              }
              
            } else if playerTwoInPairing == leaderboardPlayer {
              
              playerTwo = leaderboardPlayer!
              playerTwoRoundOne = leaderboardPlayerRoundOne as! String
              playerTwoRoundTwo = leaderboardPlayerRoundTwo as! String
              playerTwoRoundThree = leaderboardPlayerRoundThree as! String
              
              let roundOneInt = Int(playerTwoRoundOne)
              let roundTwoInt = Int(playerTwoRoundTwo)
              let roundThreeInt = Int(playerTwoRoundThree)
              
              
              if self.round == "3" {
                playerTwoTotal = String((roundOneInt)! + (roundTwoInt)!)
              } else {
                playerTwoTotal = String((roundOneInt)! + (roundTwoInt)! + (roundThreeInt)!)
              }

              
              
            } else if playerThreeInPairing == leaderboardPlayer {
              
              playerThree = leaderboardPlayer!
              playerThreeRoundOne = leaderboardPlayerRoundOne as! String
              playerThreeRoundTwo = leaderboardPlayerRoundTwo as! String
              playerThreeRoundThree = leaderboardPlayerRoundThree as! String
              
              let roundOneInt = Int(playerThreeRoundOne)
              let roundTwoInt = Int(playerThreeRoundTwo)
              let roundThreeInt = Int(playerThreeRoundThree)
              
              
              if self.round == "3" {
                playerThreeTotal = String((roundOneInt)! + (roundTwoInt)!)
              } else {
                playerThreeTotal = String((roundOneInt)! + (roundTwoInt)! + (roundThreeInt)!)
              }
              
            } else {
              // Do nothing
            }
            
          }
          
          playersPlusScores = ["playerOne": playerOne, "playerOneRoundOne": playerOneRoundOne, "playerOneRoundTwo": playerOneRoundTwo, "playerOneRoundThree": playerOneRoundThree, "playerOneTotal": playerOneTotal, "playerTwo": playerTwo, "playerTwoRoundOne": playerTwoRoundOne, "playerTwoRoundTwo": playerTwoRoundTwo, "playerTwoRoundThree": playerTwoRoundThree, "playerTwoTotal": playerTwoTotal,  "playerThree": playerThree, "playerThreeRoundOne": playerThreeRoundOne, "playerThreeRoundTwo": playerThreeRoundTwo, "playerThreeRoundThree": playerThreeRoundThree, "playerThreeTotal": playerThreeTotal]
        
          self.completePairingsArray.append(playersPlusScores)
        }
        print(self.completePairingsArray)
        print(self.completePairingsArray.count)
      }
      task.resume()
  }
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teeTimes.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
//    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "PairingsCell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "PairingsCell", for: indexPath) as! PairingsTableViewCell
    
    if self.round == "1" {
      cell.teeTime.text = teeTimes[indexPath.row]
      cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
      cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
      cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
      
      
    } else if self.round == "2" {
      
      cell.teeTime.text = teeTimes[indexPath.row]
      cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
      cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
      cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
      
      cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
      cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
      
      cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
      cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
      
      cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeRoundOne"] as? String
      cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeRoundOne"] as? String
      
    } else if self.round == "3" {
      
      cell.teeTime.text = teeTimes[indexPath.row]
      cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
      cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
      cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
      
      cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
      cell.playerOneRoundTwo.text = completePairingsArray[indexPath.row]["playerOneRoundTwo"] as? String
      cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
      
      cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
      cell.playerTwoRoundTwo.text = completePairingsArray[indexPath.row]["playerTwoRoundTwo"] as? String
      cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
      
      cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeeRoundOne"] as? String
      cell.playerThreeRoundTwo.text = completePairingsArray[indexPath.row]["playerThreeeRoundTwo"] as? String
      cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String
      
      
    } else {
      cell.teeTime.text = teeTimes[indexPath.row]
      cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
      cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
      cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
      
      cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
      cell.playerOneRoundTwo.text = completePairingsArray[indexPath.row]["playerOneRoundTwo"] as? String
      cell.playerOneRoundThree.text = completePairingsArray[indexPath.row]["playerOneRoundThree"] as? String
      cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
      
      cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
      cell.playerTwoRoundTwo.text = completePairingsArray[indexPath.row]["playerTwoRoundTwo"] as? String
      cell.playerTwoRoundThree.text = completePairingsArray[indexPath.row]["playerTwoRoundThree"] as? String
      cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
      
      cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeRoundOne"] as? String
      cell.playerThreeRoundTwo.text = completePairingsArray[indexPath.row]["playerThreeRoundTwo"] as? String
      cell.playerThreeRoundThree.text = completePairingsArray[indexPath.row]["playerThreeRoundThree"] as? String
      cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String
    }
    
    return cell
  }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    tableview.reloadData()
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}











/*
     if self.round == "1" {
       cell.teeTime.text = teeTimes[indexPath.row]
       cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
       cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
       cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
 
     } else if self.round == "2" {
 
       cell.teeTime.text = teeTimes[indexPath.row]
       cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
       cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
       cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
 
       cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
       cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
 
       cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
       cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
 
       cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeeRoundOne"] as? String
       cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String
 
     } else if self.round == "3" {
 
       cell.teeTime.text = teeTimes[indexPath.row]
       cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
       cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
       cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
 
       cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
       cell.playerOneRoundTwo.text = completePairingsArray[indexPath.row]["playerOneRoundTwo"] as? String
       cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
 
       cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
       cell.playerTwoRoundTwo.text = completePairingsArray[indexPath.row]["playerTwoRoundTwo"] as? String
       cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
 
       cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeeRoundOne"] as? String
       cell.playerThreeRoundTwo.text = completePairingsArray[indexPath.row]["playerThreeeRoundTwo"] as? String
       cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String
 
 
     } else {
 cell.teeTime.text = teeTimes[indexPath.row]
 cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
 cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
 cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
 
 cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
 cell.playerOneRoundTwo.text = completePairingsArray[indexPath.row]["playerOneRoundTwo"] as? String
 cell.playerOneRoundThree.text = completePairingsArray[indexPath.row]["playerOneRoundThree"] as? String
 cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
 
 cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
 cell.playerTwoRoundTwo.text = completePairingsArray[indexPath.row]["playerTwoRoundTwo"] as? String
 cell.playerTwoRoundThree.text = completePairingsArray[indexPath.row]["playerTwoRoundThree"] as? String
 cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
 
 cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeeRoundOne"] as? String
 cell.playerThreeRoundTwo.text = completePairingsArray[indexPath.row]["playerThreeeRoundTwo"] as? String
 cell.playerThreeRoundThree.text = completePairingsArray[indexPath.row]["playerThreeRoundThree"] as? String
 cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String
     }
 
 
 ************************************************************************************************************************
 ************************************************************************************************************************
 ************************************************************************************************************************
 
 
 cell.teeTime.text = teeTimes[indexPath.row]
 cell.playerOneName.text = completePairingsArray[indexPath.row]["playerOne"] as? String
 cell.playerTwoName.text = completePairingsArray[indexPath.row]["playerTwo"] as? String
 cell.playerThreeName.text = completePairingsArray[indexPath.row]["playerThree"] as? String
 
 cell.playerOneRoundOne.text = completePairingsArray[indexPath.row]["playerOneRoundOne"] as? String
 cell.playerOneRoundTwo.text = completePairingsArray[indexPath.row]["playerOneRoundTwo"] as? String
 cell.playerOneRoundThree.text = completePairingsArray[indexPath.row]["playerOneRoundThree"] as? String
 cell.playerOneTotal.text = completePairingsArray[indexPath.row]["playerOneTotal"] as? String
 
 cell.playerTwoRoundOne.text = completePairingsArray[indexPath.row]["playerTwoRoundOne"] as? String
 cell.playerTwoRoundTwo.text = completePairingsArray[indexPath.row]["playerTwoRoundTwo"] as? String
 cell.playerTwoRoundThree.text = completePairingsArray[indexPath.row]["playerTwoRoundThree"] as? String
 cell.playerTwoTotal.text = completePairingsArray[indexPath.row]["playerTwoTotal"] as? String
 
 cell.playerThreeRoundOne.text = completePairingsArray[indexPath.row]["playerThreeeRoundOne"] as? String
 cell.playerThreeRoundTwo.text = completePairingsArray[indexPath.row]["playerThreeeRoundTwo"] as? String
 cell.playerThreeRoundThree.text = completePairingsArray[indexPath.row]["playerThreeRoundThree"] as? String
 cell.playerThreeTotal.text = completePairingsArray[indexPath.row]["playerThreeTotal"] as? String

*/
