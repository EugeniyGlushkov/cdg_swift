//
//  ViewController.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let service: TaskService = TaskArrayServiceImpl.getInstance()
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        service.add(text: "first")
//        service.add(text: "second")
//        service.add(text: "third")
//        service.add(text: "fourth")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(with: TaskTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TaskTableViewCell.self)
        cell.topLabel.text = service.get(byIndex: indexPath.row).text
        return cell
    }
    
    @IBAction func addNewTaskButtonTouched(_ sender: Any) {
        let alertVC = UIAlertController(title: "New task", message: nil, preferredStyle: .alert)
        alertVC.addTextField{ (textField) in
        }
        alertVC.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text: String = alertVC.textFields?.first?.text else { return }
            self.service.add(text: text)
            self.tableView.reloadData()
        }))
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
