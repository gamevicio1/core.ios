//
//  Chainable.swift
//  Core
//
//  Created by Marcos Said on 03/03/19.
//  Copyright © 2019 GreenCode. All rights reserved.
//

import Foundation
/// Protocol to padronize methods that have return self but sometimes they don't need return nothing - generating a warning message. Demands a done method with Void return to silence this warning.
public protocol Chainable {
    /// Just finish the call chain to avoid warnings
    func done() -> Void
}
