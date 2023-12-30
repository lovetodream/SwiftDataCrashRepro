//
//  ContentView.swift
//  SwiftDataCrashRepro
//
//  Created by Timo Zacherl on 30.12.23.
//

import SwiftUI
import SwiftData

@Model
final class MyModel {
    var other: MyOtherModel?

    init() {
        self.other = other
    }
}

@Model
final class MyOtherModel {
    var name: String = ""
    @Relationship
    var models: [MyModel]?

    init(name: String) {
        self.name = name
    }
}

struct ContentView: View {
    @Query(FetchDescriptor<MyModel>(sortBy: [SortDescriptor(\MyModel.other?.name)])) // crashes
    // @Query // doesn't crash
    private var models: [MyModel]

    var body: some View {
        List(models) { model in
            Text(model.other?.name ?? "None")
        }
        .overlay {
            if models.isEmpty {
                ContentUnavailableView("No entries in list", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [MyModel.self, MyOtherModel.self], inMemory: true)
}
