//
//  NetworkManagerProtocol.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkManagerProtocol {
    func request<Request: RequestProtocol, Response: Decodable>(_ request: Request) -> Promise<Response>
    func request<Request: RequestProtocol>(_ request: Request) -> Promise<Void>
}
