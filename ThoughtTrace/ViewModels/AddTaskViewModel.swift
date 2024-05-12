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
    
    func addTask(title: String, dueDate: Date, description: String?, status: TaskStatus, completion: @escaping () -> Void) {
        let taskId = UUID().uuidString  // Generate a unique ID for the task
        let newTask = ToDoTaskModel(id: taskId, title: title, dateCreated: Date(), dueDate: dueDate, description: description, status: status)
        
        let documentReference = db.collection("tasks").document(taskId)

        do {
            try documentReference.setData(from: newTask) {
                error in
                if let error = error {
                    print("Error writing task: \(error)")
                } else {
                    print("Task successfully written")
                    completion()
                }
            }
        } catch let error {
            print("Error encoding task: \(error)")
        }
    }
}





