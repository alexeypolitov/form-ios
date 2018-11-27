//
//  Operators.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/26.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

precedencegroup FormViewPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

precedencegroup FormViewGroupPrecedence {
    associativity: left
    higherThan: FormViewPrecedence
}

infix operator +++ : FormViewPrecedence

@discardableResult
public func +++ (left: FormView, right: FormViewGroup) throws -> FormView  {
    try left.addGroup(right)
    return left
}

@discardableResult
public func +++ (left: FormViewGroup, right: FormViewCell) -> FormViewGroup  {
    left.rows.append(right)
    return left
}

@discardableResult
public func +++ (left: Form, right: FormField) -> Form  {
    left.add(right)
    return left
}
