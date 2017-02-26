//
//  DisplayDirectorSource.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

class DisplayDirectorSource {
    fileprivate let uuid = UUID().uuidString
    
    let data: Any
    let type: IGListSectionController.Type
    
    init(data: Any, type: IGListSectionController.Type) {
        self.data = data
        self.type = type
    }
}

extension DisplayDirectorSource: IGListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return uuid as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? DisplayDirectorSource else { return false }
        return uuid == object.uuid
    }
}
