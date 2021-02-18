//
//  ViewController.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import UIKit

class ViewController: UIViewController {
    static let NEW_TASK_BUTTON_TITLE = "New task"
    static let ADD_BUTTON_TITLE = "ADD"
    static let UPDATE_TASK_TITLE = "Update task"
    static let UPDATE_BUTTON_TITLE = "UPDATE"
        
    @IBOutlet weak var tableView: UITableView!
    
    let delegate = DelegateTableView(service: TaskServiceImpl(withRepository: ArrayTaskRepositoryImpl.getInstance()))
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = delegate.getService().getAll()
        delegate.viewController = self
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.registerNib(with: TaskTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addNewTaskButtonTouched(_ sender: Any) {
        let alertVC = UIAlertController(title: ViewController.NEW_TASK_BUTTON_TITLE, message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: ViewController.ADD_BUTTON_TITLE, style: .default, handler: { (_) in
            guard let text: String = alertVC.textFields?.first?.text else { return }
            self.delegate.getService().add(text: text)
            self.updateTasksAndReloadTable()
        })
        
        alertVC.addTextField(configurationHandler: {(textField: UITextField!) in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                                   object: textField,
                                                   queue: OperationQueue.main,
                                                   using: {_ in
                                                    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                                                    addAction.isEnabled = textCount > 3
                                                   })
        })
        
        addAction.isEnabled = false
        
        alertVC.addAction(addAction)
        present(alertVC, animated: true)
    }
    
    func updateTasksAndReloadTable(){
        tasks = delegate.getService().getAll()
        tableView.reloadData()
    }
}

protocol NameDiscribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDiscribable {
    var typeName: String {
        return String(describing: type(of: self))
    }
    
    static var typeName: String {
        return String(describing: self)
    }
}

extension NSObject: NameDiscribable {}

extension UITableView {
    func registerNib(with type: NameDiscribable.Type) {
        self.register(UINib(nibName: type.typeName, bundle: nil), forCellReuseIdentifier: type.typeName)
    }
    
    func dequeueReusableCell<T: NameDiscribable> (with type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: type.typeName) as! T
    }
}

class DelegateTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private let service: TaskService
    var viewController: ViewController?
    
    init(service: TaskService) {
        self.service = service
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TaskTableViewCell.self)
        
        if indexPath.row.isOdd {
            cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        }
        
        let currentTask = viewController!.tasks[indexPath.row]
        cell.topLabel.text = currentTask.text
        cell.deleteTaskButton.isHidden = true
        cell.deleteTaskButtonTouchedHandler = {
            self.service.remove(byId: Int(currentTask.id))
            
            guard let vc = self.viewController else {
                return
            }
            
            vc.updateTasksAndReloadTable()
        }
        
        cell.cellTappedHandler = {
            let alertVC = UIAlertController(title: ViewController.UPDATE_TASK_TITLE, message: nil, preferredStyle: .alert)
            
            let updateAction = UIAlertAction(title: ViewController.UPDATE_BUTTON_TITLE, style: .default, handler: { (_) in
                guard let text: String = alertVC.textFields?.first?.text else { return }
                self.service.update(byId: Int(currentTask.id), newText: text)
                
                guard let vc = self.viewController else {
                    return
                }
                
                vc.updateTasksAndReloadTable()
            })
            
            alertVC.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = cell.topLabel.text
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                                       object: textField,
                                                       queue: OperationQueue.main,
                                                       using: {_ in
                                                        let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                                                        updateAction.isEnabled = textCount > 3
                                                       })
            })
            
            alertVC.addAction(updateAction)
            self.viewController!.present(alertVC, animated: true)
        }
        
        cell.addSwipeHandles()
        cell.addTapHandle()
        return cell
    }
    
    func getService() -> TaskService {
        return service
    }
}

extension Int {
    var isOdd: Bool {
        return self.isMultiple(of: 2)
    }
}
