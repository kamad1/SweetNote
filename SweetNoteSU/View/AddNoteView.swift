//
//  AddNoteView.swift
//  SweetNoteSU
//
//  Created by Jedi on 29.07.2025.
//

import SwiftUI

struct AddNoteView: View {
@StateObject var vm = AddNoteViewModel()
    @Binding var selectedTab: Int
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $vm.title)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            TextEditor(text: $vm.text)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
            //для изменения заднего фона
                .scrollContentBackground(.hidden)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Spacer()
            
            Button {
                vm.saveNote()
            } label: {
                Text("Add Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
            }

        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .onAppear{
            vm.isAdding = false
        }
        .onChange(of: vm.isAdding) { _, newValue in
            if newValue {
                selectedTab = 0
            }
        }
    }
}

//#Preview {
//    AddNoteView()
//}
