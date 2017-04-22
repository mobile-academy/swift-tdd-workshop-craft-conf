//
// Copyright (©) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

let SpeakerCellIdentifier = "SpeakerCellIdentifier"

class SpeakerCollectionViewCell : UICollectionViewCell {

    let titleLabel: UILabel
    let imageView: UIImageView

    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        self.imageView = UIImageView()

        super.init(frame: frame)
        
        self.titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: UILayoutConstraintAxis.horizontal)

        self.imageView.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        self.imageView.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)

        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)

        self.titleLabel.textColor = UIColor.textColor()

        self.installConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func installConstraints () {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        let views = ["title" : self.titleLabel, "image" : self.imageView]

        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-(9)-[image]-(9)-[title]-|", options:[], metrics:nil, views:views)

        constraints.append(NSLayoutConstraint(item:self.titleLabel, attribute:NSLayoutAttribute.centerY, relatedBy:NSLayoutRelation.equal, toItem:self.contentView, attribute:NSLayoutAttribute.centerY, multiplier:1, constant:0))
        constraints.append(NSLayoutConstraint(item:self.imageView, attribute:NSLayoutAttribute.centerY, relatedBy:NSLayoutRelation.equal, toItem:self.contentView, attribute:NSLayoutAttribute.centerY, multiplier:1, constant:0))

        NSLayoutConstraint.activate(constraints)
    }
}
