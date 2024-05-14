//
//  AddTaskViewModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 12/5/2024.
//

import FirebaseFirestore
import Foundation

class AddTaskViewModel: ObservableObject {
    @Published var tasks: [ToDoTaskModel] = []
    @Published var title: String = ""
    @Published var dueDate: Date = .init()
    @Published var description: String = ""
    @Published var status: TaskStatus = .toDo
    @Published var priority: Int = 1
    @Published var comments: String = ""
    @Published var shouldNavigateToTaskDetail = false
    @Published var taskAddedSuccess = false

    private var db = Firestore.firestore()

    func addTask(
        title: String, dueDate: Date, authorId: String, description: String?, status: TaskStatus,
        priority: Int, comments: [String], completion: @escaping (String?) -> Void
    ) -> String {
        let taskId = UUID().uuidString
        let newTask = ToDoTaskModel(
            id: taskId, title: title, dateCreated: Date(), dueDate: dueDate, description: description,
            status: status, priority: priority, comments: comments, authorId: authorId
        )

        let documentReference = db.collection("tasks").document(taskId)

        do {
            try documentReference.setData(from: newTask) {
                error in
                if let error = error {
                    print("Error writing task: \(error)")
                } else {
                    print("Task successfully written")
                    completion(taskId)
                }
            }

            return taskId
        } catch {
            print("Error encoding task: \(error)")
            return ""
        }
    }
}
