import SwiftUI

struct DayTaskView: View {
    var date: Date
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject private var viewModel = DayTaskViewModel()

    var body: some View {
        NavigationView {
            VStack{
                
                Text("Tasks due on \(date, formatter: DateFormatter.taskDueDateFormatter)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.indigo)
                Spacer()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.tasks, id: \.id) { task in
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
                                .background(task.status == .completed ? Color.gray : Color.indigo) // Different background for completed tasks
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

//struct DayTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DayTaskView(date: Date()).environmentObject(AuthViewModel())
//        }
//    }
//    
//    
//}

#Preview {
    DayTaskView(date: Date()).environmentObject(AuthViewModel())
}
