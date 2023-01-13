//
//  HomeRouter.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 22/11/22.
//

import Foundation

protocol HomeRoutingProtocol {
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

class HomeRouting: HomeRoutingProtocol {
    
    weak var viewController: HomeViewController!
    
    func navigateCreateScreen() {
        viewController.callCreateViewController()
    }
    
    func navigateEditScreen(contact: Contact) {
        viewController.callEditViewController(contact: contact)
    }
}
