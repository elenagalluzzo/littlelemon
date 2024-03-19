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
                LittleLemonLogo()
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                    .padding(.bottom, 20)
                Spacer()
                Text("First Name")
                    .font(.title3)
                TextField("First Name", text: $firstName)
                    .padding()
                    .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
                Text("Last Name")
                    .font(.title3)
                TextField("Last Name", text: $lastName)
                    .padding()
                    .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
                Text("Email")
                    .font(.title3)
                TextField("Email", text: $email)
                    .padding()
                    .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
                Spacer()
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
                .foregroundColor(.black)
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color("approvedYellow"))
                .cornerRadius(20)
                Spacer()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            .padding()
        }
    }
}

#Preview {
    Onboarding()
}
