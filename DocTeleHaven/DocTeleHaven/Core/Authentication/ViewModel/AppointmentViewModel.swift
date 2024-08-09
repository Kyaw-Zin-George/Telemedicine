//
//  AppointmentViewModel.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class AppointmentViewModel: ObservableObject {
    @Published var currentUser: Users?
    private let db = Firestore.firestore()
    @Published var appointments: [Appointment] = []
    
    func fetchAppointments(for role: UserRole) {
            guard let currentUser = Auth.auth().currentUser else {
                print("No user is currently authenticated.")
                return
            }
            
            let userId = currentUser.uid
            
            var query: Query
            if role == .patient {
                query = db.collection("appointments").whereField("patientID", isEqualTo: userId)
            } else {
                query = db.collection("appointments").whereField("doctorID", isEqualTo: userId)
            }
            
            query.getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching appointments: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                let fetchedAppointments = documents.compactMap { document -> Appointment? in
                    do {
                        let appointment = try document.data(as: Appointment.self)
                        return appointment
                    } catch {
                        print("Error decoding appointment: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self?.appointments = fetchedAppointments
                }
            }
        }
    
    
    
    func addAppointment(patientID: String, doctorID: String, patientName: String, doctorName: String, speciality: String, date: Date, time: Date, completion: @escaping (Result<Void, Error>) -> Void) {
        // Check for existing appointments at the same date and time with the same doctor
        let query = db.collection("appointments")
                        .whereField("doctorID", isEqualTo: doctorID)
                        .whereField("date", isEqualTo: Timestamp(date: date))
                        .whereField("time", isEqualTo: Timestamp(date: time))
        let appointmentRef = db.collection("appointments").document()
        
        query.getDocuments { [self] snapshot, error in
            if let error = error {
                // Handle query error
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                // No snapshot available
                completion(.failure(NSError(domain: "YourAppDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve appointments."])))
                return
            }
            
            if !snapshot.documents.isEmpty {
                // An appointment already exists for the selected date and time with the same doctor
                completion(.failure(NSError(domain: "YourAppDomain", code: 1002, userInfo: [NSLocalizedDescriptionKey: "An appointment already exists for the selected date and time with the same doctor."])))
                return
            }
            
            // No existing appointment, proceed to create a new appointment
            let appointmentData: [String: Any] = [
                "id": appointmentRef.documentID,
                "patientID": patientID,
                "doctorID": doctorID,
                "patientName": patientName,
                "doctorName": doctorName,
                "speciality": speciality,
                "date": Timestamp(date: date),
                "time": Timestamp(date: time)
            ]
            
            // Add the appointment to Firestore
            db.collection("appointments").addDocument(data: appointmentData) { error in
                if let error = error {
                    // Appointment creation failed
                    completion(.failure(error))
                } else {
                    // Appointment created successfully
                    completion(.success(()))
                }
            }
        }
    }
    
    
    func fetchPatientAppointments() {
        guard let currentUser = currentUser else {
            print("No user is currently authenticated.")
            return
        }
        
        let userId = currentUser.id
        
        db.collection("appointments")
            .whereField("doctorID", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching appointments: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No appointments found.")
                    return
                }
                
                let fetchedAppointments = documents.compactMap { document -> Appointment? in
                    do {
                        let appointment = try document.data(as: Appointment.self)
                        return appointment
                    } catch {
                        print("Error decoding appointment: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.appointments = fetchedAppointments
                }
            }
    }
        
        // Function to fetch upcoming appointments for a doctor
    func fetchDoctorAppointments() {
        guard let currentUser = currentUser else {
            print("No user is currently authenticated.")
            return
        }
        
        let userId = currentUser.id
        
        db.collection("appointments")
            .whereField("doctorID", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching appointments: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No appointments found.")
                    return
                }
                
                let fetchedAppointments = documents.compactMap { document -> Appointment? in
                    do {
                        let appointment = try document.data(as: Appointment.self)
                        return appointment
                    } catch {
                        print("Error decoding appointment: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.appointments = fetchedAppointments
                }
            }
    }
}
