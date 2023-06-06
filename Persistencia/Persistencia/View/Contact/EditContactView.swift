//
//  EditContactView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI
import Combine

struct EditContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var contact: Contact
    @State var name: String
    @State var email: String
    @State var cep: String
    @State var numberOne: String
    @State var numberTwo: String
    @State private var showingAlert = false
    
    var contactViewModel: ContactViewModel

    var body: some View {
            VStack {
                VStack {
                    InputView(text: $name, title: "Nome", placeholder: "nome")
                    InputView(text: $email, title: "Email", placeholder: "aaaa@mail.com")
                    InputView(text: $cep, title: "CEP", placeholder: "00000-000")
                    InputView(text: $numberOne, title: "Numero 1", placeholder: "(00) 00000000")
                    InputView(text: $numberTwo, title: "Numero 2", placeholder: "(00) 00000000")

                }.foregroundColor(.black)
                Spacer()
            }
        .navigationBarTitle("Edição", displayMode: .inline)
        .navigationBarItems(trailing: trailingButton)
    }


    var trailingButton: some View {
        Button("Salvar") {
            if name.count > 0 {
                self.presentationMode.wrappedValue.dismiss()
                contactViewModel.updateContact(contact: contact ,name: name, email: email, cep: cep, numberOne: numberOne, numberTwo: numberTwo)
            } else {
                showingAlert = true
            }
        }

        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Olá"), message: Text("Parece que você esqueceu de dar um nome ao contato."), dismissButton: .default(Text("OK")))
                }
    }
}
