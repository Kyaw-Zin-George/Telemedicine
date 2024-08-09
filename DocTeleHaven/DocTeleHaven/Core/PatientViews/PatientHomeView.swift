//
//  PatientHomeView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct PatientHomeView: View {
    @StateObject private var viewModel = DoctorViewModel()
    var body: some View {
        TabView{
            ProfileView().tabItem { Label("Your Profile", systemImage: "person.crop.circle") }
            
            PatientUpcomingAppointmentView().tabItem {Label( "Upcoming Appointments", systemImage:"calendar") }
            DoctorListView().tabItem { Label("Find Doctors", systemImage: "person.3.fill")
            }
            .onAppear {
                                viewModel.fetchDoctors() // Fetch doctors when the AppointmentView appears
                            }
        }
        .onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

#Preview {
    PatientHomeView()
}
