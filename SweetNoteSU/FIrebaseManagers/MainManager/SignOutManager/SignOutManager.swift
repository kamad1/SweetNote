import Foundation
import FirebaseAuth

protocol SignOutManagerProtocol {
    func signOut()
}

final class SignOutManager: SignOutManagerProtocol {
    func signOut() {
        try? Auth.auth().signOut()
    }
}
