//
//  ContentView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 1/5/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject private var quoteViewModel = QuoteViewModel()
    @StateObject private var taskViewModel = LoadTasksViewModel()
    @StateObject private var addTaskViewModel = AddTaskViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if authViewModel.isAuthenticated {
                    VStack {
                        Text("ThoughtTrace")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.indigo)
//                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("Upcoming Tasks")
                                .font(.title2)
                                .foregroundColor(.indigo)
                                .bold()
                            
                            ScrollView {
                                LazyVStack {
                                    ForEach(taskViewModel.tasks) { task in
                                        NavigationLink(destination: ToDoTaskDetailView(taskId: task.id)) {
                                            TaskRowView(task: task)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(width: 350)
                        .frame(height: 420)
                        .background(.indigo.opacity(0.3))
                        .cornerRadius(25)
                        Spacer()
                        
                        HStack {
                            VStack {
                                NavigationLink(destination: AddTaskView().environmentObject(addTaskViewModel)) {
                                    Text("Add New Task")
                                        .font(.title3)
                                        .foregroundColor(.purple)
                                        .bold()
                                }
                                
                                Image("task")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                            
                            Spacer()
                            
                            VStack {
                                NavigationLink(destination: CalendarView()) {
                                    Text("View Calendar")
                                        .font(.title3)
                                        .foregroundColor(.purple)
                                        .bold()
                                }
                                
                                Image("calendar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        VStack {
                            if let quote = quoteViewModel.quote {
                                ScrollView{
                                    Text("\"\(quote.q)\"")
                                        .italic()
                                        .padding(.bottom, 5)
                                    
                                    Text("- \(quote.a)")
                                        .font(.caption)
                                        .padding([.bottom, .leading, .trailing])
                                }
                            } else if let errorMessage = quoteViewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }
                            
                            if quoteViewModel.isLoading {
                                ProgressView()
                            }
                            
                            Button("Regenerate Quote") {
                                quoteViewModel.fetchRandomQuote()
                            }
                            .padding(8)
                            .font(.system(size:12))
                            .frame(width: 150, height: 30)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
//                        .padding()
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .imageScale(.large)
                                    .tint(.indigo)
                            }
                        }
                    }
                } else {
                    SignInView()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct TaskRowView: View {
    var task: ToDoTaskModel
    
    var body: some View {
        let priorityColor: Color
        
        switch task.priority {
        case 5:
            priorityColor = .red
        case 4:
            priorityColor = .orange
        case 3:
            priorityColor = .yellow
        case 2:
            priorityColor = .mint
        case 1:
            priorityColor = .green
        default:
            priorityColor = .indigo // Default color if priority is not within 1 to 5
        }
        
        return HStack {
            Text(task.title)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Text(task.status.rawValue)
                .font(.headline)
                .foregroundColor(.yellow)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
        }
        .frame(minWidth: 300)
        .background(priorityColor) // Set background color based on priority
        .cornerRadius(7)
        .padding(.vertical, 2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {
    ContentView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel()).environmentObject(EditTaskViewModel())
}
