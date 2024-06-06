//
//  CustomTableViewCell.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/5/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy var customTextLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .left)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(customTextLabel)
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            customTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            customTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with text: String) {
        customTextLabel.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? UIColor.lightGray : UIColor.white
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = highlighted ? UIColor.lightGray : UIColor.white
    }
}
