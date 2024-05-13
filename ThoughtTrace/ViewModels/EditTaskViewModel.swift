import Foundation
import FirebaseFirestore

class EditTaskViewModel: ObservableObject {
    @Published var editedTask: ToDoTaskModel?
    
    private var db = Firestore.firestore()
    
    func fetchTaskById(taskId: String) {
        db.collection("tasks").document(taskId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching task: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("Task data not found")
                return
            }
            
            do {
                let task = try ToDoTaskModel.decode(from: data) // Manually decoding the data
                self.editedTask = task
            } catch let error {
                print("Error decoding task: \(error)")
            }
        }
    }
    
    
    func updateTask(task: ToDoTaskModel, completion: @escaping (Bool) -> Void) {
        let taskId = task.id
        
        let documentReference = db.collection("tasks").document(taskId)
        
        // data dictionary excluding the 'id'
        let updateData: [String: Any] = [
            "title": task.title,
            "dueDate": Timestamp(date: task.dueDate),  // Converting Date to Firestore Timestamp
            "description": task.description ?? "",
            "status": task.status.rawValue,            // Converting enum to raw value
            "priority": task.priority,
            "comments": task.comments
        ]
        
        documentReference.updateData(updateData) { error in
            if let error = error {
                print("Error updating task: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Task successfully updated")
                completion(true)
            }
        }
    }
    
    
}
