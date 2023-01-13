//
//  HomeInteractor.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol HomeInteractorProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
}

class HomeInteractor: HomeInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: HomeResponseProtocol!
    
    func apiContactList() {
        manager.apiContactList(compaltion: {(result) in
            self.response.onContactList(contacts: result)
        })
    }
    
    func apiContactDelete(contact: Contact) {
        manager.apiContactDelete(contact: contact, complation: {(result) in
            self.response.onContactDelete(isDeleted: result)
        })
    }
}
