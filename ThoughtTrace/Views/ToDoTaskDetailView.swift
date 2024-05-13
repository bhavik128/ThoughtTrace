//
//  TaskDetailView.swift
//  ThoughtTrace
//
//  Created by Ky Staal on 9/5/2024.
//

import SwiftUI

struct ToDoTaskDetailView: View {
//    @ObservedObject var viewModel: TaskViewModel
    var currentToDoTask: ToDoTask
    
    var body: some View {
        VStack {
            HStack {
                Text("\(currentToDoTask.title)")
                    .font(.title)
                    .foregroundStyle(.purple)
                Text("\(currentToDoTask.priority)")
                    .font(.title)
                    .foregroundStyle(.red)
                Text("\(currentToDoTask.status.rawValue)")
                    .font(.title)
                    .background(.green)     // change this based on the task status
            }
            Divider()
            HStack {
                Text("Description")
                    .fontWeight(.bold)
                Text("\(currentToDoTask.description)")
            }
            HStack {
                Text("Due Date: ")
                    .fontWeight(.bold)
                // add formatting
                Text("\(currentToDoTask.dueDate)")
            }
            Text("Comments:")
                .font(.title)
            List {
                ForEach(currentToDoTask.comments, id: \.self) { comment in
                    Text("* \(comment)")
                }
            
        }
    }
}

//#Preview {
//    TaskDetailView(viewModel: TaskViewModel(Task(title: "Test", description: "testing this now", dateCreated: Date(), dueDate: Date(), status: .toDo, priority: 1)))
//}

