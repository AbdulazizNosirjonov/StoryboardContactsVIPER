//
//  EditIntractor.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol EditInteractorProtocol {
    func apiContactEdit(contact: Contact)
}

class EditInteractor: EditInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiContactEdit(contact: Contact) {
        manager.apiContactEdit(contact: contact, complation: {(result) in
            self.response.onContactEdit(isEdited: result)
        })
    }
    
    
}
