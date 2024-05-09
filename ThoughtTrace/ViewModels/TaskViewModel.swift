//
//  TaskViewModel.swift
//  ThoughtTrace
//
//  Created by Ky Staal Cynthia on 9/5/2024.
//

import Foundation

class TaskViewModel : ObservableObject {
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func addComment(_ comment: String) {
        task.comments.append(comment)
    }
}
