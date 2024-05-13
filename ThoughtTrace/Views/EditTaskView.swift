import SwiftUI

struct EditTaskView: View {
//    @EnvironmentObject var editTaskViewModel: EditTaskViewModel
    @ObservedObject private var editTaskViewModel = EditTaskViewModel()
    @Environment(\.presentationMode) var presentationMode

    var task: ToDoTaskModel

    @State private var title: String
    @State private var dueDate: Date
    @State private var description: String
    @State private var status: TaskStatus
    @State private var priority: Int
    @State private var comments: String
    @State private var showingUpdateAlert = false
    @State private var updateSuccess = false

    init(task: ToDoTaskModel) {
        self.task = task
        self._title = State(initialValue: task.title)
        self._dueDate = State(initialValue: task.dueDate)
        self._description = State(initialValue: task.description ?? "")
        self._status = State(initialValue: task.status)
        self._priority = State(initialValue: task.priority)
        self._comments = State(initialValue: task.comments.joined(separator: "\n"))
    }

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
                
                Section(header: CustomHeaderView(text: "Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Update Task") {
                    let updatedTask = ToDoTaskModel(
                        id: task.id,
                        title: title,
                        dueDate: dueDate,
                        description: description.isEmpty ? nil : description,
                        status: status,
                        priority: priority,
                        comments: comments.components(separatedBy: .newlines)
                    )
                    
                    editTaskViewModel.updateTask(task: updatedTask) { success in
                        updateSuccess = success
                        showingUpdateAlert = true
                    }
                }
                .disabled(title.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(title.isEmpty ? Color.gray : Color.indigo) // Color changes based on the 'disabled' state
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
            .navigationTitle("Edit Task")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showingUpdateAlert) {
                  Alert(
                      title: Text(updateSuccess ? "Success" : "Error"),
                      message: Text(updateSuccess ? "Task has been successfully updated." : "Failed to update the task."),
                      dismissButton: .default(Text("OK")) {
                          if updateSuccess {
                              presentationMode.wrappedValue.dismiss()
                          }
                      }
                  )
              }
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = ToDoTaskModel(
            id: "sampleTaskID",
            title: "Sample Task",
            dueDate: Date(),
            description: "Sample description",
            status: .toDo,
            priority: 3,
            comments: ["Comment 1", "Comment 2"]
        )
        
        return EditTaskView(task: sampleTask).environmentObject(EditTaskViewModel())
    }
}
