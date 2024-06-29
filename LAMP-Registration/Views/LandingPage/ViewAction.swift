//
//  ViewAction.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/5/24.
//

import Foundation
import UIKit

protocol ViewActionProtocol {
    
    func toggleMemberOrGuestTableView()
    func toggleHaveAnAwtaCardTableView()
    func toggleHowToAttendTableView()
    func toggleClusterGroupTableView()
    func hideAllTableViews()
    func createUserSelection() -> UserSelection?
    func validateAndNavigate(userSelection: UserSelection)
    
    var memberOrGuest: [String] { get }
    var doYouHaveAnAwtaCard: [String] { get }
    var howWillYouAttend: [String] { get }
    var clusterGroup: [String] { get }
    
    func alreadyRegister(view: UIViewController)
}
class ViewAction: ViewActionProtocol {
    weak var viewController: ViewController?
    
    init(vc: ViewController? = nil) {
        self.viewController = vc
    }
    
    var memberOrGuest: [String] = ["Member", "Guest"]
    var doYouHaveAnAwtaCard: [String] = ["None, I'm a new member.", "Yes, but I lost it.", "Yes, and I still have it."]
    var howWillYouAttend: [String] = ["Hybrid", "Online"]
    var clusterGroup: [String] =  ["No Cluster Group",
                                   "Angono",
                                   "B1(San Juan)",
                                   "BGC",
                                   "C3C4(Dasmarinas/Bacoor)",
                                   "Campus Ministry",
                                   "Canada",
                                   "CB(Carmona/Binan)",
                                   "LP(Las Pinas)",
                                   "LTB(Buraeun)",
                                   "M1(Soldies/Bicutan)",
                                   "M2(Sta.Rosa)",
                                   "M3(Manggahan)",
                                   "M5(Liberty Homes)",
                                   "M6(Cupang",
                                   "M7(Sucat)",
                                   "MB(Katarungan/Manggahan)",
                                   "M9(Bayanan)",
                                   "MNL(Manila)",
                                   "QC(Quezon City",
                                   "SP1(Langgan/NHA/Batangas)",
                                   "SP2(Brgy. UB)",
                                   "SP4(Bacoor/Paranaque)",
    ]
    
