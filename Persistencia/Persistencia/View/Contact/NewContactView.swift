//
//  NewContactView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI
import Combine

struct NewContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cep: String = ""
    @State private var numberOne: String = ""
    @State private var numberTwo: String = ""
    @State private var showingAlert = false
    @State private var buttonPressed = false
    
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
        .navigationBarTitle("Novo contato", displayMode: .inline)
        .navigationBarItems(trailing: trailingButton)
    }
    
    
    var trailingButton: some View {
        Button("Salvar") {
            if name.count > 0 {
                self.presentationMode.wrappedValue.dismiss()
                contactViewModel.createContact(name: name, email: email, cep: cep, numberOne: numberOne, numberTwo: numberTwo)
                
            } else {
                showingAlert = true
            }
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Olá"), message: Text("Parece que você esqueceu de dar um nome ao contato."), dismissButton: .default(Text("OK")))
        }
    }
}
