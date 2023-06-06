//
//  GroupViewModel.swift
//  Agenda
//
//  Created by Paulo Uchôa on 28/06/21.
//

import Foundation
import CoreData

class GroupViewModel: ObservableObject {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var groups: [Group] = []

    func fetch() {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return
        }
        groups = fetchedContacts
    }

    func createGroup(name: String, contacts: [Contact]) {
        
        let newGroup = Group(context: viewContext)
        newGroup.iD = UUID()
        newGroup.name = name
        newGroup.addToGroupToContact(NSSet(array: contacts))
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
    }
    
    func deleteGroup(group: Group) {
        viewContext.delete(group)
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func deleteContactInGroup(contact: Contact, group: Group) {
        
        group.removeFromGroupToContact(contact)
        
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func updateGroup(group: Group, name: String, contacts: [Contact]) {
        group.iD = group.iD
        group.name = name
        group.addToGroupToContact(NSSet(array: contacts))
        
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
}
