//
//  StringExtension.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 13/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//
// URL: https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
