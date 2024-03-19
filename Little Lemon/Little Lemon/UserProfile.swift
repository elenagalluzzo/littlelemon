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
            ZStack {
                LittleLemonLogo()
                    .padding(.bottom, 20)
                HStack {
                    Spacer()
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .frame(width: 50)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
                }
            }
            Text("Personal information")
                .font(.title2)
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text("First Name")
                .font(.title3)
            Text(firstName ?? "")
                .padding()
                .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
            Text("Last Name")
                .font(.title3)
            Text(lastName ?? "")
                .padding()
                .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
            Text("Email")
                .font(.title3)
            Text(email ?? "")
                .padding()
                .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)))
            Spacer()
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .foregroundColor(.black)
            .padding([.leading, .trailing], 40)
            .padding([.top, .bottom], 8)
            .background(Color("approvedYellow"))
            .cornerRadius(20)
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
