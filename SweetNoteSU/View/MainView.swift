//
//  MainView.swift
//  SweetNoteSU
//
//  Created by Jedi on 21.07.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        Text("MainView")
        Button {
            vm.signOut()
            viewModel.currentScreen = .registrationView
        } label: {
            Text("Выйти из аккаунта")
        }

    }
}

#Preview {
    MainView()
}
