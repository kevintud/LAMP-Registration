//
//  CustomTitleLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/9/24.
//

import UIKit

class CustomTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textAlignMent: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignMent
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.font = UIFont(name: "Nunito-SemiBold", size: fontSize)
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
