
import SwiftUI

@MainActor
class AuthLoginInViewModel: ObservableObject {
    var authLoginInManager: AuthManagerLoginInUserProtocol?
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(authLoginInManager: AuthManagerLoginInUserProtocol?) {
        self.authLoginInManager = authLoginInManager
    }
    
    func loginIn() {
        authLoginInManager?.loginInUser(user: UserData(email: email, password: password)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let isLoggedIn):
                self.isLoggedIn = isLoggedIn
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
