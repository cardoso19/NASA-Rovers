//
//  AlamofireWrapping.swift
//  NASA Probes
//
//  Created by Matheus Kuhn on 15.05.23.
//  Copyright © 2023 MDT. All rights reserved.
//

import Alamofire

protocol AlamofireWrapping {
    func request(_ convertible: URLRequestConvertible) -> DataRequest
    func download(_ convertible: URLConvertible) -> DownloadRequest
}

extension Session: AlamofireWrapping {
    func request(_ convertible: URLRequestConvertible) -> DataRequest {
        request(convertible, interceptor: nil)
    }
    
    func download(_ convertible: URLConvertible) -> DownloadRequest {
        download(convertible, method: .get)
    }
}
