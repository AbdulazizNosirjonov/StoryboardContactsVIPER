//
//  HttpManager.swift
//  StoryboardContacts
//
//  Created by Abdulaziz Nosirjonov on 24/11/22.
//

import Foundation

protocol HttpManagerProtocol {
    func apiContactList(compaltion: @escaping ([Contact]) -> Void)
    func apiContactDelete(contact: Contact, complation: @escaping (Bool) -> Void)
    func apiContactCreate(contact: Contact, complation: @escaping (Bool) -> Void)
    func apiContactEdit(contact: Contact, complation: @escaping (Bool) -> Void)
}

class HttpManager: HttpManagerProtocol {
    
    func apiContactList(compaltion: @escaping ([Contact]) -> Void) {
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                compaltion(contacts)
            case let .failure(error):
                print(error)
                compaltion([Contact]())
            }
        })
    }
    
    func apiContactDelete(contact: Contact, complation: @escaping (Bool) -> Void) {
        AFHttp.del(url: AFHttp.API_POST_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                print(response.result)
                complation(true)
            case let .failure(error):
                print(error)
                complation(false)
            }
        })
    }
    
    func apiContactCreate(contact: Contact, complation: @escaping (Bool) -> Void) {
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            switch response.result {
            case.success:
                print(response.result)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func apiContactEdit(contact: Contact, complation: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_POST_UPDATE + contact.id!, params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            switch response.result {
            case.success:
                print(response.result)
            case let .failure(error):
                print(error)
            }
        }
    }
}
