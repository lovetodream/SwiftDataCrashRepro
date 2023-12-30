//
//  SwiftDataCrashReproApp.swift
//  SwiftDataCrashRepro
//
//  Created by Timo Zacherl on 30.12.23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataCrashReproApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MyModel.self,
            MyOtherModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
