//
//  BookingAppointmentView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct BookAppointmentView: View {
    
    @StateObject var appointmentViewModel = AppointmentViewModel()
    @State private var showAlert = false
        @State private var alertMessage = ""
    
    let doctorName: String
    let doctorID: String
    let patientName: String
    let specialization: String
    let patientID : String

    @State private var selectedDate = Date()
    @State private var selectedTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!

    // Closed range for time interval (9:00 AM to 9:00 PM)
    private let startTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
    private let endTime = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!
    
    func addAppointment() {
            appointmentViewModel.addAppointment(patientID: patientID, doctorID: doctorID, patientName: patientName, doctorName: doctorName, speciality: specialization, date: selectedDate, time: selectedTime) { result in
                switch result {
                case .success:
                    // Appointment created successfully
                    alertMessage = "Appointment created successfully."
                                    showAlert = true
                    // You can perform any additional actions here, such as navigating to a different view or showing a success message.
                case .failure(let error):
                    // Appointment creation failed
                    alertMessage = "Failed to create appointment: \(error.localizedDescription)"
                    showAlert = true
                    // You can inform the user about the failure, such as showing an error message.
                }
            }
        }
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack {
                    Text("Doctor's Name: \(doctorName)")
                        .font(.title2)
                    
                    Text("Patient's Name: \(patientName)")
                    Text("Specialization: \(specialization)")

                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    DatePicker("", selection: $selectedTime, in: startTime...endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    // Additional UI for confirming the appointment
                   Button{
                       Task{
                           addAppointment()
                       }
                    }label: {
                        Text("Confirm Booking")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .background(.cyan)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
            .navigationTitle("Book Appointment")
            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Appointment Status"),
                                    message: Text(alertMessage),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
            }
        }
    }
}

    #Preview {
        BookAppointmentView(doctorName: "SampleDoctorName",doctorID: "doc001", patientName: "Helen", specialization: "Gastrologist", patientID: "p001")
    }
