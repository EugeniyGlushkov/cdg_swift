//
//  ViewController.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    let service: TaskService = TaskArrayServiceImpl.getInstance()
        
    override func viewDidLoad() {
        service.add(text: "first")
        service.add(text: "second")
        service.add(text: "third")
        service.add(text: "fourth")
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell
        cell?.topLabel.text = service.get(byIndex: indexPath.row).text
        return cell ?? UITableViewCell()
    }
}

