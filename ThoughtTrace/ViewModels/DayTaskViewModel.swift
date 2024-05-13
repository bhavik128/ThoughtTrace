//
//  DayTaskViewModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 12/5/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class DayTaskViewModel: ObservableObject {
    @Published var tasks = [ToDoTaskModel]()
    private var db = Firestore.firestore()

    func fetchTasks(for date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!

        db.collection("tasks")
            .whereField("dueDate", isGreaterThanOrEqualTo: startOfDay)
            .whereField("dueDate", isLessThan: endOfDay)
            .order(by: "priority", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.tasks = querySnapshot.documents.compactMap { document -> ToDoTaskModel? in
                        try? document.data(as: ToDoTaskModel.self)
                    }.sorted(by: { $0.status.rawValue > $1.status.rawValue })
                } else {
                    print("Error fetching tasks: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
    }
}
