//
//  ScheduledGameCell.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/21/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit

class ScheduledGameCell: UITableViewCell {

    static let reuseID = "ScheduledGameCell"
    let homeTeamLabel = ESLabel(textAlignment: .center, fontStyle: .body)
    let awayTeamLabel = ESLabel(textAlignment: .center, fontStyle: .body)
    let startTimeLabel = ESLabel(textAlignment: .center, fontStyle: .subheadline)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        addSubviews(homeTeamLabel, awayTeamLabel, startTimeLabel)
        selectionStyle = .none

        NSLayoutConstraint.activate([
            homeTeamLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            homeTeamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            homeTeamLabel.heightAnchor.constraint(equalToConstant: 45),
            homeTeamLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2),
            
            awayTeamLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            awayTeamLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            awayTeamLabel.heightAnchor.constraint(equalToConstant: 45),
            awayTeamLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2),
            
            startTimeLabel.topAnchor.constraint(equalTo: homeTeamLabel.bottomAnchor, constant: 10),
            startTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            startTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            startTimeLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func set(_ match: Match) {
        homeTeamLabel.text = match.homeTeam.name
        awayTeamLabel.text = match.awayTeam.name
        startTimeLabel.text = match.formattedDate
    }

}
