//
//  SecondViewController.swift
//  pairingsGuide
//
//  Created by WilliamCastellano on 3/29/17.
//  Copyright © 2017 WilliamCastellano. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var year = ""
  var tournamentID = ""
  var round = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
      // Replaces Tournament Names with The IDs for URL
      if tournamentID == "Valspar" {
        tournamentID = "df42e950-c6a7-4b3d-8b93-41efa1bfdf82"
      } else if tournamentID == "Masters" {
        tournamentID = "c0f3aba7-ead2-41bb-8b84-0dbf39370099"
      } else if tournamentID == "Mexico" {
        tournamentID = "deb641b0-3480-42d0-bbcb-46f19d469fc3"
      } else {
        tournamentID = "efa623e0-36a9-4644-b5a1-c1276c8f04b5"
      }
      

//      let url = URL(string: "https://api.sportradar.us/golf-t2/teetimes/pga/2017/tournaments/" + tournamentID + "/Rounds/" + round + "/teetimes.json?api_key=u4thm6q3payb9kw6sp8yq3sm")!
      
      let url = URL(string: "https://api.sportradar.us/golf-t2/teetimes/pga/2017/tournaments/df42e950-c6a7-4b3d-8b93-41efa1bfdf82/Rounds/4/teetimes.json?api_key=u4thm6q3payb9kw6sp8yq3sm")!
      
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print(error!)
        } else {
          
          if let urlContent = data {
            
            do {
              let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
              
//              print(jsonResult)
              
              if let name = jsonResult["name"] as? String {
                  print(name)
              }
              
//              if let round = (jsonResult["round"] as? NSDictionary) {
//                print(round)
//              }
              
//              if let round = (((jsonResult["round"] as? NSDictionary)?["courses"] as? NSArray)?[0]) {
//                print(round)
//              }
              
              if let pairing = ((((jsonResult["round"] as? NSDictionary)?["courses"] as? NSArray)?[0] as? NSDictionary)?["pairings"] as? NSArray)?[4] as? NSDictionary {
                print(pairing)
                
                if let tee_time = pairing["tee_time"] as? String {
                  print(tee_time)
                }
              }
              
              
            } catch {
            // process errors
            }
          }
        }
      }
      task.resume()
  }
  
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    cell.textLabel?.text = "Row \(indexPath.row)"
    return cell
    
  }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
