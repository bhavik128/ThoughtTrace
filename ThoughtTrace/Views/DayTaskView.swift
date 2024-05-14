import SwiftUI

struct DayTaskView: View {
    var date: Date
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject private var viewModel = DayTaskViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Tasks due on \(date, formatter: DateFormatter.taskDueDateFormatter)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.indigo)
                Spacer()

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(sortedTasks, id: \.id) { task in
                            NavigationLink(destination: ToDoTaskDetailView(taskId: task.id)) {
                                HStack {
                                    Text(task.title)
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                        .lineLimit(1)

                                    Spacer()

                                    Text(task.status.rawValue)
                                        .font(.headline)
                                        .foregroundColor(.yellow)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.black.opacity(0.5))
                                        .cornerRadius(10)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(priorityColor(for: task))
                                .cornerRadius(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }
                .onAppear {
                    viewModel.fetchTasks(for: date)
                }
            }
            .padding(.top, 25)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        ContentView()
                    } label: {
                        Image(systemName: "house.fill")
                            .imageScale(.large)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)
    }
    
    private var sortedTasks: [ToDoTaskModel] {
        viewModel.tasks.sorted {
            if $0.status == .completed && $1.status != .completed {
                return false
            } else if $0.status != .completed && $1.status == .completed {
                return true
            }
            return $0.priority > $1.priority
        }
    }

    private func priorityColor(for task: ToDoTaskModel) -> Color {
        if task.status == .completed {
            return .gray // Set color to gray if the task is completed
        }

        switch task.priority {
        case 5:
            return .red
        case 4:
            return .orange
        case 3:
            return .yellow
        case 2:
            return .mint
        case 1:
            return .green
        default:
            return .indigo // Default color if priority is not within 1 to 5
        }
    }
}

// Custom DateFormatter
extension DateFormatter {
    static let taskDueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

#Preview {
    DayTaskView(date: Date()).environmentObject(AuthViewModel())
}
