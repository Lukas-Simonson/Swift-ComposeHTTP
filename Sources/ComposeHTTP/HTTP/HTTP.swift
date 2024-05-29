//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    enum HTTP {
        /// Represents the scheme of a network URL.
        ///
        /// This enumeration defines the possible schemes for a network URL, such as "http" or "https".
        enum Scheme: String {
            /// The HTTP scheme.
            case http
            
            /// The HTTPS scheme.
            case https
        }
    }
}
