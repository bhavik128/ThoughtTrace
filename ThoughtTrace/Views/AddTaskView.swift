import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var addTaskViewModel: AddTaskViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var description: String = ""
    @State private var status: TaskStatus = .toDo
    @State private var priority: Int = 1
    @State private var comments: String = ""
    @State private var shouldNavigateToTaskDetail = false
    @State private var taskAddedSuccess = false

    var body: some View {
        NavigationStack {
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
                            .frame(height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    }
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(1...5, id: \.self) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                                        
                    Text("Comments")
                        .bold()
                    TextEditor(text: $comments)
                        .frame(height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                }
//                .padding(.vertical, 8)
                
                Section(header: CustomHeaderView(text: "Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Button("Add Task") {
                    addTaskViewModel.addTask(title: title, dueDate: dueDate, description: description.isEmpty ? nil : description, status: status, priority: priority, comments: comments.isEmpty ? [] : [comments]) { _ in
                        taskAddedSuccess = true
                    }
                }
                .disabled(title.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(title.isEmpty ? Color.gray : Color.indigo) // Color changes based on the 'disabled' state
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                if taskAddedSuccess {
                    Text("Task successfully added!")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                
            }
            .navigationTitle("Add New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        ContentView()
                    } label: {
                        Image(systemName: "house.fill")
                            .imageScale(.large)
                    }
                }
            }
            .alert("Task Added", isPresented: $taskAddedSuccess, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text("Your task has been successfully added.")
            })
        }
        .navigationBarHidden(true)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView().environmentObject(AddTaskViewModel()).environmentObject(AuthViewModel())
    }
}
