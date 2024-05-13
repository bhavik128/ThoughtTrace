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

    var body: some View {
        NavigationView {
            Group {
                if authViewModel.isAuthenticated {
                    VStack {
                        Text("ThoughtTrace")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.indigo)
                        Spacer()

                        VStack(alignment: .center) {
                            Text("Upcoming Tasks")
                                .font(.title2)
                                .foregroundColor(.indigo)
                                .bold()

                            ScrollView {
                                LazyVStack {
                                    ForEach(taskViewModel.tasks) { task in
                                        TaskRowView(task: task)
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(width: 350)
                        .frame(height: 450)
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

                        VStack {
                            if let quote = quoteViewModel.quote {
                                Text("\"\(quote.q)\"")
                                    .italic()
                                    .padding()
                                Text("- \(quote.a)")
                                    .font(.caption)
                                    .padding([.bottom, .leading, .trailing])
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
                            .font(.system(size: 12))
                            .frame(width: 150, height: 30)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
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
    }
}

struct TaskRowView: View {
    var task: ToDoTaskModel

    var body: some View {
        HStack {
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
        .background(Color.indigo)
        .cornerRadius(7)
        .padding(.vertical, 2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel())
}
