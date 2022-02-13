//
//  LogListView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogListView: View {
    
    @State var logToEdit: ExpenseLog?
    @State var selectedtab = "list.dash"
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    //    @FetchRequest(
    //        entity: ExpenseLog.entity(),
    //        sortDescriptors: [
    //            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
    //        ]
    //    )
    //    private var result: FetchedResults<ExpenseLog>

   // @Environment(\.managedObjectContext) var moc
    @State private var date = Date()
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: true)
        ]
    ) var result: FetchedResults<ExpenseLog>

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "zh-cn")
        return formatter
    }

    func update(_ result : FetchedResults<ExpenseLog>)-> [[ExpenseLog]]{
        return  Dictionary(grouping: result){ (element : ExpenseLog)  in
            dateFormatter.string(from: element.date!)
        }.values.map{$0}
    }


    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = result[index]
            context.delete(log)
        }
        try? context.saveContext()
    }
    var body: some View {
        List {
            ForEach(update(result), id: \.self) { (section: [ExpenseLog]) in
                // VStack{
                Section(header: Text( self.dateFormatter.string(from: section[0].date!))) {
                    ForEach(section, id: \.self) { log in
                        Button(action: {
                            self.logToEdit = log
                        }) {
                            HStack {
                                HStack(spacing: 16) {
                                    CategoryImageView(category: log.categoryEnum)
                                    //LottieView(animType: log.categoryEnum.lottieName)
                                    //.scaledToFit()
                                    // .frame(width: 40, height: 40)

                                    //.frame(width: 100, height: 100, alignment: .center)
                                    // .offset(y:-100)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(log.categoryEnum.rawValue).font(MyFont.title)
                                        Text(log.nameText).font(MyFont.title)
                                        //                                        Text(log.date ?? Date(),style: .date)//font(.subheadline)
                                        //                                            .font(MyFont.body)
                                    }
                                    Spacer()
                                    Text(log.amountText)//.font(.headline)
                                        .font(MyFont.body)
                                }

                            }
                        }

                        //.padding()
                    }
//                    .onDelete(perform: onDelete)
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
                    //   }
                    // .background(Color.gray.cornerRadius(20).shadow(radius: 10))


                }.id(result.count)
            }
            .listStyle(InsetListStyle())

        }

    }
}
struct LogListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "ExpenseTracker")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return LogListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}
//List {
//    ForEach(update(result)) { (section: [ExpenseLog]) in//(log: ExpenseLog) in
//        Button(action: {
//            self.logToEdit = log
//        }) {
//            HStack(spacing: 16) {
//                CategoryImageView(category: log.categoryEnum)
//                //LottieView(animType: log.categoryEnum.lottieName)
//                    //.scaledToFit()
//                   // .frame(width: 40, height: 40)
//
//                    //.frame(width: 100, height: 100, alignment: .center)
//                    // .offset(y:-100)
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(log.nameText).font(MyFont.title)
//                    Text(log.date ?? Date(),style: .date)//font(.subheadline)
//                        .font(MyFont.body)
//                }
//                Spacer()
//                Text(log.amountText)//.font(.headline)
//                    .font(MyFont.body)
//            }
//            .environment(\.locale, Locale(identifier: "zh-cn"))
//
//            background(
//                Color.white
//                    .cornerRadius(20)
//                    .shadow(radius: 10)
//            )
//            .padding(.vertical, 4)
//        }
//
//    }

