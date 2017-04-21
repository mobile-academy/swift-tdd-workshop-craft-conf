//
// Copyright (©) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class SpeakersCollectionViewLayout: UICollectionViewFlowLayout {

    override func prepare() {
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0

        super.prepare()

        self.register(SeparatorView.self, forDecorationViewOfKind: "Separator")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)
        if let actualAttributes = attributes {
            let separatorsAttributes = self.separatorAttributesForBaseAttributes(actualAttributes)
            attributes?.append(contentsOf: separatorsAttributes)
        }

        return attributes
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let cellAttributes = self.layoutAttributesForItem(at: indexPath)
        return self.layoutAttributesForDecorationViewOfKind(kind: elementKind, forCellAttributes: cellAttributes)
    }

    fileprivate func separatorAttributesForBaseAttributes(_ attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        var separatorsAttributes: [UICollectionViewLayoutAttributes] = []

        for layoutAttributes in attributes {
            let isCellAttribute = layoutAttributes.representedElementCategory == .cell
            let isNotLastCellInSection = !self.isIndexPathLastInSection(indexPath: layoutAttributes.indexPath)
            if (isCellAttribute && isNotLastCellInSection) {
                let separatorAttributes = self.layoutAttributesForDecorationViewOfKind(kind: "Separator", forCellAttributes:layoutAttributes)
                separatorsAttributes.append(separatorAttributes)
            }
        }
        return separatorsAttributes
    }

    fileprivate func layoutAttributesForDecorationViewOfKind(kind: String, forCellAttributes cellAttributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes {
        let indexPath = cellAttributes?.indexPath

        let decorationAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "Separator", with: indexPath!)
        decorationAttributes.bounds = CGRect(x: 0, y: 0, width: self.collectionView!.bounds.width, height: 1 / UIScreen.main.scale)
        decorationAttributes.center = CGPoint(x: self.collectionView!.bounds.midX, y: cellAttributes!.frame.maxY)
        return decorationAttributes
    }

    fileprivate func isIndexPathLastInSection(indexPath: IndexPath) -> Bool {
        let index = self.collectionView!.numberOfItems(inSection: indexPath.section)
        return indexPath.row == index
    }
}
