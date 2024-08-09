//
//  ContentView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    @EnvironmentObject var doctorViewModel: DoctorViewModel
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                self.showSplash = false
                            }
                        }
                    }
            } else {
                if viewModel.userSession != nil {
                    if let role = viewModel.userRole() {
                        if role == "Doctor" {
                            DoctorHomeView()
                        } else {
                            PatientHomeView()
                        }
                    } else {
                        // Handle case where role is not found
                        Text("Role not found")
                    }
                } else {
                    LoginView()
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
