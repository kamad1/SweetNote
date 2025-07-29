
import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var userInfo: UserInfo?
    @Published var allUsersInfo = [UserInfo]()
    @Published var allNotes: [Note] = []
    @Published var isEditingNote = false
    @Published var editingNoteID: String?
    @Published var newTitle: String = ""
    private var noteManager: NoteManager = NoteManager()
    private var signOutManager: SignOutManagerProtocol = SignOutManager()
    private var userInfoManager: PresentUserInfoManagerProtocol = PresentUserInfoManager()
    
    init () {
        // что бы только 1 раз срабатывал но это работает только с НАВИГАТИОН СТЭК  с навиг вью не работает тогда онАпир делать во вью закомитил его
        fetchAllNotes()
        presentUserInfo()
        print(1)
    }
    
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
        userInfoManager.presentAllUserInfo { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let success):
                self?.allUsersInfo = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
           
        }
    }
    
    func signOut() {
       signOutManager.signOut()
    }
    
    func fetchAllNotes(){
        noteManager.fetchNotes { [weak self] note in
            guard let self = self else { return }
            self.allNotes = note
        }
    }
    
    func deleteNote(id: String) {
        noteManager.deletedNote(noteID: id)
//        fetchAllNotes()
    }
    
    func updateNote(id: String) {
        guard let editingNoteID else { return }
        noteManager.updateNote(noteID: editingNoteID, newTitle: newTitle)
    }
}
