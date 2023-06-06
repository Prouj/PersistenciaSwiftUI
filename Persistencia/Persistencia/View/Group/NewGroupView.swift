//
//  NewGroupView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI
import Combine

struct NewGroupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var showingAlert = false
    @State private var showingModal = false
    @State private var searchText: String = ""
    @State private var checked: Bool = false
    @State var contacts: [Contact] = []
    
    public var contactViewModel: ContactViewModel
    var groupViewModel: GroupViewModel
    
    var body: some View {
            VStack {
                VStack {
                    HStack {
                        Text("Nome ")
                            .font(.system(size: 20, weight: .medium))
     
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    HStack {
                        TextField("Nome", text: $name)
     
                            .onReceive(Just(name)) { _ in if name.count > 30 {
                                name = String(name.prefix(30))
                            }}
                            .padding(.leading, 7)
                            .padding(.horizontal, 5)
       
                            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.1))
                            .cornerRadius(20)
                    }.padding(.horizontal, 20)
              
                    HStack {
                        Text("Adicionar Contatos")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        Spacer()
                    }
                   
                    
                    VStack {
                        if !contactViewModel.contact.isEmpty {
                            SearchBar(text: $searchText)
                                .padding(.vertical, 10)
                            List {
                                ForEach(contactViewModel.contact.filter({searchText.isEmpty ? true : $0.name!.contains(searchText) })) { item in
                                    
                                    Button(action: {
                                        contacts.append(item)
                                        if contacts.last == item {
                                            self.checked.toggle()
                                        }
                                    }, label: {
                                        
                                        HStack {

                                            Text(item.name ?? "no name")
                                        }
                                    })
                                    
                                }
                            }
                        } else {
                            HStack {
                                VStack(alignment: .center) {
                                    Spacer()
                                    Text("Adicione um novo Contato")
                                    .fontWeight(.regular)
                                    .font(.system(size: 15))
                                    Spacer()
                                }
                            }

                            
                        }
                    }
                    
                }.foregroundColor(.black)
                Spacer()
            }
        .navigationBarTitle("Novo Grupo", displayMode: .inline)
        .navigationBarItems(trailing: trailingButton)
    }


    var trailingButton: some View {
        Button("Salvar") {
            if name.count > 0 {
                self.presentationMode.wrappedValue.dismiss()
                groupViewModel.createGroup(name: name, contacts: contacts)
            } else {
                showingAlert = true
            }
        }

        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Olá"), message: Text("Parece que você esqueceu de dar um nome ao Grupo"), dismissButton: .default(Text("OK")))
                }
    }
    

}
