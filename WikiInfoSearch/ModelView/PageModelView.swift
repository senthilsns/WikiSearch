//
//  PageModelView.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//

import UIKit

class PageModelView: NSObject {
    
    var pageArray = [PageModel]()
    let api = APIClient()
    func searchUser(user_query: String, completion: @escaping () -> Void) {
        self.pageArray.removeAll()
        self.api.fetchAppList(user_query: user_query) { (json) in
            if let jsonObj = json {
                if let pages = jsonObj["pages"] as? [[String: AnyObject]]{
                    for page in pages {
                        print(page)
                        let pageModel = PageModel()
                        pageModel.mapPageModel(dictionary: page)
                        self.pageArray.append(pageModel)
                    }
                }
            }
            completion()
        }
    }
    
    func getNumberOfRow() -> Int {
        return self.pageArray.count
    }
    
    func pageTitleToDisplay(for indexPath: IndexPath) -> String {
        let pageModel = pageArray[indexPath.row]
        return pageModel.title
    }
    
    func pageDescriptionToDisplay(for indexPath: IndexPath) -> String {
        let pageModel = pageArray[indexPath.row]
        return pageModel.wDescription
    }

    
    func pageImageToDisplay(for indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
        let pageModel = pageArray[indexPath.row]
        if let urlString = pageModel.imageUrl {
            if let url: URL = URL(string: urlString) {
                self.api.getImageWith(url: url) { (data) in
                    completion(data)
                }
            }
        }
    }
    
    
}
