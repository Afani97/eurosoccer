//
//  JsonParsing.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/18/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import Foundation

struct Team: Codable {
    let id: Int
    let name: String
}

struct FullTime: Codable {
    let homeTeam: Int?
    let awayTeam: Int?
}

struct Score: Codable {
    let winner: String?
    let fullTime: FullTime?
}

struct Comp: Codable {
    let id: Int
    let name: String
}

struct Match: Codable {
    let competition: Comp
    let homeTeam: Team
    let awayTeam: Team
    let status: String
    let score: Score?
    let utcDate: String
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: utcDate)

        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        return "Starts at \(dateFormatter.string(from: date!).lowercased())"
    }
}

struct Competition: Codable {
    let matches: [Match]?
}
