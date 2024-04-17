//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network.HTTP {
    enum Header {
        case accept(value: String)
        case acceptCharset(value: String)
        case acceptEncoding(value: String)
        case acceptLanguage(value: String)
        case acceptDatetime(value: String)
        case accessControlRequestMethod(value: String)
        case accessControlRequestHeaders(value: String)
        case authorization(value: String)
        case cacheControl(value: String)
        case connection(value: String)
        case contentLength(value: String)
        case contentType(value: String)
        case cookie(value: String)
        case date(value: String)
        case expect(value: String)
        case forwarded(value: String)
        case from(value: String)
        case host(value: String)
        case ifMatch(value: String)
        case ifModifiedSince(value: String)
        case ifNoneMatch(value: String)
        case ifRange(value: String)
        case ifUnmodifiedSince(value: String)
        case maxForwards(value: String)
        case origin(value: String)
        case pragma(value: String)
        case proxyAuthorization(value: String)
        case range(value: String)
        case referer(value: String)
        case te(value: String)
        case userAgent(value: String)
        case upgrade(value: String)
        case via(value: String)
        case warning(value: String)
        case custom(header: String, value: String)
        
        public var field: String {
            switch self {
                case .accept: return "Accept"
                case .acceptCharset: return "Accept-Charset"
                case .acceptEncoding: return "Accept-Encoding"
                case .acceptLanguage: return "Accept-Language"
                case .acceptDatetime: return "Accept-Datetime"
                case .accessControlRequestMethod: return "Access-Control-Request-Method"
                case .accessControlRequestHeaders: return "Access-Control-Request-Headers"
                case .authorization: return "Authorization"
                case .cacheControl: return "Cache-Control"
                case .connection: return "Connection"
                case .contentLength: return "Content-Length"
                case .contentType: return "Content-Type"
                case .cookie: return "Cookie"
                case .date: return "Date"
                case .expect: return "Expect"
                case .forwarded: return "Forwarded"
                case .from: return "From"
                case .host: return "Host"
                case .ifMatch: return "If-Match"
                case .ifModifiedSince: return "If-Modified-Since"
                case .ifNoneMatch: return "If-None-Match"
                case .ifRange: return "If-Range"
                case .ifUnmodifiedSince: return "If-Unmodified-Since"
                case .maxForwards: return "Max-Forwards"
                case .origin: return "Origin"
                case .pragma: return "Pragma"
                case .proxyAuthorization: return "Proxy-Authorization"
                case .range: return "Range"
                case .referer: return "Referer"
                case .te: return "TE"
                case .userAgent: return "User-Agent"
                case .upgrade: return "Upgrade"
                case .via: return "Via"
                case .warning: return "Warning"
                case .custom(let header, _): return header
            }
        }
        
        public var value: String {
            switch self {
                case .accept(let value): return value
                case .acceptCharset(let value): return value
                case .acceptEncoding(let value): return value
                case .acceptLanguage(let value): return value
                case .acceptDatetime(let value): return value
                case .accessControlRequestMethod(let value): return value
                case .accessControlRequestHeaders(let value): return value
                case .authorization(let value): return value
                case .cacheControl(let value): return value
                case .connection(let value): return value
                case .contentLength(let value): return value
                case .contentType(let value): return value
                case .cookie(let value): return value
                case .date(let value): return value
                case .expect(let value): return value
                case .forwarded(let value): return value
                case .from(let value): return value
                case .host(let value): return value
                case .ifMatch(let value): return value
                case .ifModifiedSince(let value): return value
                case .ifNoneMatch(let value): return value
                case .ifRange(let value): return value
                case .ifUnmodifiedSince(let value): return value
                case .maxForwards(let value): return value
                case .origin(let value): return value
                case .pragma(let value): return value
                case .proxyAuthorization(let value): return value
                case .range(let value): return value
                case .referer(let value): return value
                case .te(let value): return value
                case .userAgent(let value): return value
                case .upgrade(let value): return value
                case .via(let value): return value
                case .warning(let value): return value
                case .custom(_, let value): return value
            }
        }
    }
}
