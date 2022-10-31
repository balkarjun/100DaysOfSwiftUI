//
//  P11_BookwormApp.swift
//  P11-Bookworm
//
//  Created by Arjun B on 31/10/22.
//

import SwiftUI

@main
struct P11_BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
