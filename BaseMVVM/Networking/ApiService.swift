//
//  AppAPI.swift
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

enum ApiService {
    
    // MARK: - Authentication
    case login(username: String, password: String)
    case register(username: String, password: String)
    // MARK: - Profile
    case getProfile
    // MARK: - Item
    case getItems(page: Int, pageSize: Int)
    // MARK: Upload/Download
    case uploadAvatar(data: Data)
    case downloadAvatar(contentPath: String)
    // MARK: - 1. khai báo function
    case getCharts(page: Int, pageSize: Int)
    case getCPIIndexs
    case getIIPIndexs
}

extension ApiService: TargetType {
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: Configs.Network.apiBaseUrl)!
        case .downloadAvatar:
            return URL(string: "https://upload.wikimedia.org")!
        case .uploadAvatar:
            return URL(string: Configs.Network.apiBaseUrl)!
        // 2. khai báo api url nếu ko dùng base url
        case .getCharts:
            return URL(string: "https://quanth.getCharts")!
        case .getCPIIndexs:
            return URL(string: "https://quanth.free.beeceptor.com")! // https://quanth.free.beeceptor.com/ http://192.168.10.94:5000
        case .getIIPIndexs:
            return URL(string: "https://forecast-appp.herokuapp.com")!
        default:
            return URL(string: Configs.Network.apiBaseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .login( _, _):
            return "/api/login"
        case .register( _, _):
            return "/api/register"
        case .getItems:
            return "/3/discover/movie"
        case .getProfile:
            return "/api/user"
        case .uploadAvatar:
            return "/api/user/avatar"
        case .downloadAvatar:
            return "/wikipedia/commons/4/4e/Pleiades_large.jpg"
        // 3. khai báo subfix của api link
        case .getCharts( _, _):
            return "/api/charts"
        case .getCPIIndexs:
            return "/api/v1/cpies"
        case .getIIPIndexs:
            return "/get_iip"
        } 
    }
    
    var method: Moya.Method {
        // 4. khai báo method của api link, mặc định là get
        switch self {
        case .login:
            return .post
        case .uploadAvatar:
            return .post
        default:
            return .get
        }
    }
    
    var headers: [String : String]? {
        if let accessToken = AuthManager.shared.token?.accessToken {
            return ["Authorization": "Bearer \(accessToken)"]
        }
        return nil
    }
    
    var parameters: [String: Any] {
        // 5. khai báo parameter nếu có
        var params: [String: Any] = [:]
        switch self {
        case .login(let username, let password):
            params["username"] = username
            params["password"] = password
        case .register(let username, let password):
            params["username"] = username
            params["password"] = password
        case .getItems(let page, let pageSize):
            params["api_key"] = Configs.Network.apiKey
            params["page"] = page
            params["pageSize"] = pageSize
        case .getCharts(let page, let pageSize): //page: Int, pageSize: Int
            params["page"] = page
            params["pageSize"] = pageSize
        default: break
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getProfile:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getItems:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .uploadAvatar(let data):
            let multipartFormData = [MultipartFormData(provider: .data(data), name: "file", fileName: "image.png", mimeType: "image/png")]
            return .uploadCompositeMultipart(multipartFormData, urlParameters: ["api_key": "dc6zaTOxFJmzC", "username": "Moya"])
        case.downloadAvatar:
            return .downloadDestination(defaultDownloadDestination)
        default:
            return .requestPlain
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .login:
            return .successCodes
        default:
            return .successCodes
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return readJSONFromFile("MockSignIn")
        case .register:
            return readJSONFromFile("MockSignIn")
        case .getItems:
            return "{}".data(using: .utf8)!
        case .getProfile:
            return readJSONFromFile("MockProfile")
        default:
            return "{}".data(using: .utf8)!
        }
    }
}

// MARK: - Read file JSON for sample data
private func readJSONFromFile(_ fileName: String) -> Data {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            return data
        } catch {
            // Handle error here
            return "{}".data(using: .utf8)!
        }
    }
    return "{}".data(using: .utf8)!
}

private let defaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    if !directoryURLs.isEmpty {
        let customFilename = Date().iso8601String
        guard let suggestedFilename = response.suggestedFilename else {
            fatalError("@Moya/contributor error!! We didn't anticipate this being nil")
        }
        //        return (directoryURLs[0].appendingPathComponent(suggestedFilename), [])
        return (directoryURLs[0].appendingPathComponent(customFilename), [])
    }
    
    return (temporaryURL, [])
}
