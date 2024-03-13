//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-12.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
