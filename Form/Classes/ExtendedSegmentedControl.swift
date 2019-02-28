//
//  ExtendedSegmentedControl.swift
//  Form
//
//  Created by Alexey Politov on 2019/02/28.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedSegmentedControl: UISegmentedControl {
    
    
    private var hasBeenDrawn: Bool = false
    private var sortedSegments: [UIView]?
    private var _selectedIndexes: NSMutableIndexSet = NSMutableIndexSet()
    private var _hideSeparatorBetweenSelectedSegments: Bool = false
    open var selectedSegmentIndexes: NSIndexSet {
        get {
            return _selectedIndexes
        }
        set {
            let validIndexes = newValue.indexes { (index, stop) -> Bool in
                return index < self.numberOfSegments
            }
            _selectedIndexes = NSMutableIndexSet(indexSet: validIndexes)
            selectSegmentsOfSelectedIndexes()
        }
    }
    open var hideSeparatorBetweenSelectedSegments: Bool {
        get {
            return _hideSeparatorBetweenSelectedSegments
        }
        set {
            if _hideSeparatorBetweenSelectedSegments == newValue { return }
            _hideSeparatorBetweenSelectedSegments = newValue
            selectSegmentsOfSelectedIndexes()
        }
    }
    
    func selectAllSegments(_ select: Bool) {
        selectedSegmentIndexes = select ? NSIndexSet(indexesIn: NSRange(location: 0, length: numberOfSegments)) : NSIndexSet.init()
    }
    
    
    // MARK: - Internals
    
    private func initSortedSegmentsArray() {
        sortedSegments = Array(subviews)
//        sortedSegments?.sort(by: { (view1, view2) -> Bool in
//            let x1 = view1.frame.origin.x
//            let x2 = view2.frame.origin.x
//
//            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
//                return true
////                return (x1 < x2) - (x1 > x2)
//            }
//            print("x1: \(x1); x2: \(x2)")
//            return true
////            return (x1 > x2) - (x1 < x2)
//        })
    }
    
    private func selectSegmentsOfSelectedIndexes() {
        super.selectedSegmentIndex = UISegmentedControl.noSegment
        var isPrevSelected = false
        for i in 0..<numberOfSegments {
            guard let segment = sortedSegments?[i] else {
                continue
            }
            guard segment.responds(to: #selector(setter: UIControl.isSelected)) else {
                continue
            }
            let isSelected = _selectedIndexes.contains(i)
            segment.perform(#selector(setter: UIControl.isSelected), with: isSelected)
            if i > 0 {
                let showBuiltinDivider = isSelected && isPrevSelected && !hideSeparatorBetweenSelectedSegments ? 0 : 1
                guard let prevSegment = sortedSegments?[i-1] else {
                    continue
                }
                prevSegment.setValue(showBuiltinDivider, forKey: "showDivider")
            }

        }
        
    }
    
    private func onInsertSegment(at index: Int) {
        _selectedIndexes.shiftIndexesStarting(at: index, by: 1)
        setNeedsLayout()
        layoutIfNeeded()
        initSortedSegmentsArray()
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func draw(_ rect: CGRect) {
        if !hasBeenDrawn {
            initSortedSegmentsArray()
            hasBeenDrawn = true
            selectSegmentsOfSelectedIndexes()
        }
        super.draw(rect)
    }
    
    open override var selectedSegmentIndex: Int {
        get {
            return _selectedIndexes.firstIndex == NSNotFound ? UISegmentedControl.noSegment : _selectedIndexes.firstIndex
        }
        set {
            selectedSegmentIndexes = newValue == UISegmentedControl.noSegment ? NSIndexSet.init() : NSIndexSet(index: newValue)
        }
    }
    
    open override func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) {
        super.insertSegment(withTitle: title, at: segment, animated: animated)
        onInsertSegment(at: segment)
    }
    
    open override func insertSegment(with image: UIImage?, at segment: Int, animated: Bool) {
        super.insertSegment(with: image, at: segment, animated: animated)
        onInsertSegment(at: segment)
    }
    
    open override func removeSegment(at segment: Int, animated: Bool) {
        let n = numberOfSegments
        var index = segment
        if n == 0 { return }
        if index >= n { index = n - 1}
        
        // store multiple selection
        guard let newSelectedIndexes = _selectedIndexes.mutableCopy() as? NSMutableIndexSet else {
            print("ddd 1")
            return
        }
        print("ddd 2")
//        _selectedIndexes.indexse
//        _selectedIndexes.add(index) // workaround - see http://ootips.org/yonat/workaround-for-bug-in-nsindexset-shiftindexesstartingatindex/
//        _selectedIndexes.shiftIndexesStarting(at: index, by: -1)
//
//        // remove the segment
//        super.selectedSegmentIndex = index // necessary to avoid NSRange exception
//        super.removeSegment(at: index, animated: animated) // destroys self.selectedIndexes
//
//        // restore multiple selection after animation ends
    }
    
    open override func removeAllSegments() {
        super.selectedSegmentIndex = 0
        super.removeAllSegments()
        _selectedIndexes.removeAllIndexes()
        sortedSegments = nil
    }
    
    
}
