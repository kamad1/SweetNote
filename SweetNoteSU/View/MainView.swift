
import SwiftUI


struct MainView: View {
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        Text("MainView")
        
        VStack {
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(vm.userInfo?.name ?? "No name)")
                    }
                    HStack {
                        Text("Surname")
                        Spacer()
                        Text(vm.userInfo?.surname ?? "No Surname)")
                    }
                    
                }
                .padding(.horizontal, 30)
//                Spacer()
//                Button {
//                    vm.signOut()
//                    viewModel.currentScreen = .registrationView
//                } label: {
//                    Text("Выйти из аккаунта")
//                }
            }
            .onAppear {
                vm.presentUserInfo()
            }
            
            List {
                ForEach(vm.allUsersInfo) { user in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text(user.name ?? "No name)")
                        }
                        HStack {
                            Text("Surname")
                            Spacer()
                            Text(user.surname ?? "No Surname)")
                        }
                    }
                }
            }
            .onAppear {
                vm.presentAllUserInfo()
            }
            Spacer()
            Button {
                vm.signOut()
                viewModel.currentScreen = .registrationView
            } label: {
                Text("Выйти из аккаунта")
            }
        }
        
        
    }
}

#Preview {
    MainView()
}
