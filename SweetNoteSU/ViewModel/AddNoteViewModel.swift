
import Foundation
@MainActor
class AddNoteViewModel: ObservableObject {
    private var manager: NoteManager = NoteManager()
    @Published var title: String = ""
    @Published var text: String = ""
    @Published var isAdding: Bool = false
func saveNote() {
        let note = Note(title: title, content: text)
    manager.createdNewNote(note: note) { [weak self] in
        guard let self = self else { return }
        isAdding = true
        text = ""
        title = ""
    }
    }
}
