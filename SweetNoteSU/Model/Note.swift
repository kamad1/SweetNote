import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Note: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var date: Date = Date()
    
    init(id: String = UUID().uuidString, title: String, content: String, date: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
    
    init(noteID: String, data: [String : Any]) {
        self.id = noteID
        self.title = data["title"] as? String ?? ""
        self.content = data["content"] as? String ?? ""
        let timeStamp = data["date"] as? Timestamp
        self.date = timeStamp?.dateValue() ?? Date()
    }
    
    func getDictionary() -> [ String: Any ] {
        [
            "id": self.id,
            "title": self.title,
            "content": self.content,
            "date": self.date
        ]
    }
}
