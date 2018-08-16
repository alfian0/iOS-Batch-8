////
////  ViewController.swift
////  PackageManager
////
////  Created by alfian0 on 13/08/18.
////  Copyright © 2018 alfian0. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//import ObjectMapper
//import Alamofire
//
//class ViewController: UIViewController {
//
////    @IBOutlet weak var body: UILabel!
////    @IBOutlet weak var fetch: UIButton!
////
////    @IBAction func fetchTapped(_ sender: UIButton) {
////        fetchPostWithURLSession()
//////        fetchPostAlamofire()
////    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    func fetchPostWithURLSession() {
//        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
//            let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
//
//                        let b = json?.first?["body"] as? String
//                        DispatchQueue.main.async {
//                            self.body.text = b
//                        }
//                    } catch let error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            session.resume()
//        }
//    }
//
//    func createPost() {
//
//        // comments?postId=1
//        // URLComponents
//        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "GET"
//
//        }
//    }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////    func fetchPostAlamofire() {
////        Alamofire.request("https://jsonplaceholder.typicode.com/posts").responseJSON { (response) in
////            print("Request: \(String(describing: response.request))")   // original url request
////            print("Response: \(String(describing: response.response))") // http url response
////            print("Result: \(response.result)")                         // response serialization result
////
////            switch response.result {
////            case .success(let value):
////                let json = JSON(value)
////                print("JSON: \(json)")
////            case .failure(let error):
////                print(error)
////            }
////
////            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
////                print("Data: \(utf8Text)") // original server data as UTF8 string
////            }
////        }
////    }
//}
//
