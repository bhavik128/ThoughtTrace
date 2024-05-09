//
//  TaskListViewModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 8/5/2024.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task]
    
    init() {
        self.tasks = []
        testTask()
    }
    
    func testTask() {
        tasks.append(Task(title: "test", description: "This is a test task, hopefully it works okay", dateCreated: Date(), dueDate: Date(), status: .toDo, priority: 1))
    }
    
//    func addTask() {
//        let newTask = Task(title: "Test", description: "This is a test description", dateCreated: Date(), dueDate: Date(), status: .toDo, priority: 1)
//        self.tasks.append(newTask)
//    }
}
