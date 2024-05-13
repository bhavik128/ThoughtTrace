//
//  AddTaskViewModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 12/5/2024.
//

import Foundation
import FirebaseFirestore

class AddTaskViewModel: ObservableObject {
    @Published var tasks: [ToDoTaskModel] = []
    
    private var db = Firestore.firestore()
    
    func addTask(title: String, dueDate: Date, description: String?, status: TaskStatus, priority: Int, comments: [String], completion: @escaping (String?) -> Void) {
        let taskId = UUID().uuidString
        let newTask = ToDoTaskModel(id: taskId, title: title, dateCreated: Date(), dueDate: dueDate, description: description, status: status, priority: priority, comments: comments)
        
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
        } catch let error {
            print("Error encoding task: \(error)")
        }
    }
    
}





