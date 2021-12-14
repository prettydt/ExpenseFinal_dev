//
//  ExpenseFinalApp.swift
//  ExpenseFinal
//
//  Created by 国梁李 on 2021/12/14.
//

import SwiftUI

@main
struct ExpenseFinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
