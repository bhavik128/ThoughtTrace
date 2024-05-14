import SwiftUI

struct AddTaskView: View {
    @StateObject var addTaskViewModel = AddTaskViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: CustomHeaderView(text: "Task Details")) {
                    Text("Task Title")
                        .bold()
                    TextField("Enter title...", text: $addTaskViewModel.title)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.indigo, lineWidth: 2)
                        )
                    DatePicker("Due Date", selection: $addTaskViewModel.dueDate, displayedComponents: .date)

                    Text("Task Description")
                        .bold()
                    ZStack(alignment: .topLeading) {
                        if addTaskViewModel.description.isEmpty {
                            Text("Enter description...")
                                .foregroundColor(.gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 5)
                        }

                        TextEditor(text: $addTaskViewModel.description)
                            .frame(height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    }

                    Picker("Priority", selection: $addTaskViewModel.priority) {
                        ForEach(1 ... 5, id: \.self) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("Comments")
                        .bold()
                    TextEditor(text: $addTaskViewModel.comments)
                        .frame(height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                }
                //                .padding(.vertical, 8)

                Section(header: CustomHeaderView(text: "Status")) {
                    Picker("Status", selection: $addTaskViewModel.status) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Button("Add Task") {
                    Task {
                        let taskId = addTaskViewModel.addTask(
                            title: addTaskViewModel.title, dueDate: addTaskViewModel.dueDate,
                            authorId: authViewModel.userSession?.uid ?? "",
                            description: addTaskViewModel.description.isEmpty
                                ? nil : addTaskViewModel.description, status: addTaskViewModel.status,
                            priority: addTaskViewModel.priority,
                            comments: addTaskViewModel.comments.isEmpty ? [] : [addTaskViewModel.comments])
                        { _ in
                            addTaskViewModel.taskAddedSuccess = true
                        }

                        var tasks = authViewModel.currentUser?.tasks ?? []

                        tasks.append(taskId)

                        await authViewModel.saveUser(
                            user: UserModel(
                                id: authViewModel.userSession?.uid ?? "",
                                fullname: authViewModel.currentUser?.fullname ?? "",
                                email: authViewModel.currentUser?.email ?? "", tasks: tasks))
                    }
                }
                .disabled(addTaskViewModel.title.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(addTaskViewModel.title.isEmpty ? Color.gray : Color.indigo)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)

                if addTaskViewModel.taskAddedSuccess {
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
            .alert(
                "Task Added", isPresented: $addTaskViewModel.taskAddedSuccess,
                actions: {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                },
                message: {
                    Text("Your task has been successfully added.")
                })
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AddTaskView().environmentObject(AddTaskViewModel()).environmentObject(AuthViewModel())
}
