//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*
 Package Manager
 - Ruby gems
 - Composer
 - NPM
 - Gradle
 
 iOS
 - Carthage
 - Cocoapods
 - Swift Package Manager
 
 Cocoapods
 - sudo gem install cocoapods
 Carthage
 - brew install carthage
 */
















/*
 Why ?
 - Many API that use same function
 - Limit variation
 - Readable
 
 - URLComponents: query, scheme(http), host(github.com)
 - URL
 - URLRequest: headers, body, method
 */

enum GithubAPI {
    case user(username: String)
    case repo
    
    var header: [String: String]? {
        switch self {
        case .user, .repo:
            return [
                "Content-Type"  : "multipart/form-data",
                "Accept"        : "application/json",
                "Authorization" : ""
            ]
        }
    }
    
    var base: URL? {
        return URL(string: "https://api.github.com")
    }
    
    var path: String {
        switch self {
        case .user(let username):
            return "/users/\(username)"
        case .repo:
            return "/repo"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    enum HTTPMethod: String {
        case get
        case post
        case put
        case delete
    }
    
    var method: HTTPMethod {
        switch self {
        case .user, .repo:
            return .get
        }
    }
}

struct GitHubUser: Codable {
    let name: String?
    let location: String?
    let followers: Int?
    let avatarUrl: URL?
    let repos: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case followers
        case repos = "public_repos"
        case avatarUrl = "avatar_url"
        
    }
}

extension GithubAPI {
    enum Result<T: Decodable> {
        case success(data: T)
        case error(data: Error)
    }
    
    enum GithubAPIError: Error {
        case notValidURL
    }
    
    func httpTask<T>(codable: T.Type, callback: @escaping ((Result<T>) -> Void)) {
        guard let url = base, let new = URL(string: path, relativeTo: url) else {
            callback(Result.error(data: GithubAPIError.notValidURL))
            return
        }
        var urlRequest = URLRequest(url: new)
        // MARK:
        // Add method type
        urlRequest.httpMethod = method.rawValue
        
        // MARK:
        // Add body for post
        // http://github.com/user?page=1
        switch  method {
        case .post:
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: .prettyPrinted)
        default:
            urlRequest
        }
        
        // MARK:
        // Add header
//        if let header = header {
//            for h in header {
//                urlRequest.setValue(h.value, forHTTPHeaderField: h.key)
//            }
//        }
        urlRequest.allHTTPHeaderFields = header
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    callback(Result.error(data: error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(codable, from: data)
                callback(Result.success(data: data))
            } catch let error {
                callback(Result.error(data: error))
            }
        }
        .resume()
    }
}

GithubAPI.user(username: "alfian0")
    .httpTask(codable: GitHubUser.self, callback: { result in
        switch result {
        case .success(let data):
            print(data.name ?? "void")
        case .error(let data):
            print(data.localizedDescription)
        }
    })

GithubAPI.repo
    .httpTask(codable: GitHubUser.self) { (result) in
        
    }

var u = URL(string: "http://github.com")
print(u?.absoluteString)
u?.appendPathComponent("alfian")
print(u?.absoluteString)
u?.appendingPathComponent("alfian")
print(u?.absoluteString)


var urlComponents = URLComponents()
urlComponents.scheme = "http"
urlComponents.host = "github.com"

print(urlComponents)



var url = URLComponents(string: "http://github.com")
url?.query = "s=0"
url?.queryItems = [URLQueryItem(name: "a", value: "b"), URLQueryItem(name: "c", value: "d")]
print(url?.url?.absoluteString)
url?.scheme = "d"
print(url?.url?.absoluteString)

let x = "a"
let b = "\(x) gghfhdfhdf"
print(b)


let ur = URL(string: "https://api.github.com/user/alfian0")
let req = URLRequest(url: ur!)
URLSession.shared.dataTask(with: req) { (data, response, error) in
    do {
        let decoder = JSONDecoder()
        let data = try decoder.decode(GitHubUser.self, from: data!)
//        callback(Result.success(data: data))
    } catch let error {
//        callback(Result.error(data: error))
    }
}
.resume()
