//
//  CustomSelectionView.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/5/24.
//

import UIKit

// Inside CustomSelectionView class

class CustomSelectionView: UIView {

    private let label: CustomBodyLabel

    init(labelText: String) {
        self.label = CustomBodyLabel(textAlignMent: .left)
        super.init(frame: .zero)
        configure(labelText: labelText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(labelText: String) {
        translatesAutoresizingMaskIntoConstraints = false

        let redAsterisk = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.red])
        let attributedText = NSMutableAttributedString(attributedString: redAsterisk)
        attributedText.append(NSAttributedString(string: " \(labelText)"))
        label.attributedText = attributedText

        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
