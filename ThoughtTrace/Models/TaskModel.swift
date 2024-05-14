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
    var priority: Int
    var description: String?
    var status: TaskStatus
    var comments: [String]
    var authorId: String

    init(
        id: String, title: String, dateCreated: Date = Date(), dueDate: Date,
        description: String? = nil, status: TaskStatus = .toDo, priority: Int, comments: [String] = [],
        authorId: String
    ) {
        self.id = id
        self.title = title
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.description = description
        self.status = status
        self.comments = comments
        self.priority = priority
        self.authorId = authorId
    }
}

extension ToDoTaskModel {
    static func decode(from data: [String: Any]) throws -> ToDoTaskModel {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
        let decoder = JSONDecoder()
        return try decoder.decode(ToDoTaskModel.self, from: jsonData)
    }
}
