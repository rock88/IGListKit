//
//  ItemsSectionControllerCellCache.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import UIKit

class ItemsSectionControllerCellCache {
    static let shared = ItemsSectionControllerCellCache()
    
    var cache = [String: UICollectionViewCell]()
    
    func cellKey(for item: SectionItem) -> String? {
        switch item.cellIdentifier {
        case let .cellType(CellType):
            return "\(CellType)_type"
        case let .nibName(name):
            return "\(name)_nib"
        default:
            return nil
        }
    }
    
    func cell(for item: SectionItem) -> UICollectionViewCell? {
        guard let key = cellKey(for: item) else { return nil }
        if let cell = cache[key] { return cell }
        
        switch item.cellIdentifier {
        case let .cellType(CellType):
            let cell = CellType.init()
            cache[key] = cell
            return cell
        case let .nibName(name):
            let views = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)
            if let cell = views.first as? UICollectionViewCell {
                cache[key] = cell
                return cell
            }
        default:
            break
        }
        return nil
    }
}
