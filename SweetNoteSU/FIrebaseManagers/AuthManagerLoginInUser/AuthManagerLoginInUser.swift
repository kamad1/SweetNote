
import Foundation
import FirebaseAuth

protocol AuthManagerLoginInUserProtocol: AnyObject {
    func loginInUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class AuthManagerLoginInUser: AuthManagerLoginInUserProtocol {
    //MARK: авторизация пользователя
    func loginInUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth()
            .signIn(withEmail: user.email, password: user.password) { result, error in
                guard error == nil else {
                    print("Error creating user: \(error?.localizedDescription ?? "No error description")")
                    completion(.failure(error!))
                    return
                }
                if let user = result?.user, user.isEmailVerified {
                    print("Все хорошо и пользователь подтвердил email")
                    completion(.success(true))
                } else {
                    print("Пользователь не подтвердил email")
                    completion(.success(false))
                }
            }
    }
}


