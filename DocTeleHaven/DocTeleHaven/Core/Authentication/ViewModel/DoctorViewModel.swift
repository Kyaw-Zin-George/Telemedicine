//
//  DoctorViewModel.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
// Fetch doctors from Firebase Firestore
class DoctorViewModel: ObservableObject {
    @Published var doctors: [Users] = [] // Users model instead of Doctor model

    private var db = Firestore.firestore()

    func fetchDoctors() {
        db.collection("users")
            .whereField("role", isEqualTo: "Doctor")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching doctors: \(error.localizedDescription)")
                    return
                }

                guard let snapshot = snapshot else { return }

                self.doctors = snapshot.documents.compactMap { document in
                    try? document.data(as: Users.self) // Use Users model instead of Doctor model
                }
            }
    }
}
