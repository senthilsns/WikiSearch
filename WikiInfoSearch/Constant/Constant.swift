//
//  Constant.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//

import Foundation

class Constant {
    
    struct URLComponent {
        static let scheme = "https"
        static let host = "en.wikipedia.org"
        static let path = "/w/api.php"
    }
    
    struct QueryName {
        static let action = "action"
        static let formatversion = "formatversion"
        static let generator = "generator"
        static let gpssearch = "gpssearch"
        static let gpslimit = "gpslimit"
        static let prop = "prop"
        static let piprop = "piprop"
        static let pithumbsize = "pithumbsize"
        static let pilimit = "pilimit"
        static let redirects = "redirects"
        static let wbptterms = "wbptterms"
        static let format = "format"
        
    }
    struct QueryValue{
        static let query = "query"
        static let prefixsearch = "prefixsearch"
        static let pageimagesTerms = "pageimages|pageterms"
        static let thumbnail = "thumbnail"
        static let description = "description"
        static let json = "json"
    }
    
    struct Integer{
        static let one = "1"
        static let two = "2"
        static let ten = "10"
        static let fifty = "50"
    }

}

