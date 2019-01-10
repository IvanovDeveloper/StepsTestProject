//
//  SPNetworkManager.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import Moya

class SPNetworkManager {
    
    enum NetworkError: Error {
        case responseDeserializationError
    }
    
    static let provider = MoyaProvider<SPAPI>()

    static func comments(idGte: Int? = nil,
                         idLte: Int? = nil,
                         page: Int? = nil,
                         limit: Int? = nil,
                         sortBy: String? = nil,
                         order: String? = nil,
                         successHandler: @escaping (([SPComment])->Swift.Void),
                         errorHandler: @escaping ((Error)->Swift.Void)) -> Cancellable {
        let task = SPNetworkManager.provider.request(.comments(idGte: idGte, idLte: idLte, page: page, limit: limit, sortBy: sortBy, order: order), completion: {
            result in
            switch result {
            case let .success(response):
                guard let comments = try? JSONDecoder().decode([SPComment].self, from: response.data) else {
                    errorHandler(NetworkError.responseDeserializationError)
                    return
                }
                successHandler(comments)
            case let .failure(error):
                errorHandler(error)
            }
        })
        return task
    }
}
