//
//  Grid.swift
//  cs193Memorize
//
//  Created by Eason on 16/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item:Identifiable, ItemView:View{
    private var items:[Item]
    private var viewForItem:(Item)->ItemView
    //function (Item)->ItemView will be stored in viewForItem and escape init function
    init(_ items:[Item], viewForItem: @escaping (Item)->ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        GeometryReader{ geometry in
            //self.body(for: geometry.size)
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout:GridLayout)->some View{
        ForEach(items, content: { item in
            self.body(for:item, in:layout)
        })
    }
    private func body(for item:Item, in layout:GridLayout)->some View{
        //let index = self.index(of:item)
        let index = items.firstIndex(matching:item)!
        /*
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
        */
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    /*
    func index(of item:Item)->Int{
        for index in 0..<items.count{
            if items[index].id == item.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
     */
/*
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    func body(for size:CGSize)->some View{
        ForEach(items, content: { item in
            self.body(for:item, in:size)
        })
    }
    func body(for item:Item, in size:CGSize)->some View{
        return viewForItem(item)
    }
 */
}
/*
var body: some View {
    Grid(viewModel.cards){ card in
        CardView(card: card).onTapGesture{
            self.viewModel.choose(card: card)
        }
    }
    .padding()
    .foregroundColor(Color.orange)
}
 */

