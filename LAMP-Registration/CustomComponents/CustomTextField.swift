
import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        self.placeholder = placeHolder
        configure()
        setPlaceholderColor(placeHolder: placeHolder, color: .lightGray)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        textColor = .black
        textAlignment = .left
        font = UIFont(name: "Nunito-Regular", size: 12)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    private func setPlaceholderColor(placeHolder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    // To update the placeholder color if it changes
    override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }
            setPlaceholderColor(placeHolder: placeholder, color: .lightGray)
        }
    }
}
