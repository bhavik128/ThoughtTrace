import SwiftUI

struct CustomHeaderView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white) // Set the text color
            .font(.headline) // Set the font
            .padding() // Add padding around the text
            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
            .background(Color.indigo) // Set the background color
            .listRowInsets(EdgeInsets()) // Remove default padding
    }
}
//
//struct CustomSegmentedControl: View {
//    @Binding var status: TaskStatus
//    
//    var body: some View {
//        HStack {
//            ForEach(TaskStatus.allCases, id: \.self) { item in
//                Button(action: {
//                    self.status = item
//                }) {
//                    Text(item.rawValue)
//                        .foregroundColor(self.status == item ? .white : .indigo)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(self.status == item ? Color.blue : Color.clear)
//                        .clipShape(Capsule())
//                }
//            }
//        }
//        .padding(1)
//        .background(Color.gray.opacity(0.2))
//        .clipShape(Capsule())
//    }
//}
