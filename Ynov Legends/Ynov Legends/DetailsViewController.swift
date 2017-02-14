//
//  DetailsViewController.swift
//  Ynov Legends
//
//  Created by iMac staff 2 on 10/01/2017.
//  Copyright © 2017 iMac staff 2. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var summonerIcon: UIImageView!
    
    @IBOutlet weak var RankLabel: UILabel!
    
    @IBOutlet weak var champ1NameLabel: UILabel!
    
    @IBOutlet weak var champ2NameLabel: UILabel!
    
    @IBOutlet weak var champ3NameLabel: UILabel!
    
    @IBOutlet weak var champ1LvlLabel: UILabel!
    
    @IBOutlet weak var champ2LvlLabel: UILabel!
    
    @IBOutlet weak var champ3LvlLabel: UILabel!
    
    @IBOutlet weak var champ1View: UIImageView!
    
    @IBOutlet weak var champ2View: UIImageView!
    
    @IBOutlet weak var champ3View: UIImageView!
    
    @IBOutlet weak var rankedView: UIImageView!
    
    var userName:String = ""
    var server:String = ""
    var summonerID:String = ""
    var ranked:String = ""
    var rankNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NetworkManager.sharedInstance.callApi({ (data: JSON, error: Error?) in
            self.summonerID = data[self.userName.lowercased()]["id"].stringValue // Récupération de l'id du joueur
            let iconID = data[self.userName.lowercased()]["profileIconId"].stringValue // Récupération de l'id de l'icon

            self.userNameLabel.text = data[self.userName.lowercased()]["name"].stringValue // Récupération du nom du joueur
            self.levelLabel.text = data[self.userName.lowercased()]["summonerLevel"].stringValue // Récupération du level du joueur
                
            self.summonerIcon.af_setImage(withURL: URL(string: "http://ddragon.leagueoflegends.com/cdn/7.1.1/img/profileicon/\(iconID).png")!) // Récupération de l'image du joueur par rapport à l'icon id
    
            
            NetworkManager.sharedInstance.callApiRanked({ (data: JSON, error: Error?) in
                
                self.ranked = data[self.summonerID][0]["tier"].stringValue // Récupération de la division du joueur
                self.rankNumber = data[self.summonerID][0]["entries"][0]["division"].stringValue // Récupération du numéro de division
                
                //Choix de l'image en fonction de la division
                switch self.ranked{
                    case "BRONZE":
                    self.rankedView.image = #imageLiteral(resourceName: "bronze.png")
                    case "SILVER":
                    self.rankedView.image = #imageLiteral(resourceName: "silver.png")
                    case"GOLD":
                    self.rankedView.image = #imageLiteral(resourceName: "gold.png")
                    case"PLATINUM":
                    self.rankedView.image = #imageLiteral(resourceName: "platinum.png")
                    case"DIAMOND":
                    self.rankedView.image = #imageLiteral(resourceName: "diamond.png")
                    case"MASTER":
                    self.rankedView.image = #imageLiteral(resourceName: "master.png")
                    case"CHALLENGER":
                    self.rankedView.image = #imageLiteral(resourceName: "challenger.png")
                default:
                    self.rankedView.image = #imageLiteral(resourceName: "provisional.png")
                
                }

                self.RankLabel.text = ("\(self.ranked) \(self.rankNumber)")
                }, region: self.server, summonerID: self.summonerID)

            
            NetworkManager.sharedInstance.callApiChampion({ (data: JSON, error: Error?) in
                
                // Récupère les ID des 3 meilleurs champions du joueur
                let champion1ID = data[0]["championId"].stringValue
                let champion2ID = data[1]["championId"].stringValue
                let champion3ID = data[2]["championId"].stringValue
                
                // Récupère les noms des 3 meilleurs champions du joueur
                self.champ1LvlLabel.text = data[0]["championLevel"].stringValue
                self.champ2LvlLabel.text = data[1]["championLevel"].stringValue
                self.champ3LvlLabel.text = data[2]["championLevel"].stringValue
                
                
                // Récupère les images des 3 meilleurs champions du joueur par rapport à leurs id
                NetworkManager.sharedInstance.callApiChampionDetails({ (data: JSON, error: Error?) in
                    self.champ1NameLabel.text = data["key"].stringValue
                    self.champ1View.af_setImage(withURL: URL(string: "http://ddragon.leagueoflegends.com/cdn/7.1.1/img/champion/\(self.champ1NameLabel.text!).png")!)
                }, region: self.server, championID: champion1ID)

                NetworkManager.sharedInstance.callApiChampionDetails({ (data: JSON, error: Error?) in
                    self.champ2NameLabel.text = data["key"].stringValue
                    self.champ2View.af_setImage(withURL: URL(string: "http://ddragon.leagueoflegends.com/cdn/7.1.1/img/champion/\(self.champ2NameLabel.text!).png")!)
                }, region: self.server, championID: champion2ID)
                
                NetworkManager.sharedInstance.callApiChampionDetails({ (data: JSON, error: Error?) in
                    self.champ3NameLabel.text = data["key"].stringValue
                    self.champ3View.af_setImage(withURL: URL(string: "http://ddragon.leagueoflegends.com/cdn/7.1.1/img/champion/\(self.champ3NameLabel.text!).png")!)
                }, region: self.server, championID: champion3ID)
              
            }, region: self.server, summonerID: self.summonerID)
            
        }, region: server, userName: userName)

        self.navigationController?.navigationBar.isHidden = false
        
        levelLabel.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
