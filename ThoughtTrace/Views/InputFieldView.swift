//
//  InputFieldView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 5/5/2024.
//

import SwiftUI

struct InputFieldView: View {
    @ObservedObject var viewModel: InputFieldViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.title)
                .foregroundColor(.gray)
                .fontWeight(.medium)
                .font(.subheadline)

            if viewModel.isSecureField {
                SecureField(viewModel.placeholder, text: $viewModel.text)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    .font(.system(size: 16))
            } else {
                TextField(viewModel.placeholder, text: $viewModel.text)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    .font(.system(size: 16))
            }
        }
        .animation(.easeInOut, value: viewModel.text)
    }
}

#Preview {
    InputFieldView(
        viewModel: InputFieldViewModel(text: "", title: "", placeholder: "", isSecureField: false))
}
