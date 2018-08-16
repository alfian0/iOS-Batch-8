//
//  ToDoListController.swift
//  PackageManager
//
//  Created by alfian0 on 15/08/18.
//  Copyright © 2018 alfian0. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ToDoListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshed(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    var listToDo: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        navigationItem.title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchToDoList()
    }
    
    @objc private func refreshed(sender: UIRefreshControl) {
        fetchToDoList()
    }
    
    @objc private func addAction(sender: UIBarButtonItem) {
        let vc = CreateToDoController()
        let nv = UINavigationController(rootViewController: vc)
        navigationController?.present(nv, animated: true, completion: nil)
    }
    
    func fetchToDoList() {
        indicator.startAnimating()
        Alamofire.request("https://jsonplaceholder.typicode.com/posts")
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                self.indicator.stopAnimating()
                self.refreshControl.endRefreshing()
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addAction(sender:)))
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
//                    json.arrayValue[0]["title"].stringValue
                    let toDoArray = json.arrayValue
                    for toDo in toDoArray {
//                        toDo["title"].stringValue
                        let object = toDo.dictionaryValue
                        if let title = object["title"]?.stringValue {
                            self.listToDo.append(title)
                        }
//                        let title = object["title"]?.stringValue ?? ""
//                        self.listToDo.append(title)
                    }
                    self.tableView.reloadData()
//                    print(self.listToDo)
//                    listToDo = json.dictionaryValue
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension ToDoListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listToDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listToDo[indexPath.row]
    
        return cell
    }
}
