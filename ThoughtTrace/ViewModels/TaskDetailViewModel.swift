import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class ToDoTaskDetailViewModel: ObservableObject {
    @Published var task: ToDoTaskModel?
    private var db = Firestore.firestore()

    func fetchTaskById(taskId: String) {
        let docRef = db.collection("tasks").document(taskId)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                self.task = try? document.data(as: ToDoTaskModel.self)
            } else {
                print("Document does not exist")
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }

    func deleteTask(taskId: String) {
        db.collection("tasks").document(taskId).delete { error in
            if let error = error {
                print("Error deleting task: \(error)")
            } else {
                print("Task successfully deleted")
            }
        }
    }
}
