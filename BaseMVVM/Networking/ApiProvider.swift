//
//  NetworkManager.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/25/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Alamofire

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

struct ApiProvider {
    private let provider: MoyaProvider<ApiService>
    
    init(mockData: Bool = false) {
        let logger = NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))
        if mockData {
            provider = MoyaProvider<ApiService>(
                stubClosure: MoyaProvider.delayedStub(2),
                plugins: [logger]
            )
        } else {
            provider = MoyaProvider<ApiService>(
                session: CustomAlamofireSession.shared,
                plugins: [logger]
            )
        }
    }
    
    // MARK: - Authorization
    
    func login(username: String, password: String) -> Single<Token> {
        return provider.rx.request(.login(username: username, password: password))
            .filterSuccessfulStatusCodes()
            .mapObject(Token.self)
    }
    
    // MARK: - Profile
    
    func getProfile() -> Single<User> {
        return provider.rx.request(.getProfile)
            .filterSuccessfulStatusCodes()
            .mapObject(User.self)
    }
    
    func getItems(page: Int, pageSize: Int) -> Single<ArrayResponse<Item>> {
        return provider.rx.request(.getItems(page: page, pageSize: pageSize))
            .filterSuccessfulStatusCodes()
            .mapObject(ArrayResponse<Item>.self)
    }
    
    func downloadAvatar(_ userId: String) -> Observable<Moya.ProgressResponse> {
        return provider.rx.requestWithProgress(.downloadAvatar(contentPath: ""))
    }
    
    func getCharts(page: Int, pageSize: Int) -> Single<ArrayResponse<Chart>> {
        return provider.rx.request(.getCharts(page: page, pageSize: pageSize))
            .filterSuccessfulStatusCodes()
            .mapObject(ArrayResponse<Chart>.self)
    }
    
    func getCPIIndexs() -> Single<CPIEntity> {
        return provider.rx.request(.getCPIIndexs)
            .filterSuccessfulStatusCodes()
            .mapObject(CPIEntity.self)
    }
    
    func getIIPIndexs() -> Single<CPIEntity> {
        return provider.rx.request(.getIIPIndexs)
            .filterSuccessfulStatusCodes()
            .mapObject(CPIEntity.self)
    }
    
    // quanth: thiết lập thời gian timeout cho request api là 3s
    // https://stackoverflow.com/questions/40116000/how-can-i-set-timeout-for-requests-using-moya-pod
    class CustomAlamofireSession: Alamofire.Session {
        static let shared: CustomAlamofireSession = {
            let configuration = URLSessionConfiguration.default
            configuration.headers = .default
            configuration.timeoutIntervalForRequest = 10 // as seconds, you can set your request timeout
            configuration.timeoutIntervalForResource = 10 // as seconds, you can set your resource timeout
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return CustomAlamofireSession(configuration: configuration)
        }()
    }
}
