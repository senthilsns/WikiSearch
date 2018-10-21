//
//  WikiPageViewController.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//


import UIKit


class WikiPageViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pageModel = PageModel()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title and description for selected page
        self.titleLabel.text = pageModel.title
        self.detailLabel.text = pageModel.wDescription
        
        // Check if image is not nit set the image
        if image != nil {
            self.imageView.image = image
        }
        
        // Do any additional setup after loading the view.
    }

}
