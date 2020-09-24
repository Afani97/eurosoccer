//
//  ESTeamLabel.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/19/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit

class ESTeamLabel: UIView {
    
    let teamNameLabel = ESLabel(textAlignment: .center, fontStyle: .body)
    let teamScoreLabel = ESLabel(textAlignment: .center, fontStyle: .largeTitle)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false 
        addSubviews(teamNameLabel, teamScoreLabel)
        
        NSLayoutConstraint.activate([
            teamNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            teamNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            teamNameLabel.heightAnchor.constraint(equalToConstant: 40),
            teamNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            teamScoreLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: 10),
            teamScoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            teamScoreLabel.heightAnchor.constraint(equalToConstant: 45),
            teamScoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func set(team: Team, score: Int) {
        teamNameLabel.text = team.name
        teamScoreLabel.text = "\(score)"
    }

}
