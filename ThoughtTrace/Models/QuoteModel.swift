//
//  QuoteModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 9/5/2024.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id = UUID()
    let q: String // Quote text
    let a: String // Author

    enum CodingKeys: String, CodingKey {
        case q
        case a
    }
}
