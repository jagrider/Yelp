//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jonathan Grider on 1/27/2018
//  Copyright (c) 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
  
  // ImageView Outlets
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var ratingImageView: UIImageView!
  
  // Label Outlets
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var reviewsCountLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  
  var business: Business! {
    didSet {
      nameLabel.text = business.name
      if business.imageURL != nil {
        thumbImageView.setImageWith(business.imageURL!)
      }
      categoriesLabel.text = business.categories
      addressLabel.text = business.address
      reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
      if business.ratingImageURL != nil {
        ratingImageView.setImageWith(business.ratingImageURL!)
      }
      distanceLabel.text = business.distance
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    thumbImageView.layer.cornerRadius = 3
    thumbImageView.clipsToBounds = true
    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
