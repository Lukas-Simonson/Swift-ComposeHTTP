//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    
    /// Represents a network response.
    ///
    /// This class encapsulates the response data and the URL response received from a network request.
    class Response {
        /// The data returned by the network request.
        private var data: Data?
        
        /// The URL response returned by the network request.
        private var response: URLResponse
        
        /// Initializes a new `Response` instance with the specified data and URL response.
        ///
        /// - Parameters:
        ///   - data: The data returned by the network request, if any.
        ///   - response: The URL response returned by the network request.
        internal init(data: Data?, response: URLResponse) {
            self.data = data
            self.response = response
        }
    }
    
    /// Represents a stream of bytes from a network response.
    ///
    /// This class encapsulates an asynchronous sequence of bytes and the associated network response.
    @available(iOS 15.0, macOS 12.0, *)
    class ByteStream: AsyncSequence {
        public typealias AsyncIterator = URLSession.AsyncBytes.AsyncIterator
        public typealias Element = UInt8
        
        /// The asynchronous byte stream returned by the network request.
        private var bytes: URLSession.AsyncBytes
        
        /// The network response associated with the byte stream.
        private var response: Network.Response
        
        /// Initializes a new `ByteStream` instance with the specified byte stream and network response.
        ///
        /// - Parameters:
        ///   - bytes: The asynchronous byte stream returned by the network request.
        ///   - response: The network response associated with the byte stream.
        internal init(bytes: URLSession.AsyncBytes, response: Network.Response) {
            self.bytes = bytes
            self.response = response
        }
        
        /// Creates an asynchronous iterator over the byte stream.
        ///
        /// - Returns: An asynchronous iterator over the byte stream.
        public func makeAsyncIterator() -> URLSession.AsyncBytes.AsyncIterator {
            bytes.makeAsyncIterator()
        }
    }
}

public extension Network.Response {
    
    /// Retrieves the raw data from the response body.
    ///
    /// This method returns the raw data from the response body, if available.
    ///
    /// - Returns: The raw data from the response body.
    /// - Throws: `Network.ResponseError.dataNotFound` if the response body data is not available
    func bodyData() throws -> Data {
        guard let data else { throw Network.ResponseError.dataNotFound }
        return data
    }
    
    /// Decodes the response body into a specified type.
    ///
    /// This method decodes the response body into the specified type using the provided JSON decoder.
    ///
    /// - Parameters:
    ///   - decoder: The JSON decoder to use for decoding the response body. Defaults to `JSONDecoder()`.
    /// - Returns: The decoded response body of the specified type.
    /// - Throws: `Network.ResponseError.dataNotFound` if the response body data is not available, or an error if the data cannot be decoded into the specified type.
    func body<Body: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> Body {
        guard let data else { throw Network.ResponseError.dataNotFound }
        return try decoder.decode(Body.self, from: data)
    }
    
    /// Decodes the response body into a specified type.
    ///
    /// This method decodes the response body into the specified type using the provided JSON decoder.
    ///
    /// - Parameters:
    ///   - type: The `Decodable` type to decode the response body as.
    ///   - decoder: The JSON decoder to use for decoding the response body. Defaults to `JSONDecoder()`.
    /// - Returns: The decoded response body of the specified type.
    /// - Throws: `Network.ResponseError.dataNotFound` if the response body data is not available, or an error if the data cannot be decoded into the specified type.
    func body<Body: Decodable>(as type: Body.Type, _ decoder: JSONDecoder = JSONDecoder()) throws -> Body {
        guard let data else { throw Network.ResponseError.dataNotFound }
        return try decoder.decode(Body.self, from: data)
    }
    
    /// Converts the response body data into a string using the specified encoding.
    ///
    /// This method converts the response body data into a string using the specified encoding.
    ///
    /// - Parameters:
    ///   - encoding: The string encoding to use. Defaults to `.utf8`.
    /// - Returns: The response body data as a string.
    /// - Throws: `Network.ResponseError.dataNotFound` if the response body data is not available, or `Network.ResponseError.couldntConvertDataToString` if the data cannot be converted into a string using the specified encoding.
    func body(_ encoding: String.Encoding = .utf8) throws -> String {
        guard let data else { throw Network.ResponseError.dataNotFound }
        guard let string = String(data: data, encoding: encoding)
        else { throw Network.ResponseError.couldntConvertDataToString }
        return string
    }
    
    /// Prints the JSON representation of the response body.
    ///
    /// This method prints the JSON representation of the response body, if available.
    ///
    /// - Parameter defaultString: The default string to print if the response body data is not available. Defaults to "Failed To Print JSON".
    /// - Returns: The current response instance.
    @discardableResult
    func printJSON(or defaultString: String = "Failed To Print JSON") -> Self {
        guard let data else { print(defaultString); return self }
        print(String(data: data, encoding: .utf8) ?? defaultString)
        return self
    }
}
