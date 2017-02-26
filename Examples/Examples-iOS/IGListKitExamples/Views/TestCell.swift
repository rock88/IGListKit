//
//  TestCell.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell, SectionItemCell {
    @IBOutlet var label: UILabel!
    
    func configure(with item: SectionItem) {
        if let item = item as? TestItem {
            label.text = item.text
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = ceil(size.width)
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
