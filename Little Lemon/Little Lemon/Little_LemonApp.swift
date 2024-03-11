//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-11.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
