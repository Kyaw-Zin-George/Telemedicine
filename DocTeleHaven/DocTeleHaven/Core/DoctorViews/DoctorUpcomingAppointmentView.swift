//
//  UpcomingAppointmentView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct DoctorUpcomingAppointmentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var appointmentViewModel = AppointmentViewModel()
    
    var body: some View {
        NavigationStack {
            if appointmentViewModel.appointments.isEmpty {
                VStack {
                    Text("No relevant appointments at the moment")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
            } else {
                List(appointmentViewModel.appointments) { appointment in
                    Section {
                        NavigationLink(destination: DoctorAppointmentDetailsView(appointment: appointment)) {
                            VStack(alignment: .leading) {
                                Text("Appointment with \(appointment.patientName)")
                                    .font(.headline)
                                Text("Date: \(appointment.date)")
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Upcoming Appointments")
            }
        }
        .onAppear {
            appointmentViewModel.fetchAppointments(for: .doctor)
        }
    }
}

#Preview {
    DoctorUpcomingAppointmentView()
}
