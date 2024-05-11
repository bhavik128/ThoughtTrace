//
//  SettingsView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 10/5/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 12) {
                        Text("JD")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemBlue))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text("John Doe")
                                .font(.headline)
                                .fontWeight(.semibold)

                            Text("Email@gmail.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Section(header: Text("Account")) {
                    Button {} label: {
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundColor(.blue)
                            Text("Change Password")
                        }
                    }

                    Button {
                        authViewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .foregroundColor(.red)
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }

                //                Section(header: Text("Preferences")) {
                //                    Toggle(isOn: $toggleState) {
                //                        HStack {
                //                            Image(systemName: "moon.fill")
                //                                .foregroundColor(.purple)
                //                            Text("Dark Mode")
                //                        }
                //                    }
                //                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Settings")
                            .font( /*@START_MENU_TOKEN@*/ .title /*@END_MENU_TOKEN@*/)
                            .fontWeight( /*@START_MENU_TOKEN@*/ .bold /*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(AuthViewModel())
}
