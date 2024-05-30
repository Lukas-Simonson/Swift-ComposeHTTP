//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    
    /// Represents a network URL.
    ///
    /// This class encapsulates the components of a URL and provides methods to manipulate the URL components.
    class URL {
        
        /// The URL components.
        internal private(set) var components: URLComponents
        
        /// Initializes a new `URL` instance with the specified URL components.
        ///
        /// - Parameter comp: The URL components.
        internal required init(comp: URLComponents) {
            self.components = comp
            if components.scheme == nil { components.scheme = Network.HTTP.Scheme.https.rawValue }
        }
    }
}

// MARK: - Creator Functions
public extension Network.URL {
    
    /// Creates a new `Network.URL` instance with the specified URL components.
    ///
    /// This method creates a new `Network.URL` instance with the provided URL components.
    ///
    /// - Parameter components: The URL components.
    /// - Returns: A new `Network.URL` instance with the specified URL components.
    static func using(components: URLComponents) -> Self {
        return Self(comp: components)
    }
    
    /// Creates a new `Network.URL` instance with the specified scheme.
    ///
    /// This method creates a new `Network.URL` instance with the provided scheme.
    ///
    /// - Parameter scheme: The scheme to set for the URL.
    /// - Returns: A new `Network.URL` instance with the specified scheme.
    static func scheme(_ scheme: Network.HTTP.Scheme) -> Self {
        return Self.scheme(scheme.rawValue)
    }
    
    /// Creates a new `Network.URL` instance with the specified scheme.
    ///
    /// This method creates a new `Network.URL` instance with the provided scheme.
    ///
    /// - Parameter string: The string representation of the scheme to set for the URL.
    /// - Returns: A new `Network.URL` instance with the specified scheme.
    static func scheme(_ string: String) -> Self {
        let url = Self(comp: URLComponents())
        url.components.scheme = string
        return url
    }
    
    /// Creates a new `Network.URL` instance with the specified host.
    ///
    /// This method creates a new `Network.URL` instance with the provided host.
    ///
    /// - Parameter string: The string representation of the host to set for the URL.
    /// - Returns: A new `Network.URL` instance with the specified host.
    static func host(_ string: String) -> Self {
        let url = Self(comp: URLComponents())
        url.components.host = string
        return url
    }
}

// MARK: - Builder Functions
public extension Network.URL {
    
    /// Sets the scheme of the URL.
    ///
    /// This method sets the scheme of the URL to the specified scheme.
    ///
    /// - Parameter scheme: The scheme to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified scheme.
    func scheme(_ scheme: Network.HTTP.Scheme) -> Self {
        self.components.scheme = scheme.rawValue
        return self
    }
    
    /// Sets the scheme of the URL.
    ///
    /// This method sets the scheme of the URL to the specified scheme.
    ///
    /// - Parameter string: The string representation of the scheme to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified scheme.
    func scheme(_ string: String) -> Self {
        self.components.scheme = string
        return self
    }
    
    /// Sets the host of the URL.
    ///
    /// This method sets the host of the URL to the specified host.
    ///
    /// - Parameter string: The string representation of the host to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified host.
    func host(_ string: String) -> Self {
        self.components.host = string
        return self
    }
    
    /// Sets the path of the URL.
    ///
    /// This method sets the path of the URL to the specified path.
    ///
    /// - Parameter string: The string representation of the path to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified path.
    func path(_ string: String) -> Self {
        self.components.path = string
        return self
    }
    
    /// Sets the query of the URL.
    ///
    /// This method sets the query of the URL to the specified query.
    ///
    /// - Parameter string: The string representation of the query to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified query.
    func query(_ string: String) -> Self {
        self.components.query = string
        return self
    }
    
    /// Sets the port of the URL.
    ///
    /// This method sets the port of the URL to the specified port number.
    ///
    /// - Parameter number: The port number to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified port.
    func port(_ number: Int) -> Self {
        self.components.port = number
        return self
    }
    
    /// Sets the fragment of the URL.
    ///
    /// This method sets the fragment of the URL to the specified fragment.
    ///
    /// - Parameter string: The string representation of the fragment to set for the URL.
    /// - Returns: The modified `Network.URL` instance with the specified fragment.
    func fragment(_ string: String) -> Self {
        self.components.fragment = string
        return self
    }
}

// MARK: - Request
public extension Network.URL {
    
    /// Creates a network request with the specified HTTP method.
    ///
    /// This method creates a network request with the specified HTTP method using the `Network.URL`. It throws an error if the URL cannot be created.
    ///
    /// - Parameter method: The HTTP method for the request.
    /// - Returns: A network request configured with the specified HTTP method and URL.
    /// - Throws: `Network.URLError.couldntCreateURL` if the URL cannot be created.
    func request(method: Network.HTTP.Method) throws -> Network.Request {
        guard let url = self.components.url
        else { throw Network.URLError.couldntCreateURL }
        
        return Network.Request.method(method, url: url)
    }
    
    /// Creates a GET request.
    ///
    /// This method creates a GET request using the `Network.URL`. It throws an error if the URL cannot be created.
    ///
    /// - Returns: A GET request configured with the URL.
    /// - Throws: `Network.URLError.couldntCreateURL` if the URL cannot be created.
    func get() throws -> Network.Request {
        try self.request(method: .get)
    }
    
    /// Creates a POST request.
    ///
    /// This method creates a POST request using the `Network.URL`. It throws an error if the URL cannot be created.
    ///
    /// - Returns: A POST request configured with the URL.
    /// - Throws: `Network.URLError.couldntCreateURL` if the URL cannot be created.
    func post() throws -> Network.Request {
        try self.request(method: .post)
    }
    
    /// Creates a PUT request.
    ///
    /// This method creates a PUT request using the `Network.URL`. It throws an error if the URL cannot be created.
    ///
    /// - Returns: A PUT request configured with the URL.
    /// - Throws: `Network.URLError.couldntCreateURL` if the URL cannot be created.
    func put() throws -> Network.Request {
        try self.request(method: .put)
    }
    
    /// Creates a DELETE request.
    ///
    /// This method creates a DELETE request using the `Network.URL`. It throws an error if the URL cannot be created.
    ///
    /// - Returns: A DELETE request configured with the URL.
    /// - Throws: `Network.URLError.couldntCreateURL` if the URL cannot be created.
    func delete() throws -> Network.Request {
        try self.request(method: .delete)
    }
}
