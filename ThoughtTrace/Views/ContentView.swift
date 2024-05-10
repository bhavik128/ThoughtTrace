import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var topTasks = ["Task 1", "Task 2", "Task 3"] 

    var body: some View {
//        Group {
//            if authViewModel.isAuthenticated {

        
                VStack {
                    Text("ThoughtTrace")
                        .font(.title)
                        .bold()
                        .foregroundColor(.indigo)
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("Upcoming Tasks")
                            .font(.headline)
                            .foregroundColor(.indigo)
                            .bold()
                        
                        ForEach(topTasks, id: \.self) { task in
                            Text(task)
                                .padding(.vertical, 5)
                                .frame(minWidth: 200)
                                .background(.indigo)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: TaskListView()) {
                            Text("See All Tasks")
                                .bold()
                                .foregroundColor(.indigo)

                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(.indigo.opacity(0.3))
                    .cornerRadius(25)
                    Spacer()
                    
                    HStack {
                        VStack {
                            NavigationLink(destination: AddTaskView()) {
                                Text("Add New Task")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                    .bold()
                            }
                            
                            
                            
                            Image("task")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                        
                        VStack {
                            NavigationLink(destination: CalendarView()) {
                                Text("View Calendar")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                    .bold()
                            }
                            
                            
                            Image("calendar")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    Spacer()
                    
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Text("Signout")
                    }
                }
                .padding()
//            } else {
//                SignInView()
//            }
//        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
