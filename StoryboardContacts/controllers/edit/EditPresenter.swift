//
//  EditPresenter.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiContactEdit(contact: Contact)
}

class EditPresenter: EditPresenterProtocol {
    
    var interactor: EditInteractorProtocol!
    var controller: BaseViewController!
    
    func apiContactEdit(contact: Contact) {
        interactor.apiContactEdit(contact: contact)
    }
}
