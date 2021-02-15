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
        
    @IBOutlet weak var tableView: UITableView!
    
    let delegate = DelegateTableView(service: TaskArrayServiceImpl.getInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.tableView.reloadData()
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
    
    init(service: TaskService) {
        self.service = service
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TaskTableViewCell.self)
        cell.topLabel.text = service.get(byIndex: indexPath.row).text
        addSwipeHandles(cell: cell)
        return cell
    }
    
    private func addSwipeHandles(cell: UITableViewCell) {
        cell.isUserInteractionEnabled = true
        addLeftSwipeHandle(cell: cell)
        addRightSwipeHandle(cell: cell)
    }
    
    private func addLeftSwipeHandle(cell: UITableViewCell) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleLeftSwipe(_:)))
        swipe.direction = .left
        cell.addGestureRecognizer(swipe)
    }
    
    private func addRightSwipeHandle(cell: UITableViewCell) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe(_:)))
        swipe.direction = .right
        cell.addGestureRecognizer(swipe)
    }
    
    @objc private func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        print("Left swipe!")
    }
    
    @objc private func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
        print("Right swipe!")
    }
    
    func getService() -> TaskService {
        return service
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
