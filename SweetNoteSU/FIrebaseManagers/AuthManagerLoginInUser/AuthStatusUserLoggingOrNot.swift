import Foundation
import FirebaseAuth

class AuthStatusUserLoggingOrNot {
    static let shared = AuthStatusUserLoggingOrNot()
    private init() {}
    
     var isLoggedIn: Bool {
        if let _ = Auth.auth().currentUser {
            return true
        }
        return false
    }
}
