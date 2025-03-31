//
//  Verification.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct Verification: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @State private var timeRemaining: Int = 61
    @State private var isDisabled: Bool = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
            }
            .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Verification")
                        .font(.custom("Poppins-Bold", size: 40))
                        .foregroundStyle(.white)
                    Text("Verification email was sent to \(authenticationManager.user?.email ?? "")")
                        .font(.custom("Poppins-Medium", size: 15))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    Button(action: {
                        authenticationManager.sendVerificationEmail(to: authenticationManager.user?.email ?? "")
                        isDisabled = true
                        timeRemaining = 61
                    }, label: {
                        Text("\(timeRemaining == 0 ? "Resend verification email" : "Resend in \(timeRemaining) seconds")")
                    })
                    .disabled(isDisabled)
                    Button(action: {
                        authenticationManager.signOut()
                    }, label: {
                        Text("Change account")
                    })
                    Button (action: {
                        authenticationManager.checkVerificationStatus()
                    }, label: {
                        Text("Check verification status")
                            .font(.custom("Poppins-Medium", size: 18))
                            .frame(width: geometry.size.width * 0.9, height: 60)
                            .foregroundStyle(.white)
                    })
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .background(
                        LinearGradient(colors: [.gradientPurple, .gradientBlue], startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onReceive(timer) {newTime in
            if timeRemaining > 0 {
                isDisabled = true
                timeRemaining -= 1
            }
            if timeRemaining == 0 {
                isDisabled = false
            }
        }
    }
}

#Preview {
    Verification()
}
