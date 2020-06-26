//
//  BaseDataSource.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

typealias CompletionBlock = (Response<Data?>) -> Void

protocol DataSource {
    func executeRequest(url: String, completion: @escaping CompletionBlock)
}

class BaseDataSource {
    
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
    func executeRequest(url: String, completion: @escaping CompletionBlock) {
        if let file = readFile(fileName: url) {
            completion(Response.success(file))
        } else {
            completion(Response.failure(ErrorModel(error: ErrorContentModel(code: 0, description: "Error with json file"))))
        }
    }
}

enum Response<T> {
    case success(T)
    case failure(ErrorModel)
}
