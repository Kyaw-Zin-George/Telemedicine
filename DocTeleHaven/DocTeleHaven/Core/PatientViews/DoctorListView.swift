//
//  DoctorListView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct DoctorListView: View {
    @StateObject private var doctorViewModel = DoctorViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(doctorViewModel.doctors) { doctor in
                    Section {
                        NavigationLink(destination: DoctorDetailsView(doctor: doctor)) {
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
                    }
                }
                .onAppear {
                    doctorViewModel.fetchDoctors() // Fetch doctors when the view appears
                }
            }
            .navigationTitle("Doctor List")
        }
    }
}


#Preview {
    DoctorListView()
}
