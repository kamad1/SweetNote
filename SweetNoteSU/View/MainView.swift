
import SwiftUI


struct MainView: View {
//    @State var isEditingNote: Bool? = false
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    List {
                        ForEach(vm.allNotes) { item in
                            VStack(alignment: .leading){
                                HStack{
                                    Text(item.title)
                                        .font(.headline)
                                    Spacer()
                                    Text(item.date.dateToString())
                                        .font(.caption)
                                }
                                Text(item.content)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                            .onTapGesture {
                                $vm.isEditingNote?.toggle()
                                vm.editingNoteID = item.id
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let id = vm.allNotes[index].id
                                vm.deleteNote(id: id)
                            }
                        }
                    }
                    .alert("Редактировать", isPresented: $vm.isEditingNote) {
                        TextField("New Title", text: $vm.newTitle)
                        Button("cancel", role: .cancel)
                        Button {
                            vm.updateNote()
                        } label: {
                            Text("Save")
                        }
                    }
                }
                .navigationTitle(Text(vm.userInfo?.name ?? "No name"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            vm.signOut()
                            viewModel.currentScreen = .registrationView
                        } label: {
                            Text("Выйти из аккаунта")
                        }
                    }
                }
            }
//            .onAppear {
////                vm.presentUserInfo()
//            }
        }
        
        
    }
}

#Preview {
    MainView()
}
