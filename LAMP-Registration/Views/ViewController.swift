//
//  ViewController.swift
//  LAMP-Registration
//
//  Created by Goin-Kevin on 6/4/24.
//

import UIKit

class ViewController: UIViewController {
    var viewAction: ViewAction?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha:1)
        setUpUI()
        fetchBannerImage()
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
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        
        return view
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
    
    lazy var labelsStackView: CustomStackView = {
        let labelsStackView = CustomStackView()
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.spacing = 2
        return labelsStackView
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
        let view = CustomSelectionView(labelText: "Are you a guest or a member?", buttonTitle: "Choose")
        view.setButtonTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var rightView: CustomSelectionView = {
        let view = CustomSelectionView(labelText: "Do you have an AWTA card?", buttonTitle: "Choose")
        view.setButtonTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return view
    }()

    
    lazy var howToAttend: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    lazy var awtaCard: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    lazy var emailAddress: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        
        return view
    }()
    lazy var assitance: ContainerView = {
        let view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var buttons: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha:1)
        
        return view
    }()
    lazy var nextButton: CustomButton = {
        let button = CustomButton(backgroudColor: .white, title: "Next")
        return button
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progress = 0.5
        return progressBar
    }()
    
    lazy var pageLabel: CustomBodyLabel = {
        let label = CustomBodyLabel(textAlignMent: .left)
        label.text = "Page 1 of 2"
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
    
    
    
    ///private method
    
    private func fetchBannerImage() {
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
    
    @objc func leftButtonTapped() {
        // Handle left button tap
        leftView.updateButtonTitle("Selected")
    }
    
    @objc func rightButtonTapped() {
        // Handle right button tap
        rightView.updateButtonTitle("Selected")
    }

    
    
    func setUpUI() {
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(bannerImage)
        stackView.addArrangedSubview(textView)
        textView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        labelsStackView.addArrangedSubview(eventDetailsLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        stackView.addArrangedSubview(memberOrGuest)
        memberOrGuest.addSubview(leftView)
        memberOrGuest.addSubview(rightView)
        stackView.addArrangedSubview(howToAttend)
        stackView.addArrangedSubview(awtaCard)
        stackView.addArrangedSubview(emailAddress)
        stackView.addArrangedSubview(assitance)
        stackView.addArrangedSubview(buttons)
        buttons.addSubview(nextButton)
        buttons.addSubview(progressBar)
        buttons.addSubview(pageLabel)
        
        contentView.addSubview(bottomView)
        bottomView.addArrangedSubview(alreadyRegisteredLabel)
        bottomView.addArrangedSubview(manageBookingButton)
        
        let padding:CGFloat = 10.0
        
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
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2*padding),
            
            bannerImage.heightAnchor.constraint(equalToConstant: 140),
            textView.heightAnchor.constraint(equalToConstant: 320),
            
            memberOrGuest.heightAnchor.constraint(equalToConstant: 100),
            howToAttend.heightAnchor.constraint(equalToConstant: 400),
            awtaCard.heightAnchor.constraint(equalToConstant: 200),
            emailAddress.heightAnchor.constraint(equalToConstant: 200),
            assitance.heightAnchor.constraint(equalToConstant: 200),
            buttons.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            nextButton.leadingAnchor.constraint(equalTo: buttons.leadingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            
            progressBar.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            progressBar.trailingAnchor.constraint(equalTo: pageLabel.leadingAnchor, constant: -5),
            progressBar.widthAnchor.constraint(equalToConstant: 70),
            
            pageLabel.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            pageLabel.trailingAnchor.constraint(equalTo: buttons.trailingAnchor),
            
            labelsStackView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: padding),
            labelsStackView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -padding),
            labelsStackView.topAnchor.constraint(equalTo: textView.topAnchor,  constant: padding),
            labelsStackView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: padding),
            
            // Constraints for leftView and rightView in memberOrGuest
            leftView.leadingAnchor.constraint(equalTo: memberOrGuest.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: memberOrGuest.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: memberOrGuest.bottomAnchor),
            leftView.widthAnchor.constraint(equalTo: memberOrGuest.widthAnchor, multiplier: 0.5),
            
            rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: memberOrGuest.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: memberOrGuest.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: memberOrGuest.trailingAnchor),
            
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            eventDetailsLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: stackView.frame.height)
        print("scrollView frame:", scrollView.frame)
        print("contentView frame:", contentView.frame)
        print("stackView frame:", stackView.frame)
        print("textView frame:", textView.frame)
        print("labelsStackView frame:", labelsStackView.frame)
        print("titleLabel frame:", titleLabel.frame) // Debug
        print("subtitleLabel frame:", subtitleLabel.frame) // Debug
        print("eventDetailsLabel frame:", eventDetailsLabel.frame) // Debug
        print("descriptionLabel frame:", descriptionLabel.frame) // Debug
    }
    
}

