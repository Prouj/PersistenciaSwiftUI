//
//  ListView.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 31/05/23.
//

import SwiftUI

struct ListView: View {
//        @FetchRequest(entity: Contact.entity(), sortDescriptors: []) var contact: FetchedResults<Contact>
    @State private var selectedIndex = 0

    @ObservedObject var contactViewModel: ContactViewModel
    @ObservedObject var groupViewModel: GroupViewModel
    
    init(contactViewModel: ContactViewModel, groupViewModel: GroupViewModel) {
        self.contactViewModel = contactViewModel
        self.groupViewModel = groupViewModel
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    let tabBarImage = ["person.fill", "person.2.fill"]
    
    var body: some View {
        VStack {
                switch selectedIndex {
                case 0:
                    ContactListView(contactViewModel: contactViewModel)
                case 1:
                    GroupListView(groupViewModel: groupViewModel, contactViewModel: contactViewModel)
                default:
                    Text("Oh NO")
                }
            
            Spacer()
            HStack {
                ForEach(0..<2) { num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                            Image(systemName: tabBarImage[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        Spacer()
                    })
                }
            }
        }
        .onAppear {
            contactViewModel.fetch()
            groupViewModel.fetch()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
