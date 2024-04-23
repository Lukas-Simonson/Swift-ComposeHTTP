//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    class Request {
        internal private(set) var request: URLRequest
        internal private(set) var session: URLSession = .shared
        
        internal required init(_ request: URLRequest) {
            self.request = request
        }
    }
}

// MARK: - Creation Functions
public extension Network.Request {
    
    private static func validateURLString(_ str: String) throws -> URL {
        guard let url = URL(string: str)
        else { throw Network.RequestError.invalidURLString }
        return url
    }
    
    static func method(_ method: Network.HTTP.Method, url: URL) -> Self {
        var request = URLRequest(url: url)
        request.httpMethod = method.name
        return Self(request)
    }
    
    static func get(_ urlString: String) throws -> Self {
        return try Self.get(validateURLString(urlString))
    }
    
    static func get(_ url: URL) -> Self {
        Self.method(.get, url: url)
    }
    
    static func post(_ urlString: String) throws -> Self {
        try Self.post(validateURLString(urlString))
    }
    
    static func post(_ url: URL) -> Self {
        Self.method(.post, url: url)
    }
    
    static func put(_ urlString: String) throws -> Self {
        try Self.post(validateURLString(urlString))
    }
    
    static func put(_ url: URL) -> Self {
        Self.method(.put, url: url)
    }
    
    static func delete(_ urlString: String) throws -> Self {
        try Self.post(validateURLString(urlString))
    }
    
    static func delete(_ url: URL) -> Self {
        Self.method(.delete, url: url)
    }
}

// MARK: - Header Functions
public extension Network.Request {
    func setHeader(_ header: Network.HTTP.Header) -> Self {
        self.request.setValue(header.value, forHTTPHeaderField: header.field)
        return self
    }
    
    func setHeaders(_ headers: Network.HTTP.Header...) -> Self {
        setHeaders(headers)
    }
    
    func setHeaders(_ headers: [Network.HTTP.Header]) -> Self {
        headers.forEach { header in
            self.request.setValue(header.value, forHTTPHeaderField: header.field)
        }
        
        return self
    }
}

// MARK: - Body Functions
public extension Network.Request {
    func setBody<Body: Encodable>(_ jsonEncodable: Body, encoder: JSONEncoder = JSONEncoder()) throws -> Self {
        let data = try encoder.encode(jsonEncodable)
        return try setBody(data)
    }
    
    func setBody(_ str: String) throws -> Self {
        return try setBody(Data(str.utf8))
    }
    
    func setBody(_ data: Data) throws -> Self {
        self.request.httpBody = data
        return self
    }
}

// MARK: - Response Functions
public extension Network.Request {
    @discardableResult
    func response() async throws -> Network.Response {
        let (data, urlResponse) = try await self.session.data(for: self.request)
        return Network.Response(data: data, response: urlResponse)
    }
    
    @available(iOS 15.0, macOS 12.0, *)
    func responseStream() async throws -> Network.ByteStream {
        let (bytes, urlResponse) = try await self.session.bytes(for: self.request)
        return Network.ByteStream(bytes: bytes, response: Network.Response(data: nil, response: urlResponse))
    }
    
    func responseBody<Body: Decodable>(using decoder: JSONDecoder = JSONDecoder()) async throws -> Body {
        let response = try await self.response()
        return try response.body(decoder)
    }
    
    func responseBody<Body: Decodable>(for type: Body.Type, using decoder: JSONDecoder = JSONDecoder()) async throws -> Body {
        let response = try await self.response()
        return try response.body(decoder)
    }
}

// MARK: - Misc Functions
public extension Network.Request {
    func setSession(_ urlSession: URLSession) -> Self {
        self.session = urlSession
        return self
    }
}
