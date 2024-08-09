//
//  AppointmentListView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/9/24.
//

import SwiftUI

struct AppointmentsListView: View {
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    
    var body: some View {
        VStack {
            if appointmentViewModel.appointments.isEmpty {
                Text("No appointments found")
            } else {
                List(appointmentViewModel.appointments) { appointment in
                    AppointmentRow(appointment: appointment)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}


//#Preview {
//    AppointmentListView()
//}
