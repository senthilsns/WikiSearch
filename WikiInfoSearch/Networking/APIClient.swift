//
//  APIClient.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//

import UIKit

//1 - This APIClient will be called by the viewModel to get our app data.
class APIClient: NSObject {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    override init() {
        super.init()
        session = URLSession.shared
        task = URLSessionDownloadTask()
    }
    
    func fetchAppList(user_query: String, completion: @escaping ([String: AnyObject]?) -> Void) {
        
        var components = URLComponents()
        components.scheme = Constant.URLComponent.scheme
        components.host = Constant.URLComponent.host
        components.path = Constant.URLComponent.path
        components.queryItems = [URLQueryItem]()
        
        let query1 = URLQueryItem(name: Constant.QueryName.action, value: Constant.QueryValue.query)
        let query2 = URLQueryItem(name: Constant.QueryName.formatversion, value: Constant.Integer.two)
        let query3 = URLQueryItem(name: Constant.QueryName.generator, value: Constant.QueryValue.prefixsearch)
        let query4 = URLQueryItem(name: Constant.QueryName.gpssearch, value: user_query)
        let query5 = URLQueryItem(name: Constant.QueryName.gpslimit, value: Constant.Integer.ten)
        let query6 = URLQueryItem(name: Constant.QueryName.prop, value: Constant.QueryValue.pageimagesTerms)
        let query7 = URLQueryItem(name: Constant.QueryName.piprop, value: Constant.QueryValue.thumbnail)
        let query8 = URLQueryItem(name: Constant.QueryName.pithumbsize, value: Constant.Integer.fifty)
        let query9 = URLQueryItem(name: Constant.QueryName.pilimit, value: Constant.Integer.ten)
        let query10 = URLQueryItem(name: Constant.QueryName.redirects, value: "")
        let query11 = URLQueryItem(name: Constant.QueryName.wbptterms, value: Constant.QueryValue.description)
        let query12 = URLQueryItem(name: Constant.QueryName.format, value: Constant.QueryValue.json)
        
        components.queryItems!.append(query1)
        components.queryItems!.append(query2)
        components.queryItems!.append(query3)
        components.queryItems!.append(query4)
        components.queryItems!.append(query5)
        components.queryItems!.append(query6)
        components.queryItems!.append(query7)
        components.queryItems!.append(query8)
        components.queryItems!.append(query9)
        components.queryItems!.append(query10)
        components.queryItems!.append(query11)
        components.queryItems!.append(query12)
        
        guard let url = components.url else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            if error == nil {
                
                guard let data = data else {return}
                
                do{
                    if let responseJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        
                        //7 - create an array of dictionaries from
                        if let apps = responseJSON.value(forKeyPath: "query") {
                            //8 - set the completion handler with our apps array of dictionaries
                            if let json = apps as? [String: AnyObject] {
                                completion(json)
                            }
                        }else {
                            completion(nil)
                        }
                    }
                } catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
            }else{
                //9 - if we have an error, set our completion with nil
                completion(nil)
                print("Error getting API data: \(String(describing: error?.localizedDescription))")
                
            }
        }
        task.resume()
    }
    
    func getImageWith(url: URL, completion: @escaping (Data?) -> Void) {
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: url){
                completion(data)
            }
        })
        task.resume()
    }

}
