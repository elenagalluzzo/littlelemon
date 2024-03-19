//
//  LittleLemonLogo.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-18.
//

import SwiftUI

struct LittleLemonLogo: View {
    var body: some View {
        Image("littleLemon")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
    }
}

struct LittleLemonLogo_Previews: PreviewProvider {
    static var previews: some View {
        LittleLemonLogo()
    }
}