    func toggleMemberOrGuestTableView() {
        guard let viewController = viewController else { return }
        if viewController.memberOrGuestTableView.isHidden {
            viewController.memberOrGuestTableView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                viewController.memberOrGuestTableView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                viewController.memberOrGuestTableView.alpha = 0.0
            }) { _ in
                viewController.memberOrGuestTableView.isHidden = true
            }
        }
    }
    
    func toggleHaveAnAwtaCardTableView() {
        guard let viewController = viewController else { return }
        if viewController.haveAnAwtaCardTableView.isHidden {
            viewController.haveAnAwtaCardTableView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                viewController.haveAnAwtaCardTableView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                viewController.haveAnAwtaCardTableView.alpha = 0.0
            }) { _ in
                viewController.haveAnAwtaCardTableView.isHidden = true
            }
        }
    }
    
    func toggleHowToAttendTableView() {
        guard let viewController = viewController else { return }
        if viewController.howToAttendTableView.isHidden {
            viewController.howToAttendTableView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                viewController.howToAttendTableView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                viewController.howToAttendTableView.alpha = 0.0
            }) { _ in
                viewController.howToAttendTableView.isHidden = true
            }
        }
    }
    
    func toggleClusterGroupTableView() {
        guard let viewController = viewController else { return }
        if viewController.clusterGroupTableView.isHidden {
            viewController.clusterGroupTableView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                viewController.clusterGroupTableView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                viewController.clusterGroupTableView.alpha = 0.0
            }) { _ in
                viewController.clusterGroupTableView.isHidden = true
            }
        }
    }
    
    func hideAllTableViews() {
        guard let viewController = viewController else { return }
        viewController.memberOrGuestTableView.isHidden = true
        viewController.haveAnAwtaCardTableView.isHidden = true
        viewController.howToAttendTableView.isHidden = true
    }
    
    func createUserSelection() -> UserSelection? {
        guard let viewController = viewController else { return nil }
        
        guard let memberOrGuest = viewController.leftButton.title(for: .normal), memberOrGuest != "Choose" else {
            return nil
        }
        
        let awtaCardStatus = viewController.rightButton.title(for: .normal) == "Choose" ? nil : viewController.rightButton.title(for: .normal)
        let attendanceMode = viewController.howToAttendButton.title(for: .normal) == "Choose" ? nil : viewController.howToAttendButton.title(for: .normal)
        let awtaCardNumber = viewController.awtaCardTextField.text?.isEmpty == false ? viewController.awtaCardTextField.text : nil
        let clusterGroup = viewController.selectClusterButton.title(for: .normal) == "Select" ? nil : viewController.selectClusterButton.title(for: .normal)
        let email = viewController.emailAddressTextField.text?.isEmpty == false ? viewController.emailAddressTextField.text : nil
        let assistance = viewController.assistanceTextField.text?.isEmpty == false ? viewController.assistanceTextField.text : nil
        let bookingCode = viewController.bookingCodeTextField.text?.isEmpty == false ? viewController.bookingCodeTextField.text : nil
        
        return UserSelection(memberOrGuest: memberOrGuest, awtaCardStatus: awtaCardStatus, attendanceMode: attendanceMode, awtaCardNumber: awtaCardNumber, clusterGroup: clusterGroup, email: email, assistance: assistance, bookinCode: bookingCode)
    }
    
    func validateAndNavigate(userSelection: UserSelection) {
        guard let viewController = viewController else { return }
        
        switch (userSelection.memberOrGuest, userSelection.awtaCardStatus, userSelection.attendanceMode) {
        case ("Member", "None, I'm a new member.", "Online"):
            print("Push to View 1 with \(userSelection)")
        case ("Member", "None, I'm a new member.", "Hybrid"):
            print("Push to View 2 with \(userSelection)")
        case ("Member", "Yes, but I lost it.", "Online"),
            ("Member", "Yes, but I lost it.", "Hybrid"):
            print("Push to View 3 with \(userSelection)")
        case ("Member", "Yes, and I still have it.", "Hybrid"):
            guard let awtaCardNumber = userSelection.awtaCardNumber, let clusterGroup = userSelection.clusterGroup else {
                let alert = UIAlertController(title: "Incomplete Information", message: "Please provide your AWTA card number and cluster group.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
                return
            }
            let alert = UIAlertController(title: "Confirm Registration", message: "Are you sure you want to register?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                print("Push to View 1 with \(userSelection)")
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        case ("Member", "Yes, and I still have it.", "Online"):
            guard let awtaCardNumber = userSelection.awtaCardNumber, let clusterGroup = userSelection.clusterGroup else {
                let alert = UIAlertController(title: "Incomplete Information", message: "Please provide your AWTA card number and cluster group.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
                return
            }
            let alert = UIAlertController(title: "Confirm Registration", message: "Are you sure you want to register?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                print("Push to View 1 with \(userSelection)")
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        case ("Guest", _, "Online"):
            print("Push to View 2 with \(userSelection)")
        case ("Guest", _, "Hybrid"):
            guard let bookingCode = userSelection.bookinCode, !bookingCode.isEmpty else {
                let alert = UIAlertController(title: "Incomplete Information", message: "Please provide your booking code.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                viewController.present(alert, animated: true, completion: nil)
                return
            }
            print("Push to View 2 with \(userSelection)")
        default:
            let alert = UIAlertController(title: "Incomplete Selection", message: "Please make all required selections before proceeding.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func alreadyRegister(view: UIViewController) {
        let vc = ManageBookingViewController()
        let action = ManageBookingAction(manageBookingController: vc)
        view.navigationController?.setNavigationBarHidden(false, animated: false)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}


struct UserSelection {
    var memberOrGuest: String
    var awtaCardStatus: String?
    var attendanceMode: String?
    var awtaCardNumber: String?
    var clusterGroup: String?
    var email: String?
    var assistance: String?
    var bookinCode: String?
}



