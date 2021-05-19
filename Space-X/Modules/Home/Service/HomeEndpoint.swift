//
//  HomeEndpoint.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum HomeEndpoint {
    case launches(param: Options)
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
        switch self {
        case .launches:
            return "/launches/query"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .launches:
            return .post
        }
    }
    
    public var requestType: RequestType {
        switch self {
        case .launches(let params):
            return .requestJSONEncodable(params)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
