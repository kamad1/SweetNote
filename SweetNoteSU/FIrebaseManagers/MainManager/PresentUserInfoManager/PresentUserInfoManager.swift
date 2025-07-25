
import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol PresentUserInfoManagerProtocol{
    func presentUserInfo(completion: @escaping (Result<UserInfo, Error>) -> Void)
    func presentAllUserInfo(completion: @escaping (Result<[UserInfo], Error>) -> Void)
}

final class PresentUserInfoManager: PresentUserInfoManagerProtocol {
    
    // получить 1 пользователя
    func presentUserInfo(completion: @escaping (Result<UserInfo, Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .addSnapshotListener { snapshot, error in
                    guard error == nil  else {
                        completion(.failure(error!))
                        return
                    }
                    
                    if let data = snapshot?.data() {
                        let userInfo = UserInfo(data: data)
                        completion(.success(userInfo))
                    }
                }
        }
    }
    
    func presentAllUserInfo(completion: @escaping (Result<[UserInfo], Error>) -> Void){
        
        
        Firestore.firestore()
            .collection("users")
            .addSnapshotListener { snap, err in
                guard err == nil else {
                    completion(.failure(err!))
                    return
                }
                
                var users = [UserInfo]()
                
                if let docs = snap?.documents{
                    docs.forEach { item in
                        let doc = item.data()
                        let user = UserInfo(data: doc)
                        users.append(user)
                    }
                    
                    completion(.success(users))
                }
            }
    }
}
