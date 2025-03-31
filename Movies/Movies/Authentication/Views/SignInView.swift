//
//  SignInView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.


import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    @Binding var chosenTab: AppTab
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            HStack {
                Text("SIGN IN")
                    .font(.custom("Poppins-Bold", size: 62))
                Spacer()
            }
            if !authenticationManager.errorMessage.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("\(authenticationManager.errorMessage)")
                }
                .padding()
                .frame(width: geometry.size.width * 0.9)
                .background(.red)
                .cornerRadius(8)
                .foregroundStyle(.white)
            }
            VStack {
                HStack {
                    Image(systemName: "envelope")
                    TextField("", text: $email, prompt: Text("Email").foregroundStyle(.white))
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                }
                .padding()
                .frame(height: 60)
                .background(.customPurple)
                .cornerRadius(8)
                HStack {
                    Image(systemName: "lock")
                    if isSecured {
                        SecureField("", text: $password, prompt: Text("Password").foregroundStyle(.white))
                    } else {
                        TextField("", text: $password, prompt: Text("Password").foregroundStyle(.white))
                            .autocorrectionDisabled(true)
                    }
                    Image(systemName: isSecured ? "eye" : "eye.slash")
                        .onTapGesture {
                            withAnimation {
                                isSecured.toggle()
                            }
                        }
                }
                .padding()
                .frame(height: 60)
                .background(.customPurple)
                .cornerRadius(8)
                Button (action: {
                    authenticationManager.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                        .font(.custom("Poppins-Medium", size: 18))
                        .frame(width: geometry.size.width * 0.9, height: 60)
                })
                .frame(width: geometry.size.width * 0.9, height: 60)
                .background(
                    LinearGradient(colors: [.gradientPurple, .gradientBlue], startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(15)
                .foregroundStyle(.white)
                Button(action: {
                    chosenTab = .signup
                }, label: {
                    Text("Don't have an account? Sign Up")
                })
            }
            .foregroundStyle(.white)
        }
    }
}
