//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network.HTTP {
    enum Method: String {
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case connect = "CONNECT"
        case options = "OPTIONS"
        case trace = "TRACE"
        case patch = "PATCH"
        
        public var name: String { self.rawValue }
    }
}
