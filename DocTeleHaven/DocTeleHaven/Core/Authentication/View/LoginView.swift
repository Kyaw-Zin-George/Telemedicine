//
//  Login View.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/2/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var roleSelection: UserRole = .patient
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showAlert = false
        @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeHolder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your password",
                              isSecureField: true)
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign in button
            
            Button {
                Task {
                    try await viewModel.signIn(withEmail: email, password: password)
                }
            } label: {
                HStack {
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 24)
            
            Spacer()
            
            // sign up button
            
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack(spacing: 3) {
                    Text("Don't have an account?")
                    Text("Sign up")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            
        }
    }
}


// Mark: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
    }
    
}

#Preview {
    LoginView()
}
