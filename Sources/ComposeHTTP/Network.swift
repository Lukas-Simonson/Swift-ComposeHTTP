//
//  Network.swift
//
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public enum Network {
    public enum URLError: Error {
        case couldntCreateURL
    }
    
    public enum RequestError: Error {
        case invalidURLString
    }
    
    public enum ResponseError: Error {
        case couldntConvertDataToString
        case dataNotFound
    }
}
