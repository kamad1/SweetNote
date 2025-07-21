
import Foundation

@MainActor
class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    
    private var user: UserData?
    @Published var isUserCreated: Bool = false
    var registrationManager: AuthManagerRegistrationUserProtocol?
    
    init(registrationManager: AuthManagerRegistrationUserProtocol?) {
        self.registrationManager = registrationManager
    }
    
    func registrationUser() {
        self.user = UserData(email: email, password: password, name: name, surname: surname)
        
        registrationManager?.registrationNewUser(user: user!) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.isUserCreated = success
                print("User created: \(String(describing: user))")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
}
