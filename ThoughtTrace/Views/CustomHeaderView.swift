import SwiftUI

struct CustomHeaderView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.indigo)
            .listRowInsets(EdgeInsets()) // Remove default padding
    }
}

