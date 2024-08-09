//
//  DoctorDetailsView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct DoctorDetailsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let doctor: Users
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Doctor Details")
                .font(.title)
                .padding(.bottom, 16)
            Text(doctor.initials)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 200, height: 200)
                .background(Color(.systemGray3))
                .clipShape(Circle())
            
            // Display doctor details
            Text("\(doctor.name)")
                .font(.title)
                .foregroundStyle(.cyan)
            Text("\(doctor.email)")
                .font(.footnote)
                .foregroundStyle(Color(.darkGray))
            if let specialization = doctor.specialization {
                Text("\(specialization)")
            }
            NavigationLink(destination: BookAppointmentView(doctorName: doctor.name,doctorID: doctor.id, patientName: viewModel.currentUser?.name ?? "", specialization: doctor.specialization ?? "", patientID: viewModel.currentUser?.id ?? "")) {
                            CustomButton(title: "Book an Appointment")
                        }
            
            
        }
        .padding()
    }
}


//#Preview {
//    DoctorDetailsView(doctor: <#Users#>)
//}
