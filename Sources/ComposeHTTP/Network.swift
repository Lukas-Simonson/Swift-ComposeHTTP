//
//  Network.swift
//
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

/// The base object that everything in SwiftHTTP-Compose is built under.
///
/// This object does nothing on its own, instead it is used as a sharing point for the functionality of this library.
/// It is done this way to avoid any conflicts with preexisting types.
public enum Network {
    
    /// Errors that can happen during the creation of the `Network.URL` type.
    public enum URLError: Error {
        case couldntCreateURL
    }
    
    /// Errors that can happen during the creation of the `Network.Request` type.
    public enum RequestError: Error {
        case invalidURLString
    }
    
    /// Errors that can happen during the creation of the `Network.Response` type.
    public enum ResponseError: Error {
        case couldntConvertDataToString
        case dataNotFound
    }
}
