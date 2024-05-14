import Combine
import Firebase
import FirebaseFirestore
import Foundation

class LoadTasksViewModel: ObservableObject {
    @Published var tasks = [ToDoTaskModel]()
    private var db = Firestore.firestore()

    func fetchTasks(authorId: String) async {
        db.collection("tasks")
            .whereField("status", isNotEqualTo: TaskStatus.completed.rawValue)
            .whereField("authorId", isEqualTo: authorId)
            .order(by: "priority", descending: true)
            .order(by: "dueDate")
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.tasks = querySnapshot.documents.compactMap { document in
                        try? document.data(as: ToDoTaskModel.self)
                    }
                } else if let error = error {
                    print("Error fetching tasks: \(error)")
                }
            }
    }
}
