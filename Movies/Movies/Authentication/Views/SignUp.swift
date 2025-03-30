//
//  SignUp.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    var body: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
        }
        .edgesIgnoringSafeArea(.all)
        VStack {
            HStack {
                Text("SIGN UP")
                    .font(.custom("Poppins-Bold", size: 62))
                Spacer()
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
                }
                .padding()
                .frame(height: 60)
                .background(.customPurple)
                .cornerRadius(8)
                HStack {
                    Spacer()
                    NavigationLink() {
                        EmptyView()
                    } label: {
                        Text("Forgot password?")
                    }
                }
                VStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Sign Up")
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                            .font(.system(size: 18))
                    })
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.gradientPurple, .gradientBlue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                    NavigationLink() {
                        EmptyView()
                    } label: {
                        Text("Already have an account? Sign in")
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .foregroundStyle(.white)
    }
}
