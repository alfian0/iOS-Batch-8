//
//  ViewController.swift
//  PackageManager
//
//  Created by alfian0 on 13/08/18.
//  Copyright © 2018 alfian0. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var fetch: UIButton!
    
    @IBAction func fetchTapped(_ sender: UIButton) {
        getPost()?.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getPost() -> URLSessionDataTask? {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                        
                        let b = json?.first?["body"] as? String
                        DispatchQueue.main.async {
                            self.body.text = b
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            return session
        } else {
            return nil
        }
    }
    
    func createPost() {
        
        // comments?postId=1
        // URLComponents
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
        }
    }
}

