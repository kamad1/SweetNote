import Foundation
import FirebaseAuth

protocol AuthManagerRegistrationUserProtocol: AnyObject {
    func registrationNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class RegistrationManager: AuthManagerRegistrationUserProtocol {
    //MARK: регистрация нового пользователя
    func registrationNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth()
        .createUser(withEmail: user.email, password: user.password) { result, error in
                guard error == nil else {
                    print("Error creating user: \(error?.localizedDescription ?? "No error description")")
                    completion(.failure(error!))
                    return
                }
            // получив пользователя отправляем ему на почту верификацию
            result?.user.sendEmailVerification()
            
            //MARK: ВАЖНО ЭТА СТРАКА ПОСЛЕ выкидывает раз авторизовывает что бы пользователь прошел верификацию по почте
            try? Auth.auth().signOut()
            
            completion(.success(true))
            }
    }
}
