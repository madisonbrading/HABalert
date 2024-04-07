//
//  HABalertApp.swift
//  HABalert
//
//  Created by Madison Brading on 3/31/24.
//
import UIKit

import SwiftUI
import FirebaseCore
import FirebaseFirestore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    let db = Firestore.firestore()
              // [END default_firestore]
    print(db) // silence warning

    return true

  }
}

@main
struct HABalertApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
