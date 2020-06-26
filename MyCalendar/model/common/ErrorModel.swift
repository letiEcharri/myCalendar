//
//  ErrorModel.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

struct ErrorModel: StructCodable {
    var error: ErrorContentModel?
}

struct ErrorContentModel: StructCodable {
    var code: Int?
    var description: String?
}
