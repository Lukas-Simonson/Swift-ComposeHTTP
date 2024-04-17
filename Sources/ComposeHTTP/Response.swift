//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network {
    class Response {
        private var data: Data?
        private var response: URLResponse
        
        internal init(data: Data?, response: URLResponse) {
            self.data = data
            self.response = response
        }
    }
    
    @available(iOS 15.0, *)
    class ByteStream: AsyncSequence {
        public typealias AsyncIterator = URLSession.AsyncBytes.AsyncIterator
        public typealias Element = UInt8
        
        private var bytes: URLSession.AsyncBytes
        private var response: Network.Response
        
        internal init(bytes: URLSession.AsyncBytes, response: Network.Response) {
            self.bytes = bytes
            self.response = response
        }
        
        public func makeAsyncIterator() -> URLSession.AsyncBytes.AsyncIterator {
            bytes.makeAsyncIterator()
        }
    }
}

public extension Network.Response {
    func body<Body: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> Body {
        guard let data else { throw Network.ResponseError.dataNotFound }
        return try decoder.decode(Body.self, from: data)
    }
    
    func body(_ encoding: String.Encoding = .utf8) throws -> String {
        guard let data else { throw Network.ResponseError.dataNotFound }
        guard let string = String(data: data, encoding: encoding)
        else { throw Network.ResponseError.couldntConvertDataToString }
        return string
    }
    
    @discardableResult
    func printJSON(or defaultString: String = "Failed To Print JSON") -> Self {
        guard let data else { print(defaultString); return self }
        print(String(data: data, encoding: .utf8) ?? defaultString)
        return self
    }
}
