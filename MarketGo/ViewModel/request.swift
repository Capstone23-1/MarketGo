//
//  request.swift
//  MarketGo
//
//  Created by ram on 2023/04/05.
//

import UIKit

struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}

func requestGet(url: String, completionHandler: @escaping (Bool, Any) -> Void) {
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }

        completionHandler(true, output.result)
    }.resume()
}

func requestPost(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Any) -> Void) {
    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])

    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = sendData

    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }

        completionHandler(true, output.result)
    }.resume()
}

func request(_ url: String, _ method: String, _ param: [String: Any]? = nil, completionHandler: @escaping (Bool, Any) -> Void) {
    if method == "GET" {
        requestGet(url: url) { (success, data) in
            completionHandler(success, data)
        }
    }
    else {
        requestPost(url: url, method: method, param: param!) { (success, data) in
            completionHandler(success, data)
        }
    }
}
