//
//  DataService.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

class DataService {
    
    class func getProducts(completion: @escaping (Products?, Error?) -> Void) {
        
        let requestUrl = URLCall.catalogue.rawValue
        let url = URL(string: requestUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
        //execute completion handler on main thread
        DispatchQueue.main.async {
            
            guard let data = data else {
              print("No data returned ")
                completion(nil, error)
              return
            }

           guard let response = response as? HTTPURLResponse else {
             print("Unable to process response")
             completion(nil, error)
             return
           }
  
           guard response.statusCode == 200 else {
             print("Failure response: \(response.statusCode)")
               completion(nil, error)
             return
           }
          
          do {
            let decoder = JSONDecoder()
            let products = try decoder.decode(Products.self, from: data)
            
              completion(products, nil)
            
          } catch {
              print("error: ", error)
              completion(nil, error)
          }
        }
      }.resume()
     
    }
}
