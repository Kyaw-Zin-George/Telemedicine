//
//  CustomButton.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/4/24.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.cyan)
                    .frame(width: geo.size.width - 32, height: 60)
                VStack {
                    Text(title)
                        .font(.title)
                        .foregroundStyle(.white)
                    .shadow(color: Color(.black), radius: 2)
                }
                
            }.padding()
        }
    }
}

#Preview {
    CustomButton(title: "Book")
}
