//
//  ViewController.swift
//  Alamofire的测试
//
//  Created by Alan's Macbook on 2017/7/7.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       //用Alamofire发送一个GET请求
      /* Alamofire.request("http://httpbin.org/get").responseJSON { (response) in
        guard let result = response.result.value else {
            print(response.result.error)
            return
        }
        print(result)
        }
        */
        
        /*
        //用Alamofire发送一个POST请求
        Alamofire.request("http://httpbin.org/post", method: .get, parameters: ["name" : "why"]).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            print(result)
        }
        */
        NetworkTools.requestData(type: .GET, URLString: "http://httpbin.org/get") { (result) in
            print(result)
        }
        NetworkTools.requestData(type: .POST, URLString: "http://httpbin.org/post", parameters:["name" : "why"]) { (result) in
            print(result)
        }
    }



}

