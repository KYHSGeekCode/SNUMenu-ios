//
//  snu_restaurantApp.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import SwiftUI

@main
struct snu_restaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
