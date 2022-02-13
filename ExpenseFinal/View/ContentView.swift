//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 17/12/20.
//

import SwiftUI
//1.31
import CoreData
struct ContentView: View {
    var body: some View {
        MainTabView()

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainTabView: View {
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    @State var selectedtab = "plus.circle"
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    // Location For each Curve...
    @State var xAxis: CGFloat = 0
    
    @Namespace var animation
    
    var body: some View{
        //["chart.pie","plus.circle","list.dash"]
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView(selection: $selectedtab){
                
                DashboardTabView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("chart.pie.fill")
                
                LogFormView(context:context)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("plus.circle")
                
                LogsTabView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("list.dash")

            }
            
            // Custom tab Bar...
            
            HStack(spacing: 0){
                
                ForEach(tabs,id: \.self){image in
                    
                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedtab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                 .offset(x: selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0,y: selectedtab == image ? -50 : 0)
                               // .offset(x: 0,y: selectedtab == image ? -40 : 0)
                            
                        })
                        .onAppear(perform: {
                            
                            if image == tabs.first{
                                xAxis = -200
                            }
                        })
                    }
                    .frame(width: 30, height: 30)
                    
                    if image != tabs.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal)
            .padding(.vertical)

           .background(Color.blue.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            //.padding(.horizontal)
            // Bottom Edge...
           // .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
    
    // getting Image Color....
    
    func getColor(image: String)->Color{
        
        switch image {
        case "chart.pie.fill":
            return Color("color1")
        case "plus.circle":
            return Color("color2")
        case "list.dash":
            return Color.purple
        default:
            return Color.blue
        }
    }
}

var tabs = ["chart.pie.fill","plus.circle","list.dash"]

// Curve...

struct CustomShape: Shape {
    
    var xAxis: CGFloat
    
    // Animating Path...
    
    var animatableData: CGFloat{
        get{return xAxis}
        set{xAxis = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
