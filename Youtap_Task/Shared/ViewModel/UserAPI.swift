//
//  UserApi.swift
//  Youtap_Task
//
//  Created by DonorRaja on 20/04/22.
//

import Foundation


class UserAPI: ObservableObject {
    
    func loadData(completion: @escaping ([User]) ->()) {
        guard let url = URL(string: Task.url) else {
            print(Task.errorUrl)
              return
          }
        URLSession.shared.dataTask(with: url) { data, response, error in
                let books = try! JSONDecoder().decode([User].self, from: data!)
                print(books)
                DispatchQueue.main.async {
                    completion(books)

                }
            }.resume()
            
        }
    }
