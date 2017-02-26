//
//  DisplayDirectorViewController.swift
//  IGListKitExamples
//
//  Created by rock88 on 23/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import UIKit
import IGListKit

class DisplayDirectorViewController: UIViewController {
    var collectionView: IGListCollectionView!
    var displayDirector: DisplayDirector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Display Director"
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 20, height: 20)
        
        collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        displayDirector = DisplayDirector(collectionView: collectionView)
        view.addSubview(collectionView)
        
        var action2: SectionItemAction!
        
        let action: SectionItemAction = { _, context in
            let item = TestItem(cellIdentifier: .nibName("TestCell"))
            item.text = "Test\(context.items.count + 1)"
            item.action = action2
            
            context.performBatch(animated: true, update: .byDiff) {
                if context.items.count == 1 {
                    context.items = [item] + context.items
                } else {
                    context.items = [context.items.last!]
                }
                //context.insert(at: IndexSet(integer: 0))
            }
        }
        
        action2 = action
        
        let item = TestItem(cellIdentifier: .nibName("TestCell"))
        item.text = "Test1"
        item.action = action
        
        let grid = GridItem(color: UIColor(red: 237/255.0, green: 73/255.0, blue: 86/255.0, alpha: 1), itemCount: 6)
        
        displayDirector.sources = [
            DisplayDirectorSource(data: grid, type: GridSectionController.self),
            DisplayDirectorSource(data: 14, type: HorizontalSectionController.self),
            DisplayDirectorSource(data: [item], type: ItemsSectionController.self)
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
