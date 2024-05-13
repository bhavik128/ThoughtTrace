//
//  TaskModel.swift
//  ThoughtTrace
//
//  Created by Ky Staal on 9/5/2024.
//

import Foundation

enum TaskStatus: String, Codable {
    case toDo = "To Do"
    case doing = "Doing"
    case completed = "Completed"
}

struct ToDoTask: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var dateCreated: Date
    var dueDate: Date
    var priority: Int
    var status: TaskStatus
    var comments: [String]

    init(title: String, description: String, dateCreated: Date = Date(), dueDate: Date, status: TaskStatus = .toDo, priority: Int = 1, comments: [String] = []) {
        self.title = title
        self.description = description
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.status = status
        self.priority = priority
        self.comments = comments
    }
    
    
}
