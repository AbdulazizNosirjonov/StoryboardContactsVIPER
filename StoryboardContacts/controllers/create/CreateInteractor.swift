//
//  CreateInteractor.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol CreateInteractorProtocol {
    func apiContactCreate(contact: Contact)
}

class CreateInteractor: CreateInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: CreateResponseProtocol!
    
    func apiContactCreate(contact: Contact) {
        manager.apiContactCreate(contact: contact, complation: {(result) in
            self.response.onContactCreate(isCreated: result)
            
        })
    }
}
