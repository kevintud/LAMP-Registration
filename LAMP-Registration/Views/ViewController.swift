//
//  ViewController.swift
//  LAMP-Registration
//
//  Created by Goin-Kevin on 6/4/24.
//

import UIKit

class ViewController: UIViewController {
    var viewAction: ViewActionProtocol?
    var isGuest = false
    var isMember = false
    var clusterGroupTableViewHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha:1)
        setUpUI()
        fetchBannerImage()
        // Add tap gesture recognizer to dismiss keyboard and table views
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndTableViews))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        setupKeyboardObservers()
    }
    
    ///private method
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    private func fetchBannerImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            Network.shared.getBanner { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.bannerImage.image = image
                    }
                case .failure(let error):
                    print("Failed to fetch image with error: \(error)")
                }
            }
        }
    }

    
    @objc func memberOrGuestButtonTapped() {
        viewAction?.toggleMemberOrGuestTableView()
    }
    
    @objc func rightButtonTapped() {
        viewAction?.toggleHaveAnAwtaCardTableView()
    }
    
    @objc func howToAttendButtonTapped() {
        viewAction?.toggleHowToAttendTableView()
    }
    
    @objc func dismissKeyboardAndTableViews() {
        view.endEditing(true)
        viewAction?.hideAllTableViews()
    }
    
    @objc func clusterGroupButtonTapped() {
        viewAction?.toggleClusterGroupTableView()
    }
    
    @objc func nextButtonTapped() {
        if let userSelection = viewAction?.createUserSelection() {
            viewAction?.validateAndNavigate(userSelection: userSelection)
        } else {
            // Handle the case where the user has not made all required selections
            let alert = UIAlertController(title: "Incomplete Selection", message: "Please make all required selections before proceeding.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func setUpUI() {
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(bannerImage)
        
        stackView.addArrangedSubview(textView)
        

        
        contentView.addSubview(memberOrGuestTableView)
        contentView.addSubview(haveAnAwtaCardTableView)
        contentView.addSubview(howToAttendTableView)
        contentView.addSubview(clusterGroupTableView)
        
        stackView.addArrangedSubview(memberOrGuest)
        memberOrGuest.addSubview(leftView)
        memberOrGuest.addSubview(leftButton)
        memberOrGuest.addSubview(rightView)
        memberOrGuest.addSubview(rightButton)
        
        stackView.addArrangedSubview(howToAttend)
        howToAttend.addSubview(howToAttendView)
        howToAttend.addSubview(howToAttendButton)
        howToAttend.addSubview(bookinCodeView)
        howToAttend.addSubview(bookingCodeTextField)
        
        stackView.addArrangedSubview(awtaCard)
        awtaCard.addSubview(awtaCardView)
        awtaCard.addSubview(awtaCardTextField)
        awtaCard.addSubview(clusterGroupView)
        awtaCard.addSubview(selectClusterButton)
        
        
        stackView.addArrangedSubview(emailAddress)
        emailAddress.addSubview(emailAddressLabel)
        emailAddress.addSubview(emailAddressTextField)
        
        stackView.addArrangedSubview(assitance)
        assitance.addSubview(assistanceLabel)
        assitance.addSubview(assistanceTextField)
        
        stackView.addArrangedSubview(buttons)
        buttons.addSubview(nextButton)
        buttons.addSubview(progressBar)
        buttons.addSubview(pageLabel)
        
        contentView.addSubview(bottomView)
        bottomView.addArrangedSubview(alreadyRegisteredLabel)
        bottomView.addArrangedSubview(manageBookingButton)
        
        memberOrGuestTableView.isHidden = true
        haveAnAwtaCardTableView.isHidden = true
        awtaCard.isHidden = true
        emailAddress.isHidden = true
        howToAttend.isHidden = true
        assitance.isHidden = true
        rightView.isHidden = true
        rightButton.isHidden = true
        howToAttendTableView.isHidden = true
        bookingCodeTextField.isHidden = true
        bookinCodeView.isHidden = true
        clusterGroupTableView.isHidden = true
        
        clusterGroupTableViewHeightConstraint = clusterGroupTableView.heightAnchor.constraint(equalToConstant: (awtaCardTextField.text?.isEmpty ?? true) ? 35 : 250)
        NSLayoutConstraint.activate([clusterGroupTableViewHeightConstraint!])
        
        let padding: CGFloat = 10.0
        
        NSLayoutConstraint.activate([
            // Constraints for contentView
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            // Constraints for bottomView
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for scrollView
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Constraints for stackView
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2 * padding),
            
            bannerImage.heightAnchor.constraint(equalToConstant: 140),
            textView.heightAnchor.constraint(equalToConstant: 320),
            
            memberOrGuest.heightAnchor.constraint(equalToConstant: 120),
            howToAttend.heightAnchor.constraint(equalToConstant: 120),
            awtaCard.heightAnchor.constraint(equalToConstant: 120),
            emailAddress.heightAnchor.constraint(equalToConstant: 120),
            assitance.heightAnchor.constraint(equalToConstant: 120),
            buttons.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            nextButton.leadingAnchor.constraint(equalTo: buttons.leadingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            
            progressBar.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            progressBar.trailingAnchor.constraint(equalTo: pageLabel.leadingAnchor, constant: -5),
            progressBar.widthAnchor.constraint(equalToConstant: 70),
            
            pageLabel.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            pageLabel.trailingAnchor.constraint(equalTo: buttons.trailingAnchor),
            
            // Constraints for leftView and rightView in memberOrGuest
            leftView.leadingAnchor.constraint(equalTo: memberOrGuest.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: memberOrGuest.topAnchor),
            leftView.heightAnchor.constraint(equalToConstant: 60),
            leftView.widthAnchor.constraint(equalTo: memberOrGuest.widthAnchor, multiplier: 0.5),
            
            leftButton.leadingAnchor.constraint(equalTo: memberOrGuest.leadingAnchor, constant: 10),
            leftButton.topAnchor.constraint(equalTo: leftView.bottomAnchor),
            leftButton.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -12),
            leftButton.heightAnchor.constraint(equalToConstant: 30),
            
            memberOrGuestTableView.topAnchor.constraint(equalTo: leftButton.bottomAnchor),
            memberOrGuestTableView.leadingAnchor.constraint(equalTo: leftButton.leadingAnchor),
            memberOrGuestTableView.trailingAnchor.constraint(equalTo: leftButton.trailingAnchor),
            memberOrGuestTableView.heightAnchor.constraint(equalToConstant: 70),
            
            rightButton.leadingAnchor.constraint(equalTo: rightView.leadingAnchor ,constant: 2),
            rightButton.topAnchor.constraint(equalTo: rightView.bottomAnchor),
            rightButton.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -12),
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            
            haveAnAwtaCardTableView.topAnchor.constraint(equalTo: rightButton.bottomAnchor),
            haveAnAwtaCardTableView.leadingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            haveAnAwtaCardTableView.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor),
            haveAnAwtaCardTableView.heightAnchor.constraint(equalToConstant: 105),
            
            rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: memberOrGuest.topAnchor),
            rightView.heightAnchor.constraint(equalToConstant: 60),
            rightView.trailingAnchor.constraint(equalTo: memberOrGuest.trailingAnchor),
            
            
            //howtoattend view
            
            howToAttendView.leadingAnchor.constraint(equalTo: howToAttend.leadingAnchor),
            howToAttendView.topAnchor.constraint(equalTo: howToAttend.topAnchor),
            howToAttendView.heightAnchor.constraint(equalToConstant: 60),
            howToAttendView.widthAnchor.constraint(equalTo: howToAttend.widthAnchor, multiplier: 0.5),
            
            howToAttendButton.leadingAnchor.constraint(equalTo: howToAttend.leadingAnchor, constant: 10),
            howToAttendButton.topAnchor.constraint(equalTo: howToAttendView.bottomAnchor),
            howToAttendButton.trailingAnchor.constraint(equalTo: howToAttendView.trailingAnchor, constant: -12),
            howToAttendButton.heightAnchor.constraint(equalToConstant: 30),
            
            howToAttendTableView.topAnchor.constraint(equalTo: howToAttendButton.bottomAnchor),
            howToAttendTableView.leadingAnchor.constraint(equalTo: howToAttendButton.leadingAnchor),
            howToAttendTableView.trailingAnchor.constraint(equalTo: howToAttendButton.trailingAnchor),
            howToAttendTableView.heightAnchor.constraint(equalToConstant: 70),
            
            bookinCodeView.leadingAnchor.constraint(equalTo: howToAttendView.trailingAnchor),
            bookinCodeView.topAnchor.constraint(equalTo: howToAttend.topAnchor),
            bookinCodeView.heightAnchor.constraint(equalToConstant: 60),
            bookinCodeView.trailingAnchor.constraint(equalTo: howToAttend.trailingAnchor),
            
            bookingCodeTextField.leadingAnchor.constraint(equalTo: bookinCodeView.leadingAnchor, constant: 10),
            bookingCodeTextField.topAnchor.constraint(equalTo: bookinCodeView.bottomAnchor),
            bookingCodeTextField.trailingAnchor.constraint(equalTo: bookinCodeView.trailingAnchor, constant: -12),
            bookingCodeTextField.heightAnchor.constraint(equalToConstant: 30),
            
            awtaCardView.leadingAnchor.constraint(equalTo: awtaCard.leadingAnchor),
            awtaCardView.topAnchor.constraint(equalTo: awtaCard.topAnchor),
            awtaCardView.heightAnchor.constraint(equalToConstant: 60),
            awtaCardView.widthAnchor.constraint(equalTo: awtaCard.widthAnchor, multiplier: 0.5),
            
            awtaCardTextField.leadingAnchor.constraint(equalTo: awtaCardView.leadingAnchor, constant: 10),
            awtaCardTextField.topAnchor.constraint(equalTo: awtaCardView.bottomAnchor),
            awtaCardTextField.trailingAnchor.constraint(equalTo: awtaCardView.trailingAnchor, constant: -12),
            awtaCardTextField.heightAnchor.constraint(equalToConstant: 30),
            
            clusterGroupView.leadingAnchor.constraint(equalTo: awtaCardView.trailingAnchor),
            clusterGroupView.topAnchor.constraint(equalTo: awtaCard.topAnchor),
            clusterGroupView.heightAnchor.constraint(equalToConstant: 60),
            clusterGroupView.trailingAnchor.constraint(equalTo: awtaCard.trailingAnchor),
            
            selectClusterButton.leadingAnchor.constraint(equalTo: awtaCardView.trailingAnchor, constant: 2),
            selectClusterButton.topAnchor.constraint(equalTo: awtaCardView.bottomAnchor),
            selectClusterButton.trailingAnchor.constraint(equalTo: awtaCard.trailingAnchor, constant: -12),
            selectClusterButton.heightAnchor.constraint(equalToConstant: 30),
            
            clusterGroupTableView.topAnchor.constraint(equalTo: selectClusterButton.bottomAnchor),
            clusterGroupTableView.leadingAnchor.constraint(equalTo: selectClusterButton.leadingAnchor),
            clusterGroupTableView.trailingAnchor.constraint(equalTo: selectClusterButton.trailingAnchor),

            emailAddressLabel.topAnchor.constraint(equalTo: emailAddress.topAnchor),
            emailAddressLabel.leadingAnchor.constraint(equalTo: emailAddress.leadingAnchor, constant: 10),
            emailAddressLabel.trailingAnchor.constraint(equalTo: emailAddress.trailingAnchor, constant: -10),
            emailAddressLabel.heightAnchor.constraint(equalToConstant: 77),
            
            emailAddressTextField.leadingAnchor.constraint(equalTo: emailAddressLabel.leadingAnchor),
            emailAddressTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor),
            emailAddressTextField.trailingAnchor.constraint(equalTo: emailAddress.trailingAnchor, constant: -10),
            emailAddressTextField.heightAnchor.constraint(equalToConstant: 30),
            
            assistanceLabel.topAnchor.constraint(equalTo: assitance.topAnchor),
            assistanceLabel.leadingAnchor.constraint(equalTo: assitance.leadingAnchor, constant: 10),
            assistanceLabel.trailingAnchor.constraint(equalTo: assitance.trailingAnchor, constant: -10),
            assistanceLabel.heightAnchor.constraint(equalToConstant: 77),
            
            assistanceTextField.leadingAnchor.constraint(equalTo: assistanceLabel.leadingAnchor),
            assistanceTextField.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor),
            assistanceTextField.trailingAnchor.constraint(equalTo: assitance.trailingAnchor, constant: -10),
            assistanceTextField.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: stackView.frame.height)
    }
    
    ///Getter & Setter
    
    lazy var bannerImage: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
        return scrollView
    }()
    lazy var stackView: CustomStackView = {
        let stackView = CustomStackView()
        stackView.spacing = 10
        return stackView
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var textView: UIView = {
        let textView = CustomTextView()
        return textView
    }()

    
    lazy var memberOrGuest: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    lazy var leftView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "Are you a guest or a member?")
        return view
    }()
    
    lazy var leftButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: "Choose")
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(memberOrGuestButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var memberOrGuestTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain, cellReuseIdentifier: "memberOrGuestCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "memberOrGuestCell")
        tableView.tag = 1
        return tableView
    }()
    
    lazy var rightView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "Do you have an AWTA card?")
        return view
    }()
    
    lazy var rightButton: CustomButton = {
        
        let button = CustomButton(backgroudColor: .white, title: "Choose")
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var haveAnAwtaCardTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain, cellReuseIdentifier: "haveAnAwtaCard")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "haveAnAwtaCard")
        tableView.tag = 2
        return tableView
    }()
    
    
    lazy var howToAttend: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var howToAttendView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "How will you attend the AWTA?")
        return view
    }()
    
    lazy var howToAttendButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: "Choose")
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(howToAttendButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var howToAttendTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain, cellReuseIdentifier: "howToAttendCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "howToAttendCell")
        tableView.tag = 3
        return tableView
    }()
    
    lazy var bookinCodeView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "Booking Code")
        return view
    }()
    lazy var bookingCodeTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Type your booking code.")
        textField.delegate = self
        return textField
    }()
    
    lazy var awtaCard: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    lazy var awtaCardView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "What is your AWTA card number?")
        return view
    }()
    lazy var awtaCardTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "")
        textField.delegate = self
        return textField
    }()
    
    
    lazy var clusterGroupView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "Cluster Group")
        return view
    }()
    
    lazy var selectClusterButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: "Select")
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(clusterGroupButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var clusterGroupTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain, cellReuseIdentifier: "clusterTableGroup")
        tableView.isScrollEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "clusterTableGroup")
        tableView.tag = 4
        return tableView
    }()
    
    lazy var emailAddress: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        
        return view
    }()
    lazy var emailAddressLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .left)
        label.text = "Email Address (Optional)\nPlease provide the email address where you would like to receive the confirmation email."
        return label
    }()
    lazy var emailAddressTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "")
        textField.delegate = self
        return textField
    }()
    
    lazy var assitance: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    lazy var assistanceLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .left)
        label.text = "Do you need any medical assitance during the even?\nIf YES, kindly specify below. If NO, kindly put N/A."
        return label
    }()
    lazy var assistanceTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Please specify")
        textField.delegate = self
        return textField
    }()
    
    lazy var buttons: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha:1)
        
        return view
    }()
    lazy var nextButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: "Next")
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progress = 0.33
        return progressBar
    }()
    
    lazy var pageLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .left)
        label.text = "Page 1 of 3"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var bottomView: CustomStackView = {
        let view = CustomStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 0
        return view
    }()
    
    lazy var alreadyRegisteredLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .right)
        label.text = "Already registered?"
        label.font = UIFont.systemFont(ofSize: 11)
        
        return label
    }()
    
    lazy var manageBookingButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: " Manage Booking")
        button.setTitleColor(UIColor(red: 100/255, green: 186/255, blue: 180/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return viewAction?.memberOrGuest.count ?? 0
        case 2:
            return viewAction?.doYouHaveAnAwtaCard.count ?? 0
        case 3:
            return viewAction?.howWillYouAttend.count ?? 0
        case 4:
            if awtaCardTextField.text?.isEmpty ?? true {
                return 1
            }else {
                return viewAction?.clusterGroup.count ?? 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "memberOrGuestCell", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            if let text = viewAction?.memberOrGuest[indexPath.row] {
                cell.configure(with: text)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "haveAnAwtaCard", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            if let text = viewAction?.doYouHaveAnAwtaCard[indexPath.row] {
                cell.configure(with: text)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "howToAttendCell", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            if let text = viewAction?.howWillYouAttend[indexPath.row] {
                cell.configure(with: text)
            }
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "clusterTableGroup", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            if awtaCardTextField.text?.isEmpty ?? true {
                cell.configure(with: "No Data")
            } else if let text = viewAction?.clusterGroup[indexPath.row]{
                cell.configure(with: text)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 1:
            let selectedOption = viewAction?.memberOrGuest[indexPath.row]
            memberOrGuestTableView.isHidden = true
            leftButton.setTitle(selectedOption, for: .normal)
            leftButton.setTitleColor(.black, for: .normal)
            if selectedOption == "Member" {
                isGuest = false
                isMember = true
                rightView.isHidden = false
                rightButton.isHidden = false
                howToAttend.isHidden = false
                bookinCodeView.isHidden = true
                bookingCodeTextField.isHidden = true
            } else {
                rightView.isHidden = true
                rightButton.isHidden = true
                howToAttend.isHidden = false
                isGuest = true
                isMember = false
                awtaCard.isHidden = true
                emailAddress.isHidden = true
                assitance.isHidden = true
                
            }
        case 2:
            let selectedOption = viewAction?.doYouHaveAnAwtaCard[indexPath.row]
            haveAnAwtaCardTableView.isHidden = true
            rightButton.setTitle(selectedOption, for: .normal)
            rightButton.setTitleColor(.black, for: .normal)
            if selectedOption == "Yes, and I still have it." {
                awtaCard.isHidden = false
                emailAddress.isHidden = false
                howToAttend.isHidden = false
                assitance.isHidden = false
            } else {
                awtaCard.isHidden = true
                emailAddress.isHidden = true
                howToAttend.isHidden = false
                assitance.isHidden = true
            }
        case 3:
            let selectedOption = viewAction?.howWillYouAttend[indexPath.row]
            howToAttendTableView.isHidden = true
            howToAttendButton.setTitle(selectedOption, for: .normal)
            howToAttendButton.setTitleColor(.black, for: .normal)
            
            if isGuest && selectedOption == "Hybrid" {
                bookinCodeView.isHidden = false
                bookingCodeTextField.isHidden = false
            } else {
                bookinCodeView.isHidden = true
                bookingCodeTextField.isHidden = true
            }
            
        case 4:
            if awtaCardTextField.text?.isEmpty ?? true {
                return
            } else {
                let selectedOption = viewAction?.clusterGroup[indexPath.row]
                clusterGroupTableView.isHidden = true
                selectClusterButton.setTitle(selectedOption, for: .normal)
                selectClusterButton.setTitleColor(.black, for: .normal)
            }
            
         
        default:
            break
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == awtaCardTextField {
            clusterGroupTableView.reloadData()
            if textField.text?.isEmpty ?? true {
                clusterGroupTableViewHeightConstraint?.constant = 35
                selectClusterButton.setTitle("Select", for: .normal)
                selectClusterButton.setTitleColor(.gray, for: .normal)
            } else {
                clusterGroupTableViewHeightConstraint?.constant = 250
            }
            view.layoutIfNeeded() // Update layout to reflect the change
        }
    }

}

