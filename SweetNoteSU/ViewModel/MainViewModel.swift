
import Foundation

class MainViewModel: ObservableObject {
    private var signOutManager: SignOutManagerProtocol = SignOutManager()
    func signOut() {
       signOutManager.signOut()
    }
}
