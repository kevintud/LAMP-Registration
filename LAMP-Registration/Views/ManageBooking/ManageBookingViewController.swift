//
//  ManageBookingViewController.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/15/24.
//

import UIKit

class ManageBookingViewController: UIViewController {
    var action: ManageBookingProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
        title = "Manage Booking"
        
        setUpUI()
        fetchBannerImage()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: stackView.frame.height)
    }
    
    func setUpUI() {
        
        view.addSubview(contentView)
//        view.addSubview(bottomView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(bannerImage)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(bookingDetailsView)
        
        textView.addSubview(textViewStackView)
        bookingDetailsView.addSubview(bookingDetailsViewStackView)
        
        
        let padding: CGFloat = 10.0
        NSLayoutConstraint.activate([
            // Constraints for contentView
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
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
            bookingDetailsView.heightAnchor.constraint(equalToConstant: 320),
            
            textViewStackView.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            textViewStackView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            textViewStackView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            textViewStackView.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            
            bookingDetailsViewStackView.topAnchor.constraint(equalTo: bookingDetailsView.topAnchor, constant: 10),
            bookingDetailsViewStackView.leadingAnchor.constraint(equalTo: bookingDetailsView.leadingAnchor),
            bookingDetailsViewStackView.trailingAnchor.constraint(equalTo: bookingDetailsView.trailingAnchor),
            bookingDetailsViewStackView.bottomAnchor.constraint(equalTo: bookingDetailsView.bottomAnchor),
            
            
        ])
        
        // Ensure bottomView is brought to the front
        view.bringSubviewToFront(bottomView)
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
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bannerImage: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        return imageView
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
    
    lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 62/255.0, green: 180/255.0, blue: 171/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var textViewStackView: CustomStackView = {
        let stackView = CustomStackView()
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true

        stackView.layer.cornerRadius = 0  // Remove general corner radius
        stackView.layoutIfNeeded()  // Ensures the layout is updated before applying the mask

        DispatchQueue.main.async {
            // Apply bottom corner radius directly
            let maskPath = UIBezierPath(roundedRect: stackView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = stackView.bounds
            maskLayer.path = maskPath.cgPath
            stackView.layer.mask = maskLayer
        }

        return stackView
    }()



    
    lazy var bookingDetailsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 62/255.0, green: 180/255.0, blue: 171/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    lazy var bookingDetailsViewStackView: CustomStackView = {
        let stackView = CustomStackView()
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true

        stackView.layer.cornerRadius = 0
        stackView.layoutIfNeeded()

        DispatchQueue.main.async {
            // Apply bottom corner radius directly
            let maskPath = UIBezierPath(roundedRect: stackView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = stackView.bounds
            maskLayer.path = maskPath.cgPath
            stackView.layer.mask = maskLayer
        }

        return stackView

    }()
    
    


}
