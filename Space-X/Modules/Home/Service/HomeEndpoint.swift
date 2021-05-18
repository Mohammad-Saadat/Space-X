//
//  HomeEndpoint.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum HomeEndpoint {
//    case something
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
//        switch self {
//        case .something: return "/"
//        }
        return "/"
    }
    
    public var method: HTTPMethod {
//        switch self {
//        case .something: return .get
//        }
        return .get
    }
    
    public var requestType: RequestType {
//        switch self {
//        case .something:
//            return .requestPlain
//        }
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
