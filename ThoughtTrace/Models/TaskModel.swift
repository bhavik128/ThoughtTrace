//
//  TaskModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 8/5/2024.
//

import Foundation

enum TaskStatus: String, Codable, CaseIterable {
    case toDo = "To Do"
    case doing = "Doing"
    case completed = "Completed"
}

struct ToDoTaskModel: Identifiable, Codable {
    var id: String
    var title: String
    var dateCreated: Date
    var dueDate: Date
    var description: String?
    var status: TaskStatus

    init(id: String, title: String, dateCreated: Date = Date(), dueDate: Date, description: String? = nil, status: TaskStatus = .toDo) {
        self.id = id
        self.title = title
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.description = description
        self.status = status
    }
}
