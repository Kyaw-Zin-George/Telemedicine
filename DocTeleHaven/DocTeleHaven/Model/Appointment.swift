//
//  Appointment.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/3/24.
//

import Foundation
// Define the Appointment data model
import FirebaseFirestoreSwift

struct Appointment: Identifiable, Codable {
    var id: String
    var patientID: String
    var doctorID: String
    var patientName: String
    var doctorName: String
    var speciality: String
    var date: Date
    var time: Date
}

    


