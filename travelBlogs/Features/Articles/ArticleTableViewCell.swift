//
//  ArticleTableViewCell.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "articleCell"

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLbl: UILabel!
    @IBOutlet private weak var userDesignationLbl: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleTimeLbl: UILabel!
    @IBOutlet private weak var articleDescriptionLbl: UILabel!
    @IBOutlet private weak var articleTitleLbl: UILabel!
    @IBOutlet private weak var articleLinkLbl: UILabel!
    @IBOutlet private weak var articleLikesLbl: UILabel!
    @IBOutlet private weak var articleCommentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
