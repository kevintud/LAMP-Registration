//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/27/24.
//

import UIKit

enum SFSymbols {
    static let chevronDown = "chevron.down"
    static let chevronUp = "chevron.up"
}

enum Images {
    static let logo = UIImage(named: "gh-logo")
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    
    static let isIphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isIphone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isIphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isIphone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 8896.0
    static let isiPad = idiom == .phone && ScreenSize.maxLength == 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXsMaxAndXr
    }
}

enum EventDetails {
    static let title = "LAMP WORLDWIDE AWTA 2023"
    static let subtitle = "BE BLESSED PHYSICALLY, MATERIALLY, & SPIRITUALLY"
    static let eventInfo = """
    Event Date: DECEMBER 27-30, 2023
    Event Place: Calamba Tent
    Theme: Year of Clustering
    """
    static let description = """
    Chosen people of God in the Old Testament gather for a so-called solemn assembly (Leviticus 23:36, Joel 1:14) where "offering made by fire unto the Lord" are given to celebrate God. But with Christ's death as ultimate sacrifice for all, today, animal sacrifices are no longer offered. Yet true worshipers of God continue to offer & make fire in the form of praise, worship & thanksgiving.
    
    Annually, LAMP Church gathers & invites every one to congregate for one purpose -- offer worship & thanksgiving to the Lord of Lords!
    """
    
    
    
    static let guestOrMember = "* Are you a guest or a member?"
    static let awtaCard = "* Do you have an AWTA card?"
    static let alreadyRegistered = "Already registered?"
    static let manageBooking = " Manage Booking"
}
