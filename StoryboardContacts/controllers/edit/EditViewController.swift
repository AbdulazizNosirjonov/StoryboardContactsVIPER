//
//  EditViewController.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 16/02/22.
//

import UIKit

protocol EditRequestProtocol {
    func apiContactEdit(contact: Contact)
}

protocol EditResponseProtocol {
    func onContactEdit(isEdited: Bool)
}

class EditViewController: BaseViewController, EditResponseProtocol {
    
    var presenter: EditPresenterProtocol!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var redLbl: UILabel!
    
    var contact: Contact = Contact(name: "", number: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.text = contact.name
        numberTF.text = contact.number
        configureVIPER()
    }
    
    func configureVIPER() {
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        interactor.manager = manager
        interactor.response = self
    }
    
    func onContactEdit(isEdited: Bool) {
        print("Edited")
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if nameTF.text!.isEmpty || numberTF.text!.isEmpty {
            redLbl.isHidden = false
        }else{
            contact.name = nameTF.text
            contact.number = numberTF.text
            print(contact)
            presenter.apiContactEdit(contact: contact)
            dismiss(animated: true)
        }
    }
}
