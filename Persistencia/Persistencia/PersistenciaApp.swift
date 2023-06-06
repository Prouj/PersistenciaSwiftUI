//
//  PersistenciaApp.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 10/05/23.
//

import SwiftUI

@main
struct PersistenciaApp: App {
    
    var body: some Scene {
        let persistenceContainer = PersistenceController.shared
        WindowGroup {
            ListView(contactViewModel: ContactViewModel(), groupViewModel: GroupViewModel())
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}

