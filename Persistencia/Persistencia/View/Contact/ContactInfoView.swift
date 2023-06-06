//
//  ContactInfoView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI

struct ContactInfoView: View {
    
    @State var contact: Contact
    @ObservedObject var contactViewModel: ContactViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Description(title: "Número 1", info: contact.numberOne ?? "Não há um número 1")
                Description(title: "Número 2", info: contact.numberTwo ?? "Não há um número 1")
                Description(title: "Email", info: contact.email ?? "Não há um email")
                Description(title: "CEP", info: contact.cep ?? "Não há um CEP")
                Spacer()
            }
            
            Spacer()
        }.navigationTitle(contact.name ?? "Sem nome")
            .padding(.leading, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditContactView(contact: contact,
                                                                name: contact.name ?? "",
                                                                email: contact.email ?? "",
                                                                cep: contact.cep ?? "",
                                                                numberOne: contact.numberOne ?? "" ,
                                                                numberTwo: contact.numberTwo ?? "" ,
                                                                contactViewModel: contactViewModel)
                    ) {
                        Text("Editar")
                            .padding(.trailing, 20)
                            .padding(.top, 30)
                    }
                }
            }
    }
}
