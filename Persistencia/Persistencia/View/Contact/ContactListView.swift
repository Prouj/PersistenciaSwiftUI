//
//  ContactListView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var searchText: String = ""
    @ObservedObject var contactViewModel: ContactViewModel
    
    init(contactViewModel: ContactViewModel) {
        self.contactViewModel = contactViewModel
    }
    
    let tabBarImage = ["person.fill", "person.2.fill"]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    VStack {
                        if !contactViewModel.contact.isEmpty {
                            SearchBar(text: $searchText)
                                .padding(.vertical, 10)
                            List {
                                ForEach(contactViewModel.contact.filter({searchText.isEmpty ? true : $0.name!.contains(searchText) })) { item in
                                    NavigationLink(destination: ContactInfoView(contact: item, contactViewModel: contactViewModel)) {
                                        HStack {
                                            Text(item.name ?? "no name")
                                            
                                        }
                                    }
                                    
                                }.onDelete(perform: { indexSet in
                                    indexSet.forEach { index in
                                        let contact = contactViewModel.contact[index]
                                        contactViewModel.deleteContact(contact: contact)
                                    }
                                })
                            }
                        } else {
                            HStack {
                                VStack(alignment: .center) {
                                    Spacer()
                                    Text("Adicione um novo Contato clicando em +")
                                        .fontWeight(.regular)
                                        .font(.system(size: 15))
                                    Spacer()
                                }
                            }
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("Contatos")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                                    NewContactView(contactViewModel: contactViewModel)
                        .onDisappear { contactViewModel.fetch() }
                    ) {
                        Image(systemName: "plus")
                            .padding(.trailing, 20)
                            .padding(.top, 30)
                    }
                }
            }
        }
    }
}
