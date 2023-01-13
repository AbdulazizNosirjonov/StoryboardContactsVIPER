//
//  CreatePresenter.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
}

class CreatePresenter: CreatePresenterProtocol {
    
    var interactor: CreateInteractorProtocol!
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        interactor.apiContactCreate(contact: contact)
    }
}
