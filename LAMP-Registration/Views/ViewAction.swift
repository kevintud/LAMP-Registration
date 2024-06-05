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
}
