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
                AppView()
                    .environmentObject(appViewodel)
            }
            
        }
    }
}

