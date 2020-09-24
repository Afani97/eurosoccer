//
//  NetworkManager.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/18/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import Foundation

struct NetworkManager {
    private static let apiKey = "API_KEY"
    private static let apiBasePoint = "https://api.football-data.org"
    private static let apiEndpoint = "/v2/matches?competitions=BL1,PL,SA,PD,FL1&dateFrom=\(getCurrentFormattedDate())&dateTo=\(getCurrentFormattedDate())"

    private static func getCompetitionMatches(completion: @escaping (Competition?) -> Void) {
        
        let competitionEndpoint: String = "\(NetworkManager.apiBasePoint)\(NetworkManager.apiEndpoint)"
        
        guard let url = URL(string: competitionEndpoint) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }

        let session = URLSession.shared
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(NetworkManager.apiKey, forHTTPHeaderField: "X-Auth-Token")

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            // check for any errors, unwrap data
            guard error == nil, let responseData = data else {
                print(error!)
                completion(nil)
                return
            }
            
            do {
                
                let competition = try JSONDecoder().decode(Competition.self, from: responseData)
                completion(competition)
                
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
            
        }
        task.resume()
    }

    static func getMatches(completion: @escaping (Result<[League: [Match]], ESError>) -> Void) {
        NetworkManager.getCompetitionMatches() { (comp) in
            if let competition = comp {
                if let matches = competition.matches {
                    var returnedMatches = [League: [Match]]()
                    
                    let matches = matches.filter { (m) -> Bool in
                        return m.status == "SCHEDULED" || m.status == "LIVE" || m.status == "IN_PLAY" || m.status == "PAUSED" || m.status == "FINISHED"
                    }
                    
                    guard matches.count > 0 else {
                        completion(.failure(.noGames))
                        return
                    }
                    
                    let premierLeague = matches.filter { (m) -> Bool in m.competition.id == 2021 }
                    returnedMatches[League.premierLeague] = sortByStartTime(matches: premierLeague)
                    
                    let primeraDivision = matches.filter { (m) -> Bool in m.competition.id == 2014 }
                    returnedMatches[League.primeraDivision] = sortByStartTime(matches: primeraDivision)
                    
                    let seriaA = matches.filter { (m) -> Bool in m.competition.id == 2019 }
                    returnedMatches[League.seriaA] = sortByStartTime(matches: seriaA)
                    
                    let bundesliga = matches.filter { (m) -> Bool in m.competition.id == 2002 }
                    returnedMatches[League.bundesliga] = sortByStartTime(matches: bundesliga)
                
                    let ligueOne = matches.filter { (m) -> Bool in m.competition.id == 2015 }
                    returnedMatches[League.ligueOne] = sortByStartTime(matches: ligueOne)
                    
                    completion(.success(returnedMatches))
                }
            }
        }

    }
}

