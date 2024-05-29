//
//  File.swift
//  
//
//  Created by Lukas Simonson on 2/28/24.
//

import Foundation

public extension Network.HTTP {
    enum Header {
        /// The `Accept` header.
        case accept(value: CustomStringConvertible)
        
        /// The `Accept-Charset` header.
        case acceptCharset(value: CustomStringConvertible)
        
        /// The `Accept-Encoding` header.
        case acceptEncoding(value: CustomStringConvertible)
        
        /// The `Accept-Language` header.
        case acceptLanguage(value: CustomStringConvertible)
        
        /// The `Accept-Datetime` header.
        case acceptDatetime(value: CustomStringConvertible)
        
        /// The `Access-Control-Request-Method` header.
        case accessControlRequestMethod(value: CustomStringConvertible)
        
        /// The `Access-Control-Request-Headers` header.
        case accessControlRequestHeaders(value: CustomStringConvertible)
        
        /// The `Authorization` header.
        case authorization(value: CustomStringConvertible)
        
        /// The `Cache-Control` header.
        case cacheControl(value: CustomStringConvertible)
        
        /// The `Connection` header.
        case connection(value: CustomStringConvertible)
        
        /// The `Content-Length` header.
        case contentLength(value: CustomStringConvertible)
        
        /// The `Content-Type` header.
        case contentType(value: CustomStringConvertible)
        
        /// The `Cookie` header.
        case cookie(value: CustomStringConvertible)
        
        /// The `Date` header.
        case date(value: CustomStringConvertible)
        
        /// The `Expect` header.
        case expect(value: CustomStringConvertible)
        
        /// The `Forwarded` header.
        case forwarded(value: CustomStringConvertible)
        
        /// The `From` header.
        case from(value: CustomStringConvertible)
        
        /// The `Host` header.
        case host(value: CustomStringConvertible)
        
        /// The `If-Match` header.
        case ifMatch(value: CustomStringConvertible)
        
        /// The `If-Modified-Since` header.
        case ifModifiedSince(value: CustomStringConvertible)
        
        /// The `If-None-Match` header.
        case ifNoneMatch(value: CustomStringConvertible)
        
        /// The `If-Range` header.
        case ifRange(value: CustomStringConvertible)
        
        /// The `If-Unmodified-Since` header.
        case ifUnmodifiedSince(value: CustomStringConvertible)
        
        /// The `Max-Forwards` header.
        case maxForwards(value: CustomStringConvertible)
        
        /// The `Origin` header.
        case origin(value: CustomStringConvertible)
        
        /// The `Pragma` header.
        case pragma(value: CustomStringConvertible)
        
        /// The `Proxy-Authorization` header.
        case proxyAuthorization(value: CustomStringConvertible)
        
        /// The `Range` header.
        case range(value: CustomStringConvertible)
        
        /// The `Referer` header.
        case referer(value: CustomStringConvertible)
        
        /// The `TE` header.
        case te(value: CustomStringConvertible)
        
        /// The `User-Agent` header.
        case userAgent(value: CustomStringConvertible)
        
        /// The `Upgrade` header.
        case upgrade(value: CustomStringConvertible)
        
        /// The `Via` header.
        case via(value: CustomStringConvertible)
        
        /// The `Warning` header.
        case warning(value: CustomStringConvertible)
        
        /// A custom HTTP header.
        case custom(header: String, value: CustomStringConvertible)
        
        /// The field name of the header.
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
        
        /// The value of the header.
        public var value: String {
            switch self {
                case .accept(let value): return value.description
                case .acceptCharset(let value): return value.description
                case .acceptEncoding(let value): return value.description
                case .acceptLanguage(let value): return value.description
                case .acceptDatetime(let value): return value.description
                case .accessControlRequestMethod(let value): return value.description
                case .accessControlRequestHeaders(let value): return value.description
                case .authorization(let value): return value.description
                case .cacheControl(let value): return value.description
                case .connection(let value): return value.description
                case .contentLength(let value): return value.description
                case .contentType(let value): return value.description
                case .cookie(let value): return value.description
                case .date(let value): return value.description
                case .expect(let value): return value.description
                case .forwarded(let value): return value.description
                case .from(let value): return value.description
                case .host(let value): return value.description
                case .ifMatch(let value): return value.description
                case .ifModifiedSince(let value): return value.description
                case .ifNoneMatch(let value): return value.description
                case .ifRange(let value): return value.description
                case .ifUnmodifiedSince(let value): return value.description
                case .maxForwards(let value): return value.description
                case .origin(let value): return value.description
                case .pragma(let value): return value.description
                case .proxyAuthorization(let value): return value.description
                case .range(let value): return value.description
                case .referer(let value): return value.description
                case .te(let value): return value.description
                case .userAgent(let value): return value.description
                case .upgrade(let value): return value.description
                case .via(let value): return value.description
                case .warning(let value): return value.description
                case .custom(_, let value): return value.description
            }
        }
    }
}
