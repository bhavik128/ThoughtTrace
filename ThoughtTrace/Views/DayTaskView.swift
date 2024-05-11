import SwiftUI

struct DayTaskView: View {
    var date: Date
    var body: some View {
        VStack {
            Text("Tasks for \(date, formatter: itemFormatter)")
                .font(.headline)
                .padding()

            // List of dummy tasks
            List {
                Text("Finish the report")
                Text("Meet with the team")
                Text("Call the supplier")
                Text("Prepare presentation slides")
                Text("Check email inbox")
            }
        }
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

// Preview provider for DayTaskView
struct DayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DayTaskView(date: Date())
    }
}
