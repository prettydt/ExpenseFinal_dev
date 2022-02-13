//
//  Utils.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Utils {

    static var csvModelArr = [CsvModel]()
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
       // formatter.numberStyle = .currency
        return formatter
    }()

    
    static func exportTransactions(context:NSManagedObjectContext){
        print("1~~~~")
        //得到表中所有数据
        let request = ExpenseLog.fetchRequest()
        var results:[ExpenseLog]
        //获取数据
        do {
            results  = try context.fetch(request)
            //如果表中没有数据，则返回，如果有数据，拿到数据
            if results.count <= 0 {return}
            else{
                for i in results{
                   //需要单独建立一个model存储excel的行
                   let csvModel = CsvModel()
                    csvModel.note = i.name ?? ""
                    csvModel.amount = "\(i.amountText)"
                    csvModel.category = i.category ?? ""
                    csvModel.date = i.dateText
                    csvModelArr.append(csvModel)

                }
                //数据存到数组，后面写到excel的func
                self.generateCSV()
            }
        } catch let e as NSError {
            print(e.description)
        }

    }
    static func generateCSV(){
        print("2~~~~")
        let fileName = "Expense.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "备注,金额,类型,时间\n"
        //给每一行赋值，顺序就是备注+金额+类型+时间
        for csvModel in csvModelArr{
            let row = "\"\(csvModel.note)\",\"\(csvModel.amount)\",\"\(csvModel.category)\",\"\(csvModel.date)\"\n"
            csvText.append(row)
        }

        //真正的写入csv文件
        do {
            print("3~~~~")
            try csvText.write(to: path!, atomically: true, encoding: .utf8)
            let av = UIActivityViewController(activityItems: [path!], applicationActivities: nil)
            //分享忘写了，来
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        } catch let e as NSError {
            print("4!!!")
            print(e.description)
        }
    }
}
