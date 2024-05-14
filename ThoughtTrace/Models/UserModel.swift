//
//  UserModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 11/5/2024.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: String
    var fullname: String
    var email: String
    var tasks: [String]

    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let comp = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: comp)
        }

        return ""
    }
}
