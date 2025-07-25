import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol AuthManagerRegistrationUserProtocol: AnyObject {
    func registrationNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class RegistrationManager: AuthManagerRegistrationUserProtocol {
    // надо создать 1 очередь что бы все нужные функции выполнились в 1 потоке
    var firstQueue = DispatchQueue.global(qos: .userInteractive)
    // объявляем переменную  ЛОК который блокирует поток потом где ее выполним
    var lockLine = NSLock()
    
    //MARK: регистрация нового пользователя
    func registrationNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        firstQueue.async {
            Auth.auth()
            .createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
                    guard error == nil else {
                        print("Error creating user: \(error?.localizedDescription ?? "No error description")")
                        completion(.failure(error!))
                        return
                    }
                // получив пользователя отправляем ему на почту верификацию
                result?.user.sendEmailVerification()
                
                if let curentUser = result?.user {
                    //Тут блокируем поток что бы выполнить эту функцию
                    self?.lockLine.lock()
                    
                    self?.saveUserInfoToFirestore(userID: curentUser.uid, user: user)
                }
                
                //MARK: ВАЖНО ЭТА СТРАКА ПОСЛЕ выкидывает раз авторизовывает что бы пользователь прошел верификацию по почте
                try? Auth.auth().signOut()
                completion(.success(true))
                }
        }

    }
    
    private func saveUserInfoToFirestore(userID: String, user: UserData) {
        firstQueue.async {
            let reference = Firestore.firestore()
                .collection("users")
                .document(userID)
            
            reference.setData(["name": user.name ?? "",
                          "surname": user.surname ?? "",
                          "email": user.email,
                          "registerDate": Date()
                         ]) { [weak self] _ in
                self?.savePhotoFirebaseStorage(uid: userID, image: Data()) { result in
                                    if case .success(let url) = result {
                                        reference.setData(["avatar" : url], merge: true)
                                    }
                                }
                    // тут разблокируем поток после выполнения этой функции
                    self?.lockLine.unlock()
                }
        }
    }
    
    private func savePhotoFirebaseStorage(uid: String, image: Data?, completion: @escaping (Result<URL, Error>) -> Void){
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        guard let imageData = image else { return }
        
        let ref = Storage.storage().reference().child("avatar/\(uid)/photo.jpg")
        
        DispatchQueue.global(qos: .userInteractive).async{
            ref.putData(imageData, metadata: metadata) { meta, err in
                guard let _ = meta else {
                    completion(.failure(err!))
                    return
                }
                
                ref.downloadURL { url, err in
                    guard let url = url else {
                        completion(.failure(err!))
                        return
                    }
                    
                    completion(.success(url))
                }
            }
        }
        
    }
}





//MARK: Рабочий код но через комплишен что бы в начале закончилась одна функция и потом вышли из другой для записи данных выше код будет рабочий но через очереди потоков
//final class RegistrationManager: AuthManagerRegistrationUserProtocol {
//    //MARK: регистрация нового пользователя
//    func registrationNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
//        Auth.auth()
//        .createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
//                guard error == nil else {
//                    print("Error creating user: \(error?.localizedDescription ?? "No error description")")
//                    completion(.failure(error!))
//                    return
//                }
//            // получив пользователя отправляем ему на почту верификацию
//            result?.user.sendEmailVerification()
//            
//            if let curentUser = result?.user {
//                self?.saveUserInfoToFirestore(userID: curentUser.uid, user: user) {
//                    //MARK: ВАЖНО ЭТА СТРАКА ПОСЛЕ выкидывает раз авторизовывает что бы пользователь прошел верификацию по почте
//                    try? Auth.auth().signOut()
//                    
//                    completion(.success(true))
//                }
//            }
//            }
//    }
//    
//    private func saveUserInfoToFirestore(userID: String, user: UserData, complition: @escaping () -> Void) {
//        Firestore.firestore()
//            .collection("users")
//            .document(userID)
//            .setData(["name": user.name ?? "",
//                      "surname": user.surname ?? "",
//                      "email": user.email,
//                      "registerDate": Date()
//                     ]) { _ in
//                complition()
//            }
//    }
//}
