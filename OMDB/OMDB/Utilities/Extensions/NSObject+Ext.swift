//
//  NSObject+Ext.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {
    public static var className: String { return String(describing: self) }
}
