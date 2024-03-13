//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-13.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let price: String
}
