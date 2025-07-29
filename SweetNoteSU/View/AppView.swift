
import SwiftUI

struct AppView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State  var selectedTab: Int = 0
    var body: some View {
        
            TabView(selection: $selectedTab) {
                MainView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Text("Main")
                    }
                    .tag(0)
                
                AddNoteView(selectedTab: $selectedTab)
                    .tabItem {
                        Text("Add Note")
                    }
                    .tag(1)
            }
        
    }
}

#Preview {
    AppView()
}
