//
//  TaskDetailView.swift
//  ThoughtTrace
//
//  Created by Ky Staal on 9/5/2024.
//

import SwiftUI

struct ToDoTaskDetailView: View {
    //    @ObservedObject var viewModel: TaskViewModel
    var currentToDoTask: ToDoTask
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Text("\(currentToDoTask.title)")
                        .font(.largeTitle)
                        .foregroundStyle(.indigo)
                        .padding(.leading, 20)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    VStack {
                        
                        Image("bin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        // change to correct location/sheet
                        NavigationLink(destination: ContentView()) {
                            Text("Delete Task")
                                .font(.subheadline)
                                .foregroundStyle(.indigo)
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 5)
                    
                    VStack {
                        Image("edit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 38, height: 38)
                            
                        // change to correct location/sheet
                        NavigationLink(destination: ContentView()) {
                            Text("Edit Task")
                                .font(.subheadline)
                                .foregroundStyle(.indigo)
                        }
                    }
                    .padding(.top, 2)
                    .padding(.trailing, 10)
                    
                }
                .padding(.trailing, 10)
                HStack {
                    Text("\((currentToDoTask.status.rawValue))")
                        .font(.title2)
                        .fontWeight(.bold)
                        .background(priorityColour(taskStatus: currentToDoTask.status))
                    Spacer()
                }
                .padding(.leading, 20)
                Divider()
                HStack {
                    Text("Priority:")
                        .fontWeight(.bold)
                    Text("\(currentToDoTask.priority)")
                        .foregroundStyle(.red)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack {
                    Text("Due Date: ")
                        .fontWeight(.bold)
                    // add formatting
                    Text("\((currentToDoTask.dueDate).formatted(date: .abbreviated, time: .omitted))")
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack {
                    Text("Description")
                        .fontWeight(.bold)
                    Text("\(currentToDoTask.description)")
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 1)
                
                HStack{
                    Text("Comments:")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 20)
                
                
                List {
                    ForEach(currentToDoTask.comments, id: \.self) { comment in
                        Text("• \(comment)")
                    }
                    
                }
                
            }
            
        }
    }

}

extension Date {
    func formatted(date: DateFormatter.Style, time: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = date
        formatter.timeStyle = time
        return formatter.string(from: self)
    }
}

func priorityColour(taskStatus: TaskStatus) -> Color {
    switch taskStatus {
    case .toDo:
        return .green
    case .doing:
        return .orange
    case .completed:
        return .gray
    }
}
    #Preview {
        ToDoTaskDetailView(currentToDoTask: ToDoTask(title: "Test", description: "testing this now", dateCreated: Date(), dueDate: Date(), status: .toDo, priority: 1, comments: ["Started today", "added list", "tried again"]))
    }
    
