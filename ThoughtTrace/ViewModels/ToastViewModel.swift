//
//  ToastViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 7/5/2024.
//

import Foundation
import SimpleToast

class ToastViewModel: ObservableObject {
    @Published var toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 3.0,
        animation: .easeInOut,
        modifierType: .slide
    )
}
