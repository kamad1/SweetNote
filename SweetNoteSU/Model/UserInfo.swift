import Foundation
import FirebaseCore


struct UserInfo: Identifiable {
    var id: String {
        get {
            return "\(name)\(surname)"
        }
    }
    
    var name: String?
    var surname: String?
    var registerDate: Date?
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.surname = data["surname"] as? String ?? ""
        let data = data["regisDate"] as? Timestamp
        self.registerDate = data?.dateValue() ?? Date()
    }
}
