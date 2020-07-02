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
    
    private var viewModel: ArticleViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2.0
    }
    
    func assign(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        self.updateUI()
    }
    
    private func updateUI() {
        self.updateUserImage()
        self.userNameLbl.text = self.viewModel?.userName ?? ""
        self.userDesignationLbl.text = self.viewModel?.designation ?? ""
        self.articleTimeLbl.text = self.viewModel?.timeElapsed ?? ""
        
        self.updateArticleImage()

        self.articleDescriptionLbl.text = self.viewModel?.articleDescription
        self.updateArticleTitleAndLink()
        self.articleLikesLbl.text = self.viewModel?.numberOfLikes ?? ""
        self.articleCommentLbl.text = self.viewModel?.numberOfComments ?? ""
    }
    
    private func updateUserImage() {
        if let imageURL = self.viewModel?.userImageURL {
            self.userImageView.image = nil
            ImageFetcher().downloadImage(url: imageURL) { (image, url, _) in
                if url == imageURL {
                    self.userImageView.image = image
                }
            }
        }
    }
    
    private func updateArticleImage() {
        if let imageURL = self.viewModel?.articleImageURL {
            //Show image
            self.articleImageView.isHidden = false
            self.articleImageView.image = nil
            ImageFetcher().downloadImage(url: imageURL) { (image, url, _) in
                if url == imageURL {
                    self.articleImageView.image = image
                }
            }
        } else {
            self.articleImageView.isHidden = true
        }
    }
    
    private func updateArticleTitleAndLink() {
        if let title = self.viewModel?.articleTitle {
            //Show image
            self.articleTitleLbl.isHidden = false
            self.articleTitleLbl.text = title
        } else {
            self.articleTitleLbl.isHidden = true
        }
        
        if let source = self.viewModel?.articleURL {
            //Show image
            self.articleLinkLbl.isHidden = false
            self.articleLinkLbl.text = source
        } else {
            self.articleLinkLbl.isHidden = true
        }
    }
}
