//
//  DoctorHomeView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct DoctorHomeView: View {
    var body: some View {
        TabView{
            ProfileView().tabItem { Label("Profile",systemImage: "person")}
            DoctorUpcomingAppointmentView().tabItem { Label("UpcomingAppointment", systemImage: "calendar") }
            
        }.onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

struct DoctorHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AuthViewModel()
        DoctorHomeView()
            .environmentObject(viewModel)
    }
}
