//
//  ItemsSectionController.swift
//  IGListKitExamples
//
//  Created by rock88 on 25/02/2017.
//  Copyright © 2017 Instagram. All rights reserved.
//

import IGListKit

protocol SectionItemCell: class {
    func configure(with item: SectionItem)
}

class ItemsSectionController: IGListSectionController {
    var items: [SectionItem] = []
}

extension ItemsSectionController {
    var collectionViewUsedAutoSizing: Bool {
        guard let adapter = collectionContext as? IGListAdapter else { return false }
        guard let layout = adapter.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return false }
        return layout.estimatedItemSize != .zero
    }
    
    func dequeueReusableCell(for item: SectionItem, at index: Int) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch item.cellIdentifier {
        case let .cellType(CellType):
            cell = collectionContext!.dequeueReusableCell(of: CellType, for: self, at: index)
        case let .storyboardIdentifier(identifier):
            cell = collectionContext!.dequeueReusableCellFromStoryboard(withIdentifier: identifier, for: self, at: index)
        case let .nibName(name):
            cell = collectionContext!.dequeueReusableCell(withNibName: name, bundle: nil, for: self, at: index)
        }
        return cell
    }
    
    func configure(cell: UICollectionViewCell, item: SectionItem) {
        if let cell = cell as? SectionItemCell {
            cell.configure(with: item)
        }
    }
    
    func cellSize(for item: SectionItem) -> CGSize {
        switch item.cellSize {
        case let .size(width, height):
            return CGSize(width: width, height: height)
        case .auto:
            if let cell = ItemsSectionControllerCellCache.shared.cell(for: item) {
                if let cell = cell as? SectionItemCell {
                    cell.configure(with: item)
                }
                
                if let size = collectionContext?.containerSize {
                    let attributes = UICollectionViewLayoutAttributes()
                    attributes.frame = CGRect(origin: .zero, size: size)
                    cell.preferredLayoutAttributesFitting(attributes)
                    return attributes.size
                }
            }
        default:
            break
        }
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
}

extension ItemsSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return items.count
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return cellSize(for: items[index])
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let item = items[index]
        let cell = dequeueReusableCell(for: item, at: index)
        configure(cell: cell, item: item)
        return cell
    }
    
    func didUpdate(to object: Any) {
        if let object = object as? DisplayDirectorSource, let items = object.data as? [SectionItem] {
            self.items = items
        }
    }
    
    func didSelectItem(at index: Int) {
        if let item = items[index] as? SectionItemActionable, let action = item.action {
            action(item, self)
        }
    }
}

extension ItemsSectionController: ItemsSectionContext {
    func reload(at indexes: IndexSet) {
        collectionContext?.reload(self)
    }
    
    func insert(at indexes: IndexSet) {
        collectionContext?.insert(in: self, at: indexes)
    }
    
    func delete(at indexes: IndexSet) {
        collectionContext?.delete(in: self, at: indexes)
    }
    
    func move(from fromIndex: Int, to toIndex: Int) {
        collectionContext?.move(in: self, from: fromIndex, to: toIndex)
    }
    
    func reload() {
        collectionContext?.reload(self)
    }
    
    func performBatch(animated: Bool, update: ItemsSectionContextUpdateType, updates: @escaping () -> Void) {
        switch update {
        case .manual:
            collectionContext?.performBatch(animated: animated, updates: updates, completion: nil)
        case .byDiff:
            let from = items as Any
            updates()
            let to = items as Any
            
            if let from = from as? [SectionItemDiffable], let to = to as? [SectionItemDiffable] {
                let result = IGListDiff(from.map { $0.diff() }, to.map { $0.diff() }, .equality).forBatchUpdates()
                collectionContext?.performBatch(animated: animated, updates: {
                    self.delete(at: result.deletes)
                    self.insert(at: result.inserts)
                    result.moves.forEach { self.move(from: $0.from, to: $0.to) }
                })
            } else {
                reload()
            }
        }
        
    }
}
