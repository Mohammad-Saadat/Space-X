//
//  DetailEndpoint.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum DetailEndpoint {
    case launche(id: String)
}

extension DetailEndpoint: RequestProtocol {
    
    public var relativePath: String {
        switch self {
        case .launche(let id):
            return "/launches/query/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .launche:
            return .get
        }
    }
    
    public var requestType: RequestType {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .none
    }
}
