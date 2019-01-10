//
//  SPNetworkManager.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import Moya

/// Network code wrapper.
class SPNetworkManager {
    
    enum NetworkError: Error {
        case responseDeserializationError
    }
    
    static let provider = MoyaProvider<SPAPI>()

    // MARK: Requests
    
    /**
     Allow load coments.
     
     - Parameter idGte: Lowwer value for getting a range by id.
     - Parameter idGte: Upper value for getting a range by id.
     - Parameter page: Page for paggination.
     - Parameter page: Limit for paggination.
     - Parameter sortBy: Specify the parameter by which you want to do sorting. For multiple fields, use the following format: **id,name**.
     - Parameter order: Use asc or desc (asc by default).
     - Parameter successHandler: Handler which will be called after comments was loaded. Return Comments list.
     - Parameter errorHandler: Handler which will be called if occurred error.
     
     - Returns: Protocol to define the opaque type returned from a request.
     */
    static func comments(idGte: Int? = nil,
                         idLte: Int? = nil,
                         page: Int? = 1,
                         limit: Int? = 10,
                         sortBy: String? = "id",
                         order: String? = "asc",
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
