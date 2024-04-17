//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    class URL {
        internal private(set) var components: URLComponents
        
        internal required init(comp: URLComponents) {
            self.components = comp
            components.scheme = Network.HTTP.Scheme.https.rawValue
        }
    }
}

// MARK: - Creator Functions
public extension Network.URL {
    
    static func scheme(_ scheme: Network.HTTP.Scheme) -> Self {
        return Self.scheme(scheme.rawValue)
    }
    
    static func scheme(_ string: String) -> Self {
        let url = Self(comp: URLComponents())
        url.components.scheme = string
        return url
    }
    
    static func host(_ string: String) -> Self {
        let url = Self(comp: URLComponents())
        url.components.host = string
        return url
    }
}

// MARK: - Builder Functions
public extension Network.URL {
    func scheme(_ scheme: Network.HTTP.Scheme) -> Self {
        self.components.scheme = scheme.rawValue
        return self
    }
    
    func scheme(_ string: String) -> Self {
        self.components.scheme = string
        return self
    }
    
    func host(_ string: String) -> Self {
        self.components.host = string
        return self
    }
    
    func path(_ string: String) -> Self {
        self.components.path = string
        return self
    }
    
    func query(_ string: String) -> Self {
        self.components.query = string
        return self
    }
    
    func port(_ number: Int) -> Self {
        self.components.port = number
        return self
    }
    
    func fragment(_ string: String) -> Self {
        self.components.fragment = string
        return self
    }
}

// MARK: - Request
public extension Network.URL {
    func request(method: Network.HTTP.Method) throws -> Network.Request {
        guard let url = self.components.url
        else { throw Network.URLError.couldntCreateURL }
        
        return Network.Request.method(method, url: url)
    }
    
    func get() throws -> Network.Request {
        try self.request(method: .get)
    }
    
    func post() throws -> Network.Request {
        try self.request(method: .post)
    }
    
    func put() throws -> Network.Request {
        try self.request(method: .put)
    }
    
    func delete() throws -> Network.Request {
        try self.request(method: .delete)
    }
}
