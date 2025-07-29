
import Foundation
import FirebaseAuth
import FirebaseFirestore



class NoteManager {
    //создание заметки
    func createdNewNote(note: Note, complition: @escaping () -> Void) {
        guard let referance = getNotesPath() else { return }
        referance
            .addDocument(data: note.getDictionary()) { _ in
                complition()
            }
    }
    
    //чтение заметок
    
    func fetchNotes(complition: @escaping ([Note]) -> ()) {
        guard let referance = getNotesPath() else { return }
        referance
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print("Error fetching notes: \(String(describing: error))")
                    return
                }
                var notes = [Note]()
                
               if let docs = snapshot?.documents {
                   docs.forEach { doc in
                       let docData = doc.data()
                       let note = Note(noteID: doc.documentID, data: docData)
                       notes.append(note)
                       
                   }
                }
                complition(notes)
            }
    }
    
    // редактировать заметку
    func updateNote(noteID: String, newTitle: String) {
        guard let referance = getNotesPath() else { return }
        referance
            .document(noteID)
            .updateData(["title": newTitle])
    }
    // удалить заметку
    func deletedNote(noteID: String) {
        guard let referance = getNotesPath() else { return }
        referance
            .document(noteID)
            .delete()
    }
    
    // функция которая всегда вернет ссылку на путь в коллекцию заметок нужного пользователя(авторизованного) далее используем функцию
    private func getNotesPath() -> CollectionReference? {
        guard let user = Auth.auth().currentUser else { return nil}
        return Firestore.firestore().collection("users").document(user.uid).collection("notes")
    }
}
