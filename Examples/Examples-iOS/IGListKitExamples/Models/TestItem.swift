//
//  TestItem.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import Foundation

class TestItem: SectionItemActionable, SectionItemDiffable {
    let cellIdentifier: SectionItemCellIdentifier
    let cellSize: SectionItemCellSize = .auto
    var action: SectionItemAction?
    
    let diffToken = UUID().uuidString
    
    var text = ""
    
    init(cellIdentifier: SectionItemCellIdentifier) {
        self.cellIdentifier = cellIdentifier
    }
}
