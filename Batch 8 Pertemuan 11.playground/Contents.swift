//: Playground - noun: a place where people can play

import UIKit

// To support network request in Playground we need add this line

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*
 * Construct below URL with URL and URLComponents
 * [GET] https://jsonplaceholder.typicode.com/posts
 * [GET] https://jsonplaceholder.typicode.com/comments
 * [GET] https://jsonplaceholder.typicode.com/comments?postId=1
 * [GET] https://jsonplaceholder.typicode.com/posts?userId=1
 */

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")

var urlComponent = URLComponents()
urlComponent.scheme = "https"
urlComponent.host = "jsonplaceholder.typicode.com"
urlComponent.queryItems = [URLQueryItem(name: "userId", value: "1")]

/*
 * Create URLRequest from above URL
 */

let urlRequest = URLRequest(url: url!)

urlRequest.httpMethod
urlRequest.allHTTPHeaderFields
urlRequest.httpBody

/*
 * Make request with default URLSession
 */

URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
    do {
        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
        if let title = json[0]["title"] as? String {
            print(title)
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}
.resume()
