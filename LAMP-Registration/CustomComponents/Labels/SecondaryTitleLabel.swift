//
//  SecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/27/24.
//

import UIKit

    class SecondaryTitleLabel: UILabel {

        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init (fontSize: CGFloat) {
            super.init(frame: .zero)
            font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
            self.font = UIFont(name: "Helvetica", size: fontSize)
            configure()
        }
        
        private func configure() {
            textColor = .black
            adjustsFontSizeToFitWidth = true
            minimumScaleFactor = 0.9
            lineBreakMode = .byTruncatingTail
            translatesAutoresizingMaskIntoConstraints = false
            numberOfLines = 0
        }

    }
