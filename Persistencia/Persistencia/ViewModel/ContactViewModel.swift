//
//  ContactViewModel.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class ContactViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var contact: [Contact] = []
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        guard let fetchedContacts = try? viewContext.fetch(fetchRequest) else {
            return
        }
        contact = fetchedContacts
    }
    
    func createContact(name: String, email: String, cep: String, numberOne: String, numberTwo: String) {
        
        let newContact = Contact(context: viewContext)
        newContact.iD = UUID()
        newContact.name = name
        newContact.email = email
        newContact.cep = cep
        newContact.numberOne = numberOne
        newContact.numberTwo = numberTwo
        
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("could not save \(error) \(error.userInfo)")
        }
        

    }
    
    func deleteContact(contact: Contact) {
        viewContext.delete(contact)
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    
    func updateContact(contact: Contact, name: String, email: String, cep: String, numberOne: String, numberTwo: String ) {

        contact.iD = contact.iD
        contact.name = name
        contact.email = email
        contact.cep = cep
        contact.numberOne = numberOne
        contact.numberTwo = numberTwo
        do {
            try viewContext.save()
            fetch()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}

