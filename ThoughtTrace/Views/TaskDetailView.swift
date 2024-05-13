//
//  TaskDetailView.swift
//  ThoughtTrace
//
//  Created by Ky Staal on 9/5/2024.
//

import SwiftUI

struct ToDoTaskDetailView: View {
    @ObservedObject var viewModel = ToDoTaskDetailViewModel()
    var taskId: String
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditTaskViewPresented = false
    
    var body: some View {
        NavigationView {
            if let task = viewModel.task {
                taskDetailView(for: task)
            } else {
                Text("Loading task details...")
                    .onAppear {
                        viewModel.fetchTaskById(taskId: taskId)
                    }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Task"),
                message: Text("Are you sure you want to delete this task?"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteTask()
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $isEditTaskViewPresented) {
            if let task = viewModel.task {
                EditTaskView(task: task) 
            }
        }
    }
    
    private func taskDetailView(for task: ToDoTaskModel) -> some View {
            VStack {
                Spacer()
                HStack {
                    Text("\(task.title)")
                        .font(.largeTitle)
                        .foregroundStyle(.indigo)
                        .padding(.leading, 20)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    VStack {
                        
                        Image("bin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            Text("Delete Task")
                                .font(.subheadline)
                                .foregroundStyle(.indigo)
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 5)
                    
                    VStack {
                        Image("edit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 38, height: 38)
                            
                        Button(action: {
                            isEditTaskViewPresented = true
                        }) {
                            Text("Edit Task")
                                .font(.subheadline)
                                .foregroundStyle(.indigo)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.trailing, 10)
                    
                }
                .padding(.trailing, 10)
                HStack {
                    Text("\((task.status.rawValue))")
                        .font(.title2)
                        .fontWeight(.bold)
                        .background(priorityColour(taskStatus: task.status))
                    Spacer()
                }
                .padding(.leading, 20)
                Divider()
                HStack {
                    Text("Priority:")
                        .fontWeight(.bold)
                    Text("\(task.priority)")
                        .foregroundStyle(.red)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack {
                    Text("Due Date: ")
                        .fontWeight(.bold)
                    // add formatting
                    Text("\((task.dueDate).formatted(date: .abbreviated, time: .omitted))")
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack {
                    Text("Description")
                        .fontWeight(.bold)
                    Text("\(task.description ?? "")")
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack{
                    Text("Comments:")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 20)
                
                
                List {
                    ForEach(task.comments, id: \.self) { comment in
                        Text("• \(comment)")
                    }
                    
                }
                
            }
            
    }
    
    private func deleteTask() {
        viewModel.deleteTask(taskId: taskId)
        DispatchQueue.main.async {
            presentationMode.wrappedValue.dismiss()
        }
    }



}

extension Date {
    func formatted(date: DateFormatter.Style, time: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = date
        formatter.timeStyle = time
        return formatter.string(from: self)
    }
}

func priorityColour(taskStatus: TaskStatus) -> Color {
    switch taskStatus {
    case .toDo:
        return .green
    case .doing:
        return .orange
    case .completed:
        return .gray
    }
}


    
struct ToDoTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoTaskDetailView(viewModel: previewViewModel(), taskId: "sampleTaskID").environmentObject(AuthViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }

    // Helper function to configure the view model with the sample task
    static func previewViewModel() -> ToDoTaskDetailViewModel {
        let sampleTask = ToDoTaskModel(
            id: "sampleTaskID",
            title: "Complete SwiftUI View",
            dueDate: Date(), // Use the current date for simplicity
            description: "Finish the SwiftUI view for the task detail and integrate it with the existing app.",
            status: .doing,
            priority: 1,
            comments: ["Review the design specs", "Check integration points", "Discuss UI changes with the team"]
        )
        
        let viewModel = ToDoTaskDetailViewModel()
        viewModel.task = sampleTask
        return viewModel
    }
}
