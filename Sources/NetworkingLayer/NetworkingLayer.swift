// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class NetworkingLayer {
    public let urlProtocol: String = "https"
    public let domain: String
    public let networkErrorHandler: NetworkErrorHandlingProtocol
    public let dataCoder: DataCoderProtocol
    public let getHTTP: GetHttpProtocol
    public let postHTTP: PostHttpProtocol
    public let sessionManager: SessionManagerProtocol
    
    public init(domain: String,
                networkErrorHandler: NetworkErrorHandlingProtocol = NetworkErrorHandler(),
                dataCoder: DataCoderProtocol = JSONCoder(),
                getHTTP: GetHttpProtocol = GetHTTP(),
                postHTTP: PostHttpProtocol = PostHTTP(),
                sessionManager: SessionManagerProtocol,
                
    ) {
        self.domain = domain
        self.getHTTP = getHTTP
        self.postHTTP = postHTTP
        self.networkErrorHandler = networkErrorHandler
        self.dataCoder = dataCoder
        self.sessionManager = sessionManager
    }

    public func getRequest<T: Decodable>(path: String,
                                         queryParameters: [String: Any]?,
                                         rounterParameter: String? = nil,
                                         debug: Bool = false) async throws -> T {
        let header: [String: String] = sessionManager.headers
        var endPoint: String = urlProtocol + "://" + domain + "/" + path
        
        if let safeRouterParameter: String = rounterParameter {
            endPoint += "/" + safeRouterParameter
        }

        Debugger.client(endPoint: endPoint, method: "GET", header: header, parameters: queryParameters ?? [:])

        do {
            let httpResponse: HTTPResponseModel = try await getHTTP.handle(endpoint: endPoint, headers: header, parameters: queryParameters)
            try networkErrorHandler.handle(statusCode: httpResponse.statusCode)
            let result = try dataCoder.decode(T.self, from: httpResponse.data)
            Debugger.serverJSON(data:  httpResponse.data, header: httpResponse.headers, statusCode: httpResponse.statusCode)
            sessionManager.update(from: httpResponse.headers)
            return result
        } catch let error as HTTPErrorCategoryErrors {
            throw error
        } catch let error as URLError {
            let handler = NetworkConnectionHandler()
            throw handler.handle(urlError: error)
        }
    }
    
    public func postRequest<T: Decodable, B: Encodable>(
        path: String,
        body: B,
        debug: Bool = false
    ) async throws -> T? {

        let header: [String: String] = sessionManager.headers
        let endPoint = urlProtocol + "://" + domain + "/" + path

        let bodyData = try dataCoder.encode(body)

        Debugger.client(
            endPoint: endPoint,
            method: "POST",
            header: header,
            parameters: [:]
        )

        do {
            let httpResponse = try await postHTTP.handle(
                endpoint: endPoint,
                headers: header,
                body: bodyData
            )

            Debugger.serverJSON(
                data: httpResponse.data,
                header: httpResponse.headers,
                statusCode: httpResponse.statusCode
            )
            
            try networkErrorHandler.handle(statusCode: httpResponse.statusCode)
            
            
            if httpResponse.data.isEmpty {
                sessionManager.update(from: httpResponse.headers)
                return nil
            }
            
            let result = try dataCoder.decode(T.self, from: httpResponse.data)
            sessionManager.update(from: httpResponse.headers)
            return result

        } catch let error as HTTPErrorCategoryErrors {
            throw error
        } catch let error as URLError {
            let handler = NetworkConnectionHandler()
            throw handler.handle(urlError: error)
        }
    }
}

