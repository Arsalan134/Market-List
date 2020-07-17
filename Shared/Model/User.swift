//
//  User.swift
//  Market List
//
//  Created by Arsalan Iravani on 14.07.2020.
//

import Foundation
//import CodableFirebase
//import Firebase

struct User: Codable {

    init() {

    }

    var id: String?
    var name: String?
    var lastname: String?
    var email: String?
    var phone: String?
    var imageURL: String?
    var preferences: Preferences?
}

enum MeasurementSystem: String, Codable {
    case metric, imperial
}

struct Preferences: Codable {
    var soundsEnabled: Bool? = true
    var notificationsEnabled: Bool? = true
    var measurementSystem: MeasurementSystem? = .metric

}
