//
//  CustomError.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 10/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import Foundation

protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
}

struct CustomError: ErrorProtocol {
    var title: String?
    var errorDescription: String? { return description }
    var failureReason: String? { return description }
    
    var description: String
    
    init(title: String?, descr: String) {
        self.title = title
        self.description = descr
    }
}
