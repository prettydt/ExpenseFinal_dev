//
//  ViewModel.swift
//  ExpenseFinal
//
//  Created by 国梁李 on 2022/1/25.
//

import SwiftUI
import CoreData
public class ViewModel:ObservableObject{
    @Published var startDate:Date = Date().getDateFor(days: -30)!
    @Published var endDate:Date = Date()
}
