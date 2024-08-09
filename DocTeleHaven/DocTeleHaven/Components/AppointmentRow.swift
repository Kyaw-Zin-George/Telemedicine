//
//  AppointmentRow.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/9/24.
//

import SwiftUI

struct AppointmentRow: View {
    var appointment: Appointment
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Doctor: \(appointment.doctorName)")
            Text("Date: \(appointment.date, formatter: dateFormatter)")
            Text("Time: \(appointment.time, formatter: timeFormatter)")
        }
        .padding()
    }
    // Date and time formatters
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}

//#Preview {
//    AppointmentRow()
//}
