import UIKit

protocol HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

protocol HomeResponseProtocol {
    func onContactList(contacts: [Contact])
    func onContactDelete(isDeleted: Bool)
}

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {
    
    var presenter: HomeRequestProtocol!
    @IBOutlet weak var tableView: UITableView!
    var items: Array<Contact> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            presenter.apiContactList()
    }

    func refreshTableview(contacts: [Contact]){
        self.items = contacts
        self.tableView.reloadData()
        
    }
    
    func onContactList(contacts: [Contact]) {
        self.refreshTableview(contacts: contacts)
        self.hireProgress()
    }
    
    func onContactDelete(isDeleted: Bool) {
        self.hireProgress()
        presenter.apiContactList()
    }
    
    
    // MARK: - Navigation
    
    func initViews(){
        tableView.dataSource = self
        tableView.delegate = self
        initNavigation()
        configureVIPER()
        presenter.apiContactList()
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        
        title = "Storyboard Contacts"
    }
    
    func configureVIPER(){
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func callEditViewController(contact: Contact){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        vc.contact = contact
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped(){
        presenter.apiContactList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = Bundle.main.loadNibNamed("ContactsTableViewCell", owner: self, options: nil)?.first as! ContactsTableViewCell
        
        
        cell.nameLabel.text = item.name
        cell.numberLabel.text = item.number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompleteContextulaAction(forRowAt: indexPath, contacts: items[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextulaAction(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    // MARK: - Contextual Action
    
    private func makeDeleteContextulaAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE HERE")
            completion(true)
            self.presenter.apiContactDelete(contact: contact)
        }
    }
    
    private func makeCompleteContextulaAction(forRowAt indexPath: IndexPath, contacts: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            completion(true)
            self.callEditViewController(contact: contacts)
        }
    }
}
