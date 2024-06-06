//
//  CustomTextView.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/6/24.
//

import UIKit

class CustomTextView: UIView {

    lazy var labelsStackView: CustomStackView = {
        let labelsStackView = CustomStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        return labelsStackView
    }()
    
    lazy var titleLabel: CustomTitleLabel = {
        let titleLabel = CustomTitleLabel(textAlignMent: .left, fontSize: 24)
        titleLabel.text = EventDetails.title
        return titleLabel
    }()
    
    lazy var subtitleLabel: CustomBodyLabel = {
        let subtitleLabel = CustomBodyLabel(textAlignMent: .left)
        subtitleLabel.text = EventDetails.subtitle
        return subtitleLabel
    }()
    
    lazy var eventDetailsLabel: CustomBodyLabel = {
        let eventDetailsLabel = CustomBodyLabel(textAlignMent: .left)
        eventDetailsLabel.text = EventDetails.eventInfo
        return eventDetailsLabel
    }()
    
    lazy var descriptionLabel: CustomBodyLabel = {
        let descriptionLabel = CustomBodyLabel(textAlignMent: .left)
        descriptionLabel.text = EventDetails.description
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 3
        
        addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        labelsStackView.addArrangedSubview(eventDetailsLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        let padding: CGFloat = 10.0
        
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            eventDetailsLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
}
