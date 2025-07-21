import SwiftUI

struct AuthLoginInView: View {
    @StateObject var viewModel = AuthLoginInViewModel(authLoginInManager: AuthManagerLoginInUser())
    @EnvironmentObject var appViewModel: AppViewModel
    var body: some View {
        VStack {
            Text("АВТОРИЗАЦИЯ")
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10){
                    TextField("Write Email", text: $viewModel.email)
                        .customTextField(color: .purple, opacity: 0.9, corner1: .topLeft, corner2: .topRight)
                       
                    SecureField("Write Password", text: $viewModel.password)
                        .customTextField(color: .purple, opacity: 0.9, corner1: .bottomLeft, corner2: .bottomRight)
                }
                
              
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            Button {
                viewModel.loginIn()
            } label: {
                Text("Авторизоваться")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: .infinity, height: 50)
                    .background(Color.purple)
                    .cornerRadius(20)
            }
            
            Spacer()
            
            Button {
                appViewModel.currentScreen = .registrationView
            } label: {
                Text("Я ошибся нету Аккаунта")
                    
            }

        }
        .background(.gray.opacity(0.2))
        .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
            if newValue {
                appViewModel.currentScreen = .mainView
            }
        }
    }
}

//#Preview {
//    AuthLoginInView()
//}

