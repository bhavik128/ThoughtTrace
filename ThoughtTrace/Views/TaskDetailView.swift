//
//  TaskDetailView.swift
//  ThoughtTrace
//
//  Created by Ky Staal on 9/5/2024.
//

import SwiftUI

struct TaskDetailView: View {
//    @ObservedObject var viewModel: TaskViewModel
    var task: Task
    
    var body: some View {
        VStack {
            HStack {
                Text("\(task.title)")
                    .font(.title)
                    .foregroundStyle(.purple)
                Text("\(task.priority)")
                    .font(.title)
                    .foregroundStyle(.red)
                Text("\(task.status.rawValue)")
                    .font(.title)
                    .background(.green)     // change this based on the task status
            }
            Divider()
            HStack {
                Text("Description")
                    .fontWeight(.bold)
                Text("\(task.description)")
            }
            HStack {
                Text("Due Date: ")
                    .fontWeight(.bold)
                // add formatting
                Text("\(task.dueDate)")
            }
            Text("Comments:")
                .font(.title)
            List {
                ForEach(task.comments, id: \.self) { comment in
                    Text("* \(comment)")
                }
            
        }
    }
}

//#Preview {
//    TaskDetailView(viewModel: TaskViewModel(Task(title: "Test", description: "testing this now", dateCreated: Date(), dueDate: Date(), status: .toDo, priority: 1)))
//}
