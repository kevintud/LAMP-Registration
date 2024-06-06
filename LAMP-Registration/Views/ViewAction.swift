//
//  ViewAction.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/5/24.
//

import Foundation
import UIKit

class ViewAction {
    weak var viewController: ViewController?

    init(vc: ViewController? = nil) {
        self.viewController = vc
    }

    var memberOrGuest: [String] = ["Member", "Guest"]
    var doYouHaveAnAwtaCard: [String] = ["None, I'm a new member.", "Yes, but I lost it.", "Yes, and I still have it."]
    var howWillYouAttend: [String] = ["Hybrid", "Online"]

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

    func hideAllTableViews() {
        guard let viewController = viewController else { return }
        viewController.memberOrGuestTableView.isHidden = true
        viewController.haveAnAwtaCardTableView.isHidden = true
        viewController.howToAttendTableView.isHidden = true
    }
}
