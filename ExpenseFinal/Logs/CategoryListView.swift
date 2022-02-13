//
//  CategoryListView.swift
//  ExpenseFinal
//
//  Created by 国梁李 on 2022/1/25.
//

import SwiftUI

//
//  CategoryListView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct CategoryListView: View {
    
    @State var logToEdit: ExpenseLog?
    @State var selectedtab = "list.dash"
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
        ]
    )
    private var result: FetchedResults<ExpenseLog>
    
    init(predicate: NSPredicate?) {
        let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \ExpenseLog.amount, ascending: false)
        ]
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        List {
            ForEach(result) { (log: ExpenseLog) in
                Button(action: {
                    self.logToEdit = log
                }) {
                    HStack(spacing: 16) {
                        CategoryImageView(category: log.categoryEnum)
                        //LottieView(animType: log.categoryEnum.lottieName)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            //.background(Color.white)
                            //.shadow(color: Color.black, radius: 8, x: 3, y: 3)
                            //.frame(width: 100, height: 100, alignment: .center)
                            // .offset(y:-100)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(log.nameText).font(.headline)
                            Text(log.date ?? Date(),style: .date).font(.subheadline)
                        }
                        Spacer()
                        Text(log.amountText).font(.headline)
                    }
                    background(
                        Color.white
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    )
                    .padding(.vertical, 4)
                }

            }
               
            .onDelete(perform: onDelete)
            .sheet(item: $logToEdit, onDismiss: {
                self.logToEdit = nil
            }) { (log: ExpenseLog) in
                LogFormView(
                    logToEdit: log,
                    context: self.context,
                    name: log.name ?? "",
                    amount: log.amount?.doubleValue ?? 0,
                    selectCategory: Category(rawValue: log.category ?? "") ?? .餐饮,
                    date: log.date ?? Date()

                )
            }
        }
    }
    
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = result[index]
            context.delete(log)
        }
        try? context.saveContext()
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "ExpenseTracker")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return CategoryListView(predicate: nil)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}

