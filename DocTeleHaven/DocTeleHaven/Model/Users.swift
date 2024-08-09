//
//  Users.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/3/24.
//

import Foundation
struct Users : Identifiable, Codable {
    
    var id: String // Unique ID provided by Firebase Authentication
    var name: String
    var email: String
    var role: String // "patient" or "doctor"
    var specialization: String? // Only for doctors
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}
