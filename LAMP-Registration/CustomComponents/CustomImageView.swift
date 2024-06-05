//
//  CustomImageVIew.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/4/24.
//

import UIKit

class CustomImageView: UIImageView {

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
}

