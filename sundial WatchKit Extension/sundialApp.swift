//
//  sundialApp.swift
//  sundial WatchKit Extension
//
//  Created by Lyndon Maydwell on 11/4/2023.
//

import SwiftUI

@main
struct sundialApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
