//
//  CreateViewController.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 16/02/22.
//

import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    var presenter: CreatePresenterProtocol!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var redLbl: UILabel!
    
    var contact: Contact = Contact(name: "", number: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVIPER()
    }
    
    func configureVIPER(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        interactor.manager = manager
        interactor.response = self
    }
    
    func onContactCreate(isCreated: Bool) {
        print("Tugadi")
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if nameTF.text!.isEmpty || numberTF.text!.isEmpty {
            redLbl.isHidden = false
        } else {
            contact.name = nameTF.text
            contact.number = numberTF.text
            presenter.apiContactCreate(contact: contact)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
