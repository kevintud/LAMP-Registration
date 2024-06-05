

import Foundation
import UIKit

class CustomStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arrangedSubviews: [UIView]) {
         super.init(frame: .zero)
         self.arrangedSubviews.forEach { self.addArrangedSubview($0) }
         configure()
     }
    
    private func configure() {
        distribution = .fill
        axis = .vertical
        alignment = .fill
        spacing = 7
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
