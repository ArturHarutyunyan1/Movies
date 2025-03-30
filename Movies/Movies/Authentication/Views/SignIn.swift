//
//  SignIn.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct SignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true

    var body: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("SIGN IN")
                    .font(.custom("Poppins-Bold", size: 62))
                    .foregroundColor(.white)

                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                        TextField("", text: $email, prompt: Text("Email").foregroundStyle(.white))
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                    }
                    .padding()
                    .frame(height: 60)
                    .background(Color.customPurple)
                    .cornerRadius(8)

                    HStack {
                        Image(systemName: "lock")
                        if isSecured {
                            SecureField("", text: $password, prompt: Text("Password").foregroundStyle(.white))
                                .autocorrectionDisabled(true)
                        } else {
                            TextField("", text: $password, prompt: Text("Password").foregroundStyle(.white))
                                .autocorrectionDisabled(true)
                        }
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .onTapGesture {
                                withAnimation {
                                    isSecured.toggle()
                                }
                            }
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(height: 60)
                    .background(Color.customPurple)
                    .cornerRadius(8)
                    HStack {
                        Spacer()
                        NavigationLink() {
                            
                        } label: {
                            Text("Forgot Password?")
                                .foregroundStyle(.white)
                        }
                    }
                    Button(action: {}) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .font(.system(size: 18))
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.gradientPurple, .gradientBlue]), startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }

                    NavigationLink() {
                        SignIn()
                    } label: {
                        Text("Don't have an account? Sign Up")
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
    }
}
