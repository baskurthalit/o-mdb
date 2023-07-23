//
//  VMHelper.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation

enum ObservationType<T, E> where E: Error {
    case updateUI(_ data: T? = nil), error(error: E?)
}
