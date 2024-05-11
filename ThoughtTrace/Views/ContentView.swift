//
//  ContentView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 1/5/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            Group {
                if authViewModel.isAuthenticated {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, world!")

                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("Signout")
                        }
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
