

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroudColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroudColor
        self.setTitle(title, for: .normal)
    }
    
    init(configuration: UIButton.Configuration) {
          super.init(frame: .zero)
          self.configuration = configuration
          configure()
      }
    
    private func configure() {
        layer.cornerRadius = 3
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "Nunito-Regular", size: 13)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backGroungColor: UIColor, title: String) {
        self.backgroundColor = backGroungColor
        setTitle(title, for: .normal)
    }
}
