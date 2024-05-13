import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            Text("Select a Date")
                .font(.title2)
                .bold()
                .padding()

            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            // NavigationLink to navigate directly to the tasks view for the selected date
            NavigationLink(destination: DayTaskView(date: selectedDate)) {
                Text("View Tasks for Selected Date")
            }
            .buttonStyle(.bordered)
            .padding()

            Spacer()
        }
        .navigationTitle("Calendar")
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarView()
        }
    }
}
