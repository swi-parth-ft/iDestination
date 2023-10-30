//
//  iDestinationApp.swift
//  iDestination
//
//  Created by Parth Antala on 2023-10-09.
//

import SwiftUI
import SwiftData

@main
struct iDestinationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Destination.self)
    }
}
