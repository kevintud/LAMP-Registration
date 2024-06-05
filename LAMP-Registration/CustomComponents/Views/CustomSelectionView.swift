//
//  CustomSelectionView.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/5/24.
//

import UIKit

class CustomSelectionView: UIView {

    private let label: CustomBodyLabel
    private let button: CustomButton

    init(labelText: String, buttonTitle: String) {
        self.label = CustomBodyLabel(textAlignMent: .left)
        self.button = CustomButton(configuration: CustomSelectionView.createButtonConfiguration(title: buttonTitle))
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

        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentHorizontalAlignment = .left

        addSubview(label)
        addSubview(button)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private static func createButtonConfiguration(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 30)
        configuration.title = title
        configuration.baseForegroundColor = .lightGray
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 12)
            return outgoing
        }
        return configuration
    }

    func setButtonTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        button.addTarget(target, action: action, for: event)
    }

    func updateButtonTitle(_ title: String) {
        var configuration = button.configuration
        configuration?.title = title
        button.configuration = configuration
    }
}

