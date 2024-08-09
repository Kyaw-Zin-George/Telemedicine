//
//  ProfileView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/2/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let doctor = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(doctor.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(doctor.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(doctor.email)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            
                            if let specialization = doctor.specialization {
                                                            Text(specialization)
                                                                .font(.footnote)
                                                                .foregroundStyle(.blue)
                                                        }
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        Task {
                            viewModel.signOut()
                        }
                    } label: {
                        SettingsRowView(imageName: "rectangle.portrait.and.arrow.right.fill",
                                        title: "Sign Out",
                                        tintColor: .blue)
                    }
                    
                    Button {
                        print("Delete account...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
