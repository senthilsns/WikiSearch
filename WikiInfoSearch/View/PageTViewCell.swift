//
//  PageTViewCell.swift
//  WikiSearch
//
//  Created by SENTHILKUMAR on 20/10/18.
//


import UIKit

class PageTViewCell: UITableViewCell {
    @IBOutlet weak var wkImageView: UIImageView!
    @IBOutlet weak var wTitleName: UILabel!
    @IBOutlet weak var wDescriptionName: UILabel!
    @IBOutlet weak var activiyIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
