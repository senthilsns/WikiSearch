//
//  ViewController.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var pageSearchBar: UISearchBar!
    @IBOutlet weak var pageTableView: UITableView!
    
    let pageModelView = PageModelView()
    var cache: NSCache<AnyObject, AnyObject>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set tableview delegate and data source
        self.pageTableView.delegate = self
        self.pageTableView.dataSource = self
        
        // Removed extra empty table view cell
        self.pageTableView.tableFooterView = UIView()

        // Set UISearchbar delgete
        self.pageSearchBar.delegate = self
        self.pageSearchBar.placeholder = "Enter Search Text Here!"
        
        // Initilize cache object
        self.cache = NSCache()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageModelView.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PageTViewCell
        cell.wTitleName.text = pageModelView.pageTitleToDisplay(for: indexPath)
        cell.wDescriptionName.text = pageModelView.pageDescriptionToDisplay(for: indexPath)
        cell.activiyIndicator.isHidden = true
        
        // check if selected cache object nil then download image in background else fetch image from cahce
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            
            cell.wkImageView.image  = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            
            pageModelView.pageImageToDisplay(for: indexPath) { (data) in
                if let dataObj = data {
                    DispatchQueue.main.async(execute: { () -> Void in
                        // Before we assign the image, check whether the current cell is visible
                        if let updateCell = tableView.cellForRow(at: indexPath) as? PageTViewCell{
                            let image: UIImage! = UIImage(data: dataObj)
                            updateCell.wkImageView.image = image
                            self.cache.setObject(image, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let wikiPageVC = self.storyboard?.instantiateViewController(withIdentifier: "WikiPageViewController") as? WikiPageViewController {
            wikiPageVC.pageModel = self.pageModelView.pageArray[indexPath.row]
            if let image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage {
                wikiPageVC.image = image
            }
            self.navigationController?.pushViewController(wikiPageVC, animated: true)
        }
    }

}

// MARK: UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Remove cache and stored arry to update refresh data
        self.cache.removeAllObjects()
        self.pageModelView.pageArray.removeAll()
        
        // To limit network activity, reload one a second after last key press.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 1)
        
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            print("No text to search")
            return
        }
        self.searchPageWith(searchString: query)
    }
    
    // Helper method to search query
    func searchPageWith(searchString: String) {
        self.pageModelView.searchUser(user_query: searchString) {
            DispatchQueue.main.async {
                self.pageTableView.reloadData()
            }
        }
    }
    
}
