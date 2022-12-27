//
//  SwiftUI_methodApp.swift
//  SwiftUI_method
//
//  Created by Developer on 26.12.2022.
//

import SwiftUI

@main
struct SwiftUI_methodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
