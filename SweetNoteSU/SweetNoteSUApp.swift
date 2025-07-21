//
//  SweetNoteSUApp.swift
//  SweetNoteSU
//
//  Created by Jedi on 18.07.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SweetNoteSUApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appViewodel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            switch appViewodel.currentScreen {
            case .registrationView:
                RegistrationView()
                    .environmentObject(appViewodel)
            case .authLoginInView:
                AuthLoginInView()
                    .environmentObject(appViewodel)
            case .mainView:
                MainView()
                    .environmentObject(appViewodel)
            }
            
        }
    }
}

