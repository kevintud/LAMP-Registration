//
//  CustomBodyLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/9/24.
//

import UIKit

class CustomBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textAlignMent: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignMent
        self.font = UIFont(name: "Nunito-Regular", size: 12)
        configure()
    }
    
    
    
    private func configure() {
        textColor = .black
//        font = UIFont.preferredFont(forTextStyle: .body)
//        adjustsFontSizeToFitWidth = true
//        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
}
