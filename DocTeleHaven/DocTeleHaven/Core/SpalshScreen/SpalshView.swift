//
//  SwiftUIView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/3/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.cyan, Color.gray, Color.cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Image(.logo)
                            .resizable()
                            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        Text("DocTeleHaven")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        .foregroundColor(.white)
                    }
                )
    }
}

#Preview {
    SplashView()
}
