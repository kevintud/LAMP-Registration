//
//  CustomTableView.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/4/24.
//

import UIKit

class CustomTableView: UITableView {
    
    init(frame: CGRect, style: UITableView.Style, cellReuseIdentifier: String) {
        super.init(frame: frame, style: style)
        register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        separatorStyle = .singleLine
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}

