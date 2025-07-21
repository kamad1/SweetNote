

import Foundation

enum Screen {
    case registrationView, authLoginInView, mainView
}

final class AppViewModel: ObservableObject {
    @Published var currentScreen: Screen = .registrationView
    @Published var isLoggedIn: Bool = false
    init () {
        //строка проверяет авторизован ли пользователь ранее если да то экран перехода маин будет
        self.isLoggedIn = AuthStatusUserLoggingOrNot.shared.isLoggedIn
        // проверка самого значения авторизован или нет переменная будевая
        if isLoggedIn {
            currentScreen = .mainView
        }
    }
}
