//
//  TaskModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 8/5/2024.
//

import Foundation

enum TaskStatus: String, Codable {
    case toDo = "To Do"
    case doing = "Doing"
    case completed = "Completed"
}

struct Task: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var dateCreated: Date
    var dueDate: Date
    var comment: String?
    var status: TaskStatus

    init(title: String, dateCreated: Date = Date(), dueDate: Date, comment: String? = nil, status: TaskStatus = .toDo) {
        self.title = title
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.comment = comment
        self.status = status
    }
}
