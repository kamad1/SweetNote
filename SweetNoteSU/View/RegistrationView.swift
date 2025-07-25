import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel(registrationManager: RegistrationManager())
    @EnvironmentObject var appViewModel: AppViewModel
//    @State private var showingAlert = true

    var body: some View {
        VStack {
            Text("РЕГИСТРАЦИЯ")
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10){
                    TextField("Write Email", text: $viewModel.email)
                        .customTextField(color: .purple, opacity: 0.9, corner1: .topLeft, corner2: .topRight)
                       
                    SecureField("Write Password", text: $viewModel.password)
                        .customTextField(color: .purple, opacity: 0.9, corner1: .bottomLeft, corner2: .bottomRight)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    TextField("Write Name", text: $viewModel.name)
                        .customTextField(color: .purple, opacity: 0.7, corner1: .topLeft, corner2: .topRight)
                    
                    TextField("Write Surname", text: $viewModel.surname)
                        .customTextField(color: .purple, opacity: 0.7, corner1: .bottomLeft, corner2: .bottomRight)
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            Button {
                viewModel.registrationUser()
            } label: {
                Text("Registration")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 50)
                    .background(Color.purple)
                    .cornerRadius(20)
            }
            
            Spacer()
            
            Button {
                appViewModel.currentScreen = .authLoginInView
            } label: {
                Text("ХА а у меня уже есть АКК!!!!")
                    
            }
            .alert(isPresented: $viewModel.isShowAlert) {
                        Alert(
                            title: Text("Важное сообщение"),
                            message: Text("Вы ввели не валидный пароль < 6 символов или не корректная почта"),
                            primaryButton: .default(Text("OK")),
                            secondaryButton: .cancel()
                        )
                    }

        }
        .background(.gray.opacity(0.2))
        .onChange(of: viewModel.isUserCreated) { oldValue, newValue in
            if newValue {
                appViewModel.currentScreen = .authLoginInView
            }
        }
       
    }
}

//#Preview {
//    RegistrationView()
//}

