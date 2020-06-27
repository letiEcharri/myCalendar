//
//  BaseDataSource.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(ErrorModel)
}

typealias CompletionBlock = (Response<Data?>) -> Void

protocol DataSource {
    func executeDemoRequest(url: String, completion: @escaping CompletionBlock)
    func executeRequest(url: String, completion: @escaping CompletionBlock)
}

class BaseDataSource {
        
    struct URLBase {
        static let holidays = "https://holidayapi.com/v1/holidays?pretty&key=1fd4fe24-b5b4-4b73-bd1f-ee540cc9ae8e"
    }
    
    func readFile(fileName: String) -> Data? {
        var data: Data? = Data()

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                data = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as Data
            } catch {
                print("Error! Unable to load  \(fileName).json")
            }
        }
        return data
    }
}

extension BaseDataSource: DataSource {
    func executeDemoRequest(url: String, completion: @escaping CompletionBlock) {
        if let file = readFile(fileName: url) {
            completion(Response.success(file))
        } else {
            completion(Response.failure(ErrorModel(error: ErrorContentModel(code: 0, description: "Error with json file"))))
        }
    }
    
    func executeRequest(url: String, completion: @escaping CompletionBlock) {
        executeDemoRequest(url: "holidays", completion: completion)
//        DispatchQueue.main.async {
//            if let url = URL(string: url) {
//                URLSession.shared.dataTask(with: url) { data, response, error in
//                    if let data = data {
//                        completion(Response.success(data))
//                    } else {
//                        if let response = response as? HTTPURLResponse {
//                            completion(Response.failure(ErrorModel(error: ErrorContentModel(code: response.statusCode, description: error?.localizedDescription))))
//                        } else {
//                            completion(Response.failure(ErrorModel(error: ErrorContentModel(code: nil, description: error?.localizedDescription))))
//                        }
//                    }
//                }.resume()
//            }
//        }
    }
}
