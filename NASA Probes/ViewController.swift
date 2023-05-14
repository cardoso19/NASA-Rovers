//
//  ViewController.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionUtil.request(on: "rovers/curiosity/photos",
                               method: HTTPMethod.get,
                               parameters: ["earth_date": "2015-6-3",
                                            "api_key": "DEMO_KEY"]) { (result: Result<Photos, InternalErrors>) in
                                                switch result {
                                                case .success(let value):
                                                    print(value)
                                                case .failure(let error):
                                                    print(error)
                                                }
        }
    }
}

