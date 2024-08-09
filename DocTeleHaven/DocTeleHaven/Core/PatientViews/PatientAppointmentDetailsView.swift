//
//  AppointmentDetailsView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/10/24.
//



import SwiftUI
import StreamVideo // Import the Stream Video SDK
import StreamVideoSwiftUI

struct PatientAppointmentDetailsView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @State private var showTabBar = true
    let appointment: Appointment // Assuming you have an Appointment model

    var body: some View {
        NavigationStack {
            VStack(alignment: .center,spacing: 10) {
                Text("Appointment Details")
                    .font(.title)
                
                Text("Doctor: \(appointment.doctorName)")
                Text("Date: \(appointment.date)")
                Text("Time: \(appointment.time)")
                Text("Speciality: \(appointment.speciality)")
                
                Spacer()
                
                NavigationLink(destination: VideoCallView(userId: appointment.patientID, token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRGFydGhfVmFkZXIiLCJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0RhcnRoX1ZhZGVyIiwiaWF0IjoxNzEyODAzMzgzLCJleHAiOjE3MTM0MDgxODh9.8fG6VfMaVpRGMdlrBnW9j5f-_G8lTUjNgFBJuIz4Vl8", callId: appointment.id,userName: appointment.patientName).onTapGesture {
                    showTabBar.toggle()
                })
                {
                    Text("Start Video Call")
                        .font(.title)
                        .foregroundStyle(.white)
                        .background(.blue) // Customize button appearance
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding()
            .navigationBarTitle("Appointment Details", displayMode: .inline)
            
        }
    }
}

//#Preview {
//    AppointmentDetailsView()
//}
