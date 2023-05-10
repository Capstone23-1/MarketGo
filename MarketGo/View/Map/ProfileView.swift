//
//  ProfileView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var displayName = ""
    @State private var error: String?
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Display Name", text: $displayName)
                        .autocapitalization(.none)
                }
                
                Section {
                    Button(action: saveChanges) {
                        Text("Save Changes")
                    }
                    .disabled(isLoading)
                }
            }
            .navigationBarTitle(Text("Edit Profile"))
        }
        .onAppear(perform: loadUserData)
    }
    
    private func loadUserData() {
        isLoading = true
        let currentUser = Auth.auth().currentUser
        
        currentUser?.reload(completion: { error in
            self.isLoading = false
            guard error == nil else {
                self.error = error?.localizedDescription
                return
            }
            
            self.displayName = currentUser?.displayName ?? ""
        })
    }
    
    private func saveChanges() {
        isLoading = true
        let currentUser = Auth.auth().currentUser
        
        let changeRequest = currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        
        changeRequest?.commitChanges(completion: { error in
            self.isLoading = false
            guard error == nil else {
                self.error = error?.localizedDescription
                return
            }
            
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
