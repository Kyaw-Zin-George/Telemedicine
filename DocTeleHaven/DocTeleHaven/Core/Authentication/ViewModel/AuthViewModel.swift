//
//  AuthViewModel.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/2/24.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}


enum UserRole: String, Identifiable {
    case patient = "Patient"
    case doctor = "Doctor"
    
    var id: String {
        return self.rawValue
    }
}

@MainActor // make sure to publish the UI changes on the main thread
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: Users?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUsers()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUsers()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUsers(withEmail email: String, password: String, fullName: String,role:String,specialization: String?) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = Users(id: result.user.uid, name: fullName, email: email, role: role,specialization: specialization)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUsers()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUsers() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: Users.self)
    }
    
    func userRole() -> String? {
            return currentUser?.role
        }
    
}
