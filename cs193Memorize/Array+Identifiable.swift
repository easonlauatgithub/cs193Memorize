//
//  Array+Identifiable.swift
//  cs193Memorize
//
//  Created by Eason on 22/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import Foundation

extension Array where Element:Identifiable{
    func firstIndex(matching:Element)->Int?{
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only:Element?{
        count == 1 ? first:nil
    }
}
