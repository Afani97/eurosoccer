//
//  ScoreCell.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/18/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

    static let reuseID = "ScoreCell"
    let homeTeamLabel = ESTeamLabel()
    let awayTeamLabel = ESTeamLabel()
    let currentStatusLabel = ESLabel(textAlignment: .center, fontStyle: .subheadline)
    let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .light {
            backgroundColor = .white
            container.backgroundColor = .systemFill
        } else if traitCollection.userInterfaceStyle == .dark {
            backgroundColor = .black
            container.backgroundColor = .secondaryLabel
        }
    }
    
    func configure() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 10
        container.addSubviews(homeTeamLabel, awayTeamLabel, currentStatusLabel)
        container.backgroundColor = .systemFill
        addSubview(container)
        
        backgroundColor = .white
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10),
            
            homeTeamLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            homeTeamLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            homeTeamLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
            homeTeamLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2),
            
            awayTeamLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            awayTeamLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            awayTeamLabel.heightAnchor.constraint(equalTo: container.heightAnchor),
            awayTeamLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2),
            
            currentStatusLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30),
            currentStatusLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            currentStatusLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            currentStatusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(_ match: Match) {
        homeTeamLabel.set(team: match.homeTeam, score: match.score?.fullTime?.homeTeam ?? 0)
        awayTeamLabel.set(team: match.awayTeam, score: match.score?.fullTime?.awayTeam ?? 0)
        currentStatusLabel.text = convertToReadableString(match.status)
    }
    
    
}
