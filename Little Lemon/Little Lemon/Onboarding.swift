//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-12.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Text("First Name")
                    .font(.subheadline)
                TextField("First Name", text: $firstName)
                Text("Last Name")
                    .font(.subheadline)
                TextField("Last Name", text: $lastName)
                Text("Email")
                    .font(.subheadline)
                TextField("Email", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
