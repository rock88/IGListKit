//
//  DisplayDirector.swift
//  IGListKitExamples
//
//  Created by rock88 on 23/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

class DisplayDirector {
    fileprivate let dataSource = DisplayDirectorListAdapterDataSource()
    fileprivate var adapter = IGListAdapter(updater: IGListAdapterUpdater(), viewController: nil, workingRangeSize: 0)
    
    var emptyView: UIView?
    var sources: [DisplayDirectorSource] = [] {
        didSet {
            performUpdates()
        }
    }
    
    init(collectionView: IGListCollectionView) {
        dataSource.displayDirector = self
        adapter.collectionView = collectionView
        adapter.dataSource = dataSource
    }
    
    func performUpdates(animated: Bool = true, completion: IGListKit.IGListUpdaterCompletion? = nil) {
        adapter.performUpdates(animated: animated, completion: completion)
    }
    
    func reloadData(completion: IGListKit.IGListUpdaterCompletion? = nil) {
        adapter.reloadData(completion: completion)
    }
}

fileprivate extension DisplayDirector {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return sources
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let object = object as? DisplayDirectorSource {
            return object.type.init()
        }
        return IGListSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return emptyView
    }
}

fileprivate class DisplayDirectorListAdapterDataSource: NSObject, IGListAdapterDataSource {
    weak var displayDirector: DisplayDirector!
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return displayDirector.objects(for: listAdapter)
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return displayDirector.listAdapter(listAdapter, sectionControllerFor: object)
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return displayDirector.emptyView(for: listAdapter)
    }
}
