//
//  CreateToDoController.swift
//  PackageManager
//
//  Created by alfian0 on 16/08/18.
//  Copyright © 2018 alfian0. All rights reserved.
//

import UIKit
import Alamofire

class CreateToDoController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    // MARK: Loading indicator
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create New To Do List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction(sender:)))
    }

    @objc private func cancelAction(sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveAction(sender: UIBarButtonItem) {
        guard let title = titleText.text, let body = bodyText.text else { return }
        createPost(title: title, body: body, userId: Int(arc4random_uniform(1000)))
        
        indicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
    }
    
    private func createPost(title: String, body: String, userId: Int) {
        let parameters: [String: Any] = [
            "title": title,
            "body": body,
            "userId": userId
        ]
        
        Alamofire.request("https://jsonplaceholder.typicode.com/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-type":"application/json; charset=UTF-8"])
            .responseJSON { response in
                // MARK: Stop loading indicator
                self.indicator.stopAnimating()
                switch response.result {
                case .success:
                    self.navigationController?.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    let alert = UIAlertController(title: "Gagal membuat ToDo", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.navigationController?.present(alert, animated: true, completion: {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveAction(sender:)))
                    })
                }
            }
    }
    
}
