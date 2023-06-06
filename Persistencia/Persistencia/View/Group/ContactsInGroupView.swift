//
//  ContactsInGroupView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI

struct ContactsInGroupView: View {
    @State var searchText: String = ""
    @State var group: Group
    
    @ObservedObject var groupViewModel: GroupViewModel
    @ObservedObject var contactViewModel: ContactViewModel
    
    var body: some View {
                ZStack(alignment: .top) {
                    VStack {
                        VStack {
                            if !group.contactArray.isEmpty {
                                SearchBar(text: $searchText)
                                    .padding(.vertical, 10)
                                List {
                                    ForEach(group.contactArray.filter({searchText.isEmpty ? true : $0.name!.contains(searchText) })) { item in
                                        
                                        NavigationLink(destination: ContactInfoView(contact: item, contactViewModel: contactViewModel)) {
                                            HStack {
                                                Text(item.name ?? "no name")
                                            }
                                        }
                                        
                                    }.onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let contact = group.contactArray[index]
                                            GroupViewModel().deleteContactInGroup(contact: contact, group: group)
                                               
                                        }
                                    })
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
                    }
                }.navigationTitle(group.name!)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditGroupView(group: group,
                                                              name: group.name ?? "",
                                                              contactViewModel: contactViewModel)
                        .onDisappear{groupViewModel.fetch()}
                    ) {
                        Text("Editar")
                    }
                }
            }
    }
}
