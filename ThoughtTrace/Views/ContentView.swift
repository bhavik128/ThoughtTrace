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
    @State private var topTasks = [
        "Task 1", "Task 2", "Task 3", "Task 4", "Task 5", "Task 6", "Task 7", "Task 8", "Task 9",
    ] // list to be replaced with actual tasks

    var body: some View {
        NavigationView {
            Group {
                if authViewModel.isAuthenticated {
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

                            ScrollView {
                                LazyVStack {
                                    ForEach(topTasks, id: \.self) { task in
                                        Text(task)
                                            .padding(.vertical, 5)
                                            .frame(minWidth: 200)
                                            .background(.indigo)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                    }
                                }
                            }

                            NavigationLink(destination: TaskListView()) {
                                Text("See All Tasks")
                                    .bold()
                                    .foregroundColor(.indigo)
                            }
                        }
                        .padding()
                        .frame(width: 300)
                        .frame(height: 250)
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

#Preview {
    ContentView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel())
}
