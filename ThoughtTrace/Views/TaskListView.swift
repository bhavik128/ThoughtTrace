//
//  TaskListView.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 7/5/2024.
//

import SwiftUI

struct TaskListView: View {
    
    @State var currentTask: Task?
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        List(viewModel.tasks) {
            task in Text(task.title)
                .onTapGesture {
                    currentTask = task
                }
        }
        .sheet(item: $currentTask) { task in
            TaskDetailView(task: task)
        }
    }
}

#Preview {
    TaskListView(viewModel: TaskListViewModel())
}
