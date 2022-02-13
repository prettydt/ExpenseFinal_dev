//
//  LogFormView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogFormView: View {
    
    var logToEdit: ExpenseLog?
    var context: NSManagedObjectContext
    
    @State var name: String = ""
    @State var amount: Double = 0
    @State var selectCategory: Category = .餐饮
    @State var date: Date = Date()
    @State var showAmount:Bool = true
    @State var imageAttached: UIImage = UIImage()
    @State var showAttachSheet = false
    @Environment(\.presentationMode)
    var presentationMode
    
    var title: String {
        // logToEdit == nil ? "新建支出" : "编辑支出"
        logToEdit == nil ? "" : ""
    }
    var pickColorTable:[GridItem] = Array(repeating: .init(.flexible(), spacing: 5), count: 5)

    @State var showAD:Bool = false
    @State var isShowPhotoLibrary:Bool = false
    @State var isShowCamera:Bool = false
    @State var image:UIImage = UIImage()
    @State private var amountStr = "0"
    var body: some View {
        VStack {
            HStack{
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
                Spacer()
                BannerVC().frame(width: 300, height: 20, alignment: .center)

            }
            //UIScreen.main.bounds.height < 750 ? .vertical : .init(),
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: pickColorTable, spacing: 5) {

                    ForEach(Category.allCases) { category in
                        VStack{
                            Image(systemName: category.systemNameIcon)
                                .font(.system(size: 20))
                                .foregroundColor(category.color)
//                                .padding(4)
//                                .background(selectCategory == category ? category.color : Color.clear)
//                                .clipShape(Circle())
                            Text(category.rawValue.capitalized)
                        }
                        .font(.system(size: 12))
                        .frame(width: 50, height: 50, alignment: .center)
                        .onTapGesture {
                            selectCategory = category
                        }
                        .padding(5)
                        .background(selectCategory == category ? selectCategory.blue.opacity(0.3) : Color.white)
                        .clipShape(Circle())
                        //.scaleEffect(selectCategory == category ? 1.2 : 1)
                       // .animation(.spring(), value: 5)
                    }

                }
            }

            .padding()
            //金额+时间
            HStack {

                Text("¥")
                Text(amountStr)
                    .padding(.leading,10)
                Spacer()
                DatePicker( selection: $date, displayedComponents: .date){

                }

                .datePickerStyle(DefaultDatePickerStyle()).environment(\.locale, Locale.init(identifier: "zh-CN"))//.datePickerStyle(WheelDatePickerStyle())

            }.padding([.leading, .trailing])
            //类别
            //备注
            Divider()

            TextField("备注", text: $name)
                .font(.system(size: 16))
                .padding(.leading)
            Divider()
            //number keyboard
            HStack{
                KeyPad(string: $amountStr)
                    .frame(height: UIScreen.main.bounds.height < 750 ? 120 : 200)
                Button {
                    self.onSaveTapped()
                } label: {
                    Text("确认")
                        .font(.title2)
                        .padding()
                       // .padding(.vertical,80)
                        .frame(height: UIScreen.main.bounds.height < 750 ? 120 : 200)
                        .background(amountStr == "0" ? Color.gray.opacity(0.1) : Color.green.opacity(0.7))
                        .cornerRadius(10)
                    // .shadow(radius: 10)
                    //  .border(Color.black)
                }


            }
            //.frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 3 , alignment: .center)
            .padding()
            .padding(.bottom,60)
        }
        .font(.largeTitle)
        .padding()
        .ignoresSafeArea()

        .onAppear {
            if logToEdit == nil {
                amountStr = "0"
            }else{
                amountStr = "\(amount)"
            }
        }

        
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let log: ExpenseLog
        if let logToEdit = self.logToEdit {
            log = logToEdit

        } else {
            log = ExpenseLog(context: self.context)
            log.id = UUID()

        }
        
        log.name = self.name
        log.category = self.selectCategory.rawValue
        log.amount = NSDecimalNumber(value: Double(self.amountStr)!)
        // log.date = self.date
        let initTz = TimeZone(abbreviation: "GMT")!

        var calendar = Calendar.current

        log.date = calendar.dateBySetting(timeZone: initTz, of: self.date)!


        print("~~~~~~~~~")
        let container = NSPersistentContainer(name: "ExpenseFinal")
        print(container.persistentStoreDescriptions.first?.url)
        print(log.date)
        log.imageAttached = image.jpegData(compressionQuality: 1.0)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

extension Calendar {

    // case 1
    func dateBySetting(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: self.timeZone, from: date)
        components.timeZone = timeZone
        return self.date(from: components)
    }

    // case 2
    func dateBySettingTimeFrom(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: timeZone, from: date)
        components.timeZone = self.timeZone
        return self.date(from: components)
    }
}
