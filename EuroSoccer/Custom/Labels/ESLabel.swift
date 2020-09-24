//
//  ESLabel.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/19/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit

class ESLabel: UILabel {

   override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontStyle: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: fontStyle)
        self.adjustsFontForContentSizeCategory = true
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
