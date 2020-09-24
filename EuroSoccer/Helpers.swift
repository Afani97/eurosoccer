//
//  Helpers.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/18/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit


enum ESError: String, Error {
    case noGames = "There are no games played today"
}


func getCurrentFormattedDate() -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let formattedDate = format.string(from: date)
    return formattedDate
}

func sortByStartTime(matches: [Match]) -> [Match] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return matches.sorted { (m1, m2) -> Bool in
        if let firstMatch = dateFormatter.date(from: m1.utcDate),
            let secondMatch = dateFormatter.date(from: m2.utcDate) {
            return firstMatch < secondMatch
        }
        return false
    }
}

func convertToReadableString(_ status: String) -> String {
    if status == "PAUSED" {
        return "Half Time"
    }
    return status.split(separator: "_").joined(separator: " ").capitalized
}

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for v in views {
            addSubview(v)
        }
    }
}

extension UIViewController {
    
    func getCorrectCell(_ match: Match, tableView: UITableView) -> UITableViewCell {
        if match.status == "SCHEDULED" {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScheduledGameCell.reuseID) as! ScheduledGameCell
            cell.set(match)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseID) as! ScoreCell
            cell.set(match)
            return cell
        }
    }
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
