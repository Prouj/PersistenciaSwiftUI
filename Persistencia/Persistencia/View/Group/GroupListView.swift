//
//  GroupListView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import SwiftUI

struct GroupListView: View {
    @State var searchText: String = ""

    @ObservedObject var groupViewModel: GroupViewModel
    @ObservedObject var contactViewModel: ContactViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    VStack {
                        if !groupViewModel.groups.isEmpty {
                                SearchBar(text: $searchText)
                                    .padding(.bottom, 10)
                                List {
                                    ForEach(groupViewModel.groups.filter({searchText.isEmpty ? true : $0.name!.contains(searchText) })) { item in
                                        NavigationLink(destination: ContactsInGroupView(group: item, groupViewModel: groupViewModel, contactViewModel: contactViewModel)) {
                                            HStack {
                                                Text(item.name ?? "no name")
                                            }
                                        }
                                        
                                    }.onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let group = groupViewModel.groups[index]
                                            GroupViewModel().deleteGroup(group: group)
                                        }
                                    })
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .center) {
                                        Spacer()
                                        Text("Adicione um novo Grupo clicando em +")
                                        .fontWeight(.regular)
                                        .font(.system(size: 15))
                                        Spacer()
                                    }
                                }

                            }
                    }

                }
            }
            .navigationTitle("Grupos")
               
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewGroupView(contactViewModel: contactViewModel, groupViewModel: groupViewModel)
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
