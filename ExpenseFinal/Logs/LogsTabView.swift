//
//  LogsTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogsTabView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    @State var selectedtab = "list.dash"
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                //SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Search expenses")
                FilterCategoriesView(selectedCategories: $selectedCategories)
                Divider()
                SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                Divider()
                LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
            .animation(.spring())
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                LogFormView(context: self.context)
            }
            .navigationBarItems(leading: Button(action: {
                Utils.exportTransactions(context: context)
            }, label: {
                Text("导出excel")
            }),
                trailing: Button(action: addTapped) { Image(systemName: "").foregroundColor(Color.blue) })
            .navigationBarTitle("支出明细", displayMode: .inline)
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    
    
}

struct LogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTabView()
    }
}
