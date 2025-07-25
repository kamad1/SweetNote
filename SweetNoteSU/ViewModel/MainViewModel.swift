
import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var userInfo: UserInfo?
    @Published var allUsersInfo = [UserInfo]()
    private var signOutManager: SignOutManagerProtocol = SignOutManager()
    private var userInfoManager: PresentUserInfoManagerProtocol = PresentUserInfoManager()
    
    func presentUserInfo() {
        userInfoManager.presentUserInfo { [unowned self] userInfo in
            switch userInfo {
            case .success(let success):
                self.userInfo = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func presentAllUserInfo(){
        userInfoManager.presentAllUserInfo { [unowned self] result in
            switch result {
            case .success(let success):
                self.allUsersInfo = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
           
        }
    }
    
    func signOut() {
       signOutManager.signOut()
    }
}
