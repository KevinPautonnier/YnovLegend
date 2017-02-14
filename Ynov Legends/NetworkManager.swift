//
//  NetworkManager.swift
//  LeagueOfBard
//
//  Created by iMacFabLab on 10/01/2017.
//  Copyright © 2017 iMacFabLab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias ServiceResponse = ((JSON, Error?) -> Void)
class NetworkManager {
    static let sharedInstance = NetworkManager()
    fileprivate init() {}
    
    // Retourne les données de l'utilisateur
    func callApi(_ completion: @escaping ServiceResponse, region : String,  userName : String) {
        print ("\(region.lowercased())")
        let apiToContact = "https://\(region.lowercased()).api.pvp.net/api/lol/\(region.lowercased())/v1.4/summoner/by-name/\(userName)?api_key=RGAPI-cb92d357-2f23-4734-8fca-67f6479d8dfe"
        
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("data is \(json)")
                    completion(json, nil)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    // Retourne le classement du joueur
    func callApiRanked(_ completion: @escaping ServiceResponse, region : String,  summonerID : String) {
        print ("\(region.lowercased())")
        let apiToContact = "https://\(region.lowercased()).api.pvp.net/api/lol/\(region.lowercased())/v2.5/league/by-summoner/\(summonerID)/entry?api_key=RGAPI-cb92d357-2f23-4734-8fca-67f6479d8dfe"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("data is \(json)")
                    completion(json, nil)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    // Retourne les 3 meilleurs champion
    func callApiChampion(_ completion: @escaping ServiceResponse, region : String,  summonerID : String) {
        
        
        print ("\(region.lowercased())")
        let apiToContact = "https://\(region.lowercased()).api.pvp.net/championmastery/location/\(region)1/player/\(summonerID)/topchampions?count=3&api_key=RGAPI-cb92d357-2f23-4734-8fca-67f6479d8dfe"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" CHAMPION data is \(json)")
                    completion(json, nil)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    //Retourne les détails du champion
    func callApiChampionDetails(_ completion: @escaping ServiceResponse, region : String,  championID : String) {
        
        print ("\(region.lowercased())")
        let apiToContact = "https://global.api.pvp.net/api/lol/static-data/\(region.lowercased())/v1.2/champion/\(championID)?api_key=RGAPI-cb92d357-2f23-4734-8fca-67f6479d8dfe"
        
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" CHAMPION DETAILS data is \(json)")
                    completion(json, nil)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}
