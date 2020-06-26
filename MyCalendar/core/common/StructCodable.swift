//
//  StructCodable.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

public protocol StructCodable: Codable {
    static func getModelFrom(_ data: Data) -> Self?
}

extension StructCodable {

    public static func getModelFrom(_ data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            return nil
        }
    }
}
