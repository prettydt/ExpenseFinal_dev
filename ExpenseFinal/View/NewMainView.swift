//
//  NewMainView.swift
//  牛牛记账-扫描图片,精准高效
//
//  Created by 夕拾 on 2022/2/10.
//

import SwiftUI
import CoreData
struct NewMainView: View {

      init() {
          let appearance = UITabBarAppearance()
          appearance.configureWithTransparentBackground()

          UITabBar.appearance().standardAppearance = appearance
          UITabBar.appearance().backgroundColor = UIColor.white


      }
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext

    var body: some View {

        ZStack{
            TabView{
                LogsTabView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tabItem {
                        Label("明细", systemImage: "list.dash")
                    }
                    .tag("list.dash")

                LogFormView(context:context)
                    .ignoresSafeArea(.all, edges: .all)
                    .tabItem {
                        Label("新建", systemImage: "plus.circle")
                    }
                    .tag("plus.circle")
                DashboardTabView()
                    .tabItem {
                        Label("统计", systemImage: "chart.pie.fill")
                    }
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("chart.pie.fill")


            }
 
           // BannerVC().frame(width: 320, height: 50, alignment: .center)
        }



    }
}

struct NewMainView_Previews: PreviewProvider {
    static var previews: some View {
        NewMainView()
    }
}
