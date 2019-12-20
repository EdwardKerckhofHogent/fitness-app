//
//  Validator.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

// URL: https://dev.to/onmyway133/how-to-make-simple-form-validator-in-swift-1hlg met eigen aanpassingen

import Foundation
import UIKit

class Validator {
    func validate(text: String, with rules: [Rule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }

    func validate(input: UITextField, with rules: [Rule]) -> Bool {
        guard let message = validate(text: input.text ?? "", with: rules) else { return true }
        if !input.isSecureTextEntry {
            input.placeholder = message
        }
        return false
    }
}

struct Rule {
    // Return nil if matches, error message otherwise
    let check: (String) -> String?

    static let notEmpty = Rule(check: {
        return $0.isEmpty ? "Verplicht" : nil
    })
    
    static func minLength(length: Int) -> Rule {
        Rule(check: {
            return $0.count < length ? "Min. lengte van: \(length)" : nil
        })
    }

    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Geen geldig email"
    })
}
