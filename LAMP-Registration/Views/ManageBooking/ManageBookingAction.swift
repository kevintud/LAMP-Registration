//
//  ManageBookingAction.swift
//  LAMP-Registration
//
//  Created by Kevin on 6/15/24.
//

import Foundation
import UIKit
protocol  ManageBookingProtocol {
    
}
class ManageBookingAction:ManageBookingProtocol {
    
    weak var manageBookingController: ManageBookingViewController?
    
    init(manageBookingController: ManageBookingViewController? = nil) {
        self.manageBookingController = manageBookingController
    }
}
