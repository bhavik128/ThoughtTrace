//
//  SettingsView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 10/5/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 12) {
                        Text(authViewModel.currentUser?.initials ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(.indigo)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(authViewModel.currentUser?.fullname ?? "")
                                .font(.headline)
                                .fontWeight(.semibold)

                            Text(authViewModel.currentUser?.email ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Section(header: Text("Account")) {
                    Button {
                        settingsViewModel.showChangePassword.toggle()
                    } label: {
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
            .sheet(isPresented: $settingsViewModel.showChangePassword) {
                ChangePasswordView()
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel())
}
