//
//  ItemsSectionContext.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import Foundation

enum ItemsSectionContextUpdateType {
    case manual
    case byDiff
}

protocol ItemsSectionContext: class {
    var items: [SectionItem] { get set }
    
    func reload(at indexes: IndexSet)
    func insert(at indexes: IndexSet)
    func delete(at indexes: IndexSet)
    func move(from fromIndex: Int, to toIndex: Int)
    func reload()
    func performBatch(animated: Bool, update: ItemsSectionContextUpdateType, updates: @escaping () -> Void)
}
