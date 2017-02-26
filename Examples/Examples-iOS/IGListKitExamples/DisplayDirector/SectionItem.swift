//
//  SectionItem.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

enum SectionItemCellIdentifier {
    case storyboardIdentifier(String)
    case cellType(UICollectionViewCell.Type)
    case nibName(String)
}

enum SectionItemCellSize {
    case none
    case auto
    case size(CGFloat, CGFloat)
}

protocol SectionItem {
    var cellIdentifier: SectionItemCellIdentifier { get }
    var cellSize: SectionItemCellSize { get }
}

extension SectionItem {
    var cellSize: SectionItemCellSize {
        return .none
    }
}

typealias SectionItemAction = (SectionItemActionable, ItemsSectionContext) -> Void

protocol SectionItemActionable: SectionItem {
    var action: SectionItemAction? { get }
}

protocol SectionItemDiffable {
    var diffToken: String { get }
    
    func diff() -> IGListDiffable
}

extension SectionItemDiffable {
    func diff() -> IGListDiffable {
        return SectionItemDiff(diffToken: diffToken)
    }
}

fileprivate class SectionItemDiff: IGListDiffable {
    let diffToken: String
    
    init(diffToken: String) {
        self.diffToken = diffToken
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return diffToken as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? SectionItemDiff else { return false }
        return diffToken == object.diffToken
    }
}
