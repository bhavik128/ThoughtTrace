import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var description: String = ""
    @State private var status: TaskStatus = .toDo

    var body: some View {
        NavigationView {
            Form {
                Section(header: CustomHeaderView(text: "Task Details")) {
                    Text("Task Title")
                        .bold()
                    TextField("Enter title...", text: $title)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.indigo, lineWidth: 2)
                        )
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Text("Task Description")
                        .bold()
                    ZStack(alignment: .topLeading) {
                        if description.isEmpty {
                            Text("Enter description...")
                                .foregroundColor(.gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                        }
                        
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    }
                }
//                .padding(.vertical, 8)
                
//                Spacer() // This spacer might not be needed depending on your layout needs
                
                Section(header: CustomHeaderView(text: "Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Add Task") {
                    addTask()
                }
                .disabled(title.isEmpty)
                .padding()
                .frame(maxWidth: .infinity) // Ensures the button can expand
                .background(title.isEmpty ? Color.gray : Color.indigo) // Color changes based on the 'disabled' state
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20) // Adds padding at the top of the form
            .navigationBarTitle("Add New Task", displayMode: .inline)
//            .navigationBarItems(leading: Button("Cancel") {
//                presentationMode.wrappedValue.dismiss()
//            })
        }
    }
    
    func addTask() {
        //  task creation logic here
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
