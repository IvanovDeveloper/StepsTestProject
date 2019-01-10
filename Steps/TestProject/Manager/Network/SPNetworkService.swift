//
//  SPNetworkService.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Moya

enum SPAPI {
    /// Get comments endpoint.
    case comments(idGte: Int?, idLte: Int?, page: Int?, limit: Int?, sortBy: String?, order: String?)
}

// MARK: - TargetType Protocol Implementation
extension SPAPI: TargetType {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var path: String {
        switch self {
        case .comments:
            return "/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .comments:
            return .get
        }
    }
    
    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.queryString
        }
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .comments(let idGte, let idLte, let page, let limit, let sortBy, let order):
            var parameters: [String: Any] = [:]
            if let value = idGte {
                parameters["id_gte"] = "\(value)"
            }
            if let value = idLte {
                parameters["id_lte"] = "\(value)"
            }
            if let value = page {
                parameters["_page"] = "\(value)"
            }
            if let value = limit {
                parameters["_limit"] = "\(value)"
            }
            if let value = sortBy {
                parameters["_sort"] = value
            }
            if let value = order {
                parameters["_order"] = value
            }
            return parameters
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

// MARK: - Helpers

private extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

