//
//  SignInView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-01-13.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        
        VStack {
            // Image
            Image(.MAHAN_LOGO)
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 150)
            
            Text("MAHAN")
                .font(.system(size:24))
            Text("Mind And Health Aid Network")
                .font(.system(size:17))
            
        }
        .foregroundColor(Color(Color.mint.opacity(0.8)))
        
        
        
        VStack {
            
            
            // Form Fields
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputView(text: $fullname,
                          title: "Full Name",
                          placeholder: "Enter your name")
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                        
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 50)
            
            // Sign In Button
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullName: fullname)
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
            
            Button {
                dismiss()
            } label : {
                HStack {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 14))
            }
            
        }
    }
}

// MARK: - Authentication Form Protocol

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
