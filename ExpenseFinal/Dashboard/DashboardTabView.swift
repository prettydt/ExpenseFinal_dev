//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData
extension Date {
    func getDateFor(days:Int) -> Date? {
         return Calendar.current.date(byAdding: .day, value: days, to: Date())
    }
    func getDateFor(hours:Int) -> Date? {
         return Calendar.current.date(byAdding: .hour, value: hours, to: Date())
    }
}
struct DashboardTabView: View {
    
    @ObservedObject var vm: ViewModel = ViewModel()
  
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var showMenu: Bool = false

    @State var animatePath: Bool = false
    @State var animateBG: Bool = false
    @State var startDate: Date = Date().getDateFor(days: -30)!
    @State var selectCategory:Category = .交通
    //State var startDate = Calendar.current.date(byAdding: DateComponents(day: -6), to: Date())

    @State var endDate: Date = Date()
    @State var showDatePicker:Bool = false
    var body: some View {
        VStack(spacing: 0) {
           // VStack(spacing: 4) {
                VStack{
                        if totalExpenses != nil {
                            HStack{
                                Text("支出总计")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text(totalExpenses!.formattedCurrencyText)
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }

                        }

                    HStack{
                        Spacer()

                        DatePicker("",selection: $startDate, displayedComponents: [.date])
                            .datePickerStyle(.automatic)
                            .environment(\.locale, Locale.init(identifier: "zh-cn"))
                            .font(MyFont.body)
                            .onChange(of: startDate) { newValue in
                                fetchTotalSums(startDate: newValue as NSDate, endDate: endDate as NSDate)
                                print(newValue)
                                print(endDate)
                            }
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width:3,height: 20)

                        DatePicker("",selection: $startDate, displayedComponents: [.date])
                            .datePickerStyle(.automatic)
                            .environment(\.locale, Locale.init(identifier: "zh-cn"))
                            .font(MyFont.body)
                            .onChange(of: endDate) { newValue in
                                fetchTotalSums(startDate: startDate as NSDate, endDate: newValue as NSDate)
                                print(startDate)
                                print(newValue)
                            }
                    }
                    .frame(width:90,height: 20, alignment: .center)
                   // .padding(.horizontal)

                }
                
            

            if categoriesSum != nil {

                if totalExpenses != nil && totalExpenses! > 0 {
                    HStack{
                       // Spacer()

                        PieChartView(
                            categoriesSum:$categoriesSum,
                            formatter: {value in String(format: "$%.2f", value)},
                            selectCategory: $selectCategory

                        )

                        
                    }

                }
                Divider()

//                List {
//                    Text("清单").font(.subheadline)
//                    ForEach(self.categoriesSum!) {
//                        CategoryRowView(category: $0.category, sum: $0.sum)
//                    }
//                }
                CategoryListView(predicate: ExpenseLog.categoryPredicate(with: selectCategory, startDate: startDate as NSDate, endDate: endDate as NSDate))
            }

            if totalExpenses == nil && categoriesSum == nil {

            }
 
        }
        .onChange(of: categoriesSum) { newValue in
            print("changes")
            categoriesSum = newValue
        }
        .environment(\.locale, Locale(identifier: "zh-cn"))
        .padding(.top,50)
       // .onAppear(perform: fetchTotalSums(startDate: startDate as NSDate, endDate: endDate as NSDate))
        .onAppear(perform: {
            fetchTotalSums(startDate: startDate as NSDate, endDate: endDate as NSDate)
        })
        .ignoresSafeArea(edges: .bottom)

    }
    
    func fetchTotalSums(startDate: NSDate,endDate: NSDate) {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context,startDate: startDate, endDate: endDate) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
        }
    }
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
