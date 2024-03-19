//
//  SignInView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-20.
// 

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        NavigationStack {
            VStack{
                // Image
                Image(.MAHAN_LOGO)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 200)
                    .padding(.vertical, 20)
                
                Text("MAHAN")
                    .font(.system(size:40))
                Text("Mind And Health Aid Network")
                    .font(.system(size:20))
            }
            .foregroundColor(Color(Color.mint.opacity(0.8)))
            
            
            
            VStack {
                
                // Form Fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 40)
                                
                // Sign In Button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(Color.mint.opacity(0.8)))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // Sign Up Button
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                    
                } label: {
                    HStack {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                
            }
        }
        
    }
}

// MARK: - Authentication Form Protocol

extension SignInView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
