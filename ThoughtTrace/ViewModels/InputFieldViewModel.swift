//
//  InputFieldViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import Foundation

class InputFieldViewModel: ObservableObject {
    @Published var text: String

    let title: String
    let placeholder: String
    let isSecureField: Bool

    init(text: String, title: String, placeholder: String, isSecureField: Bool) {
        self.text = text
        self.title = title
        self.placeholder = placeholder
        self.isSecureField = isSecureField
    }
}
