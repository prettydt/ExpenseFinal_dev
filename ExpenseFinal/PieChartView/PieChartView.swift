//
//  PieChartView.swift
//
//
//  Created by Nazar Ilamanov on 4/23/21.
//
//Chart 加点击，点完了加载明细
//Chart加日期范围
//List加日期范围
//form加图片
//icon
//预览
import SwiftUI

@available(OSX 10.15, *)
public struct PieChartView: View {
    @Binding var categoriesSum: [CategorySum]?
    //@State public var categoriesSum!.map {$0.sum }: [Double] = []
    //@State public var categoriesSum!.map {$0.category.rawValue}: [String]
    @State public var formatter: (Double) -> String
    
   // @State public var categoriesSum!.map {$0.category.color}: [Color]
    @State public var backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0)
    
    public var widthFraction: CGFloat = 0.75
    public var innerRadiusFraction: CGFloat = 0.6
    
    @State private var activeIndex: Int = -1

    @Binding var selectCategory:Category
  //  @State selectSlice:PieSliceData
  
    var slices: [PieSliceData] {
        let sum = categoriesSum!.map {$0.sum }.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in categoriesSum!.map {$0.sum }.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.categoriesSum!.map {$0.category.color}[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
//    public init(categoriesSum!.map {$0.sum }:[Double], categoriesSum!.map {$0.category.rawValue}: [String], formatter: @escaping (Double) -> String, categoriesSum!.map {$0.category.color}: [Color] = [Color.blue, Color.green, Color.orange], backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60){
//        self.categoriesSum!.map {$0.sum } = categoriesSum!.map {$0.sum }
//        self.categoriesSum!.map {$0.category.rawValue} = categoriesSum!.map {$0.category.rawValue}
//        self.formatter = formatter
//
//        self.categoriesSum!.map {$0.category.color} = categoriesSum!.map {$0.category.color}
//        self.backgroundColor = backgroundColor
//        self.widthFraction = widthFraction
//        self.innerRadiusFraction = innerRadiusFraction
//
//    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(0..<categoriesSum!.map {$0.sum }.count,id:\.self){ i in
                    PieSlice(name:categoriesSum!.map {$0.category.rawValue}[i], pieSliceData: slices[i])
                        .scaleEffect(self.activeIndex == i ? 1.1 : 1)
                        .animation(Animation.spring())
                        .shadow(radius: self.activeIndex == i ? 10 : 0)
                        .onTapGesture {
                            activeIndex = i
                            selectCategory = categoriesSum!.map {$0.category }[i]
                            //selectCategory = categories[i]
                            print("selectCategory")
                            print(selectCategory.rawValue)
                        }
                }
                Circle()
                    .fill(Color.white)
                    .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)

//                VStack {
//                    Text(self.activeIndex == -1 ? "Total" : categoriesSum!.map {$0.category.rawValue}[self.activeIndex])
//                        .font(.title)
//                        .foregroundColor(Color.gray)
//                    Text(self.formatter(self.activeIndex == -1 ? categoriesSum!.map {$0.sum }.reduce(0, +) : categoriesSum!.map {$0.sum }[self.activeIndex]))
//                        .font(.title)
//                }
//                .foregroundColor(.black)
//                .offset(y:-10)
            }

            
        }
        .padding()
        .padding(.leading)
//        .onAppear {
//            categoriesSum!.map {$0.sum } = categories.map{$0.sum}
//        }
//        GeometryReader { geometry in
////            VStack{
////                ZStack{
//
//                    //.frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
////                    .gesture(
////                        DragGesture(minimumDistance: 0,coordinateSpace: .named("myCoordinateSpace"))
////                            .onChanged { value in
////                                let radius = 0.5 * widthFraction * geometry.size.width
////                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
////                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
////                                if (dist > radius || dist < radius * innerRadiusFraction) {
////                                    self.activeIndex = -1
////                                    return
////                                }
////                                var radians = Double(atan2(diff.x, diff.y))
////                                if (radians < 0) {
////                                    radians = 2 * Double.pi + radians
////                                }
////
////                                for (i, slice) in slices.enumerated() {
////                                    if (radians < slice.endAngle.radians) {
////                                        self.activeIndex = i
////                                        break
////                                    }
////                                }
////                            }
////                            .onEnded { value in
////                               // self.activeIndex = 1.3
////                            }
////                    )
////                    Circle()
////                        .fill(Color.white)
////                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
////
////                    VStack {
////                        Text(self.activeIndex == -1 ? "Total" : categoriesSum!.map {$0.category.rawValue}[self.activeIndex])
////                            .font(.title)
////                            .foregroundColor(Color.gray)
////                        Text(self.formatter(self.activeIndex == -1 ? categoriesSum!.map {$0.sum }.reduce(0, +) : categoriesSum!.map {$0.sum }[self.activeIndex]))
////                            .font(.title)
////                    }
////                    .foregroundColor(.black)
////                    .offset(y:-10)
//                    
//                }
                //.coordinateSpace(name: "myCoordinateSpace")
//            }
//
//            .background(Color.white)
//            .foregroundColor(Color.white)
//        }
        //.frame(width: (UIScreen.main.bounds.width / 3) * 2, alignment: .center)
    }
}
//
//@available(OSX 10.15, *)
//struct PieChartRows: View {
//    var categoriesSum!.map {$0.category.color}: [Color]
//    var categoriesSum!.map {$0.category.rawValue}: [String]
//    var categoriesSum!.map {$0.sum }: [String]
//    var percents: [String]
//
//    var body: some View {
//        VStack{
//            ForEach(0..<self.categoriesSum!.map {$0.sum }.count){ i in
//                HStack {
//                    RoundedRectangle(cornerRadius: 5.0)
//                        .fill(self.categoriesSum!.map {$0.category.color}[i])
//                        .frame(width: 20, height: 20)
//                    Text(self.categoriesSum!.map {$0.category.rawValue}[i])
//                    Spacer()
//                    VStack(alignment: .trailing) {
//                        Text(self.categoriesSum!.map {$0.sum }[i])
//                        Text(self.percents[i])
//                            .foregroundColor(Color.gray)
//                    }
//                }
//            }
//        }
//    }
//}

//@available(OSX 10.15.0, *)
//struct PieChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        PieChartView(categoriesSum!.map {$0.sum }: [1300, 500, 300], categoriesSum!.map {$0.category.rawValue}: ["Rent", "Transport", "Education"], formatter: {value in String(format: "$%.2f", value)})
//    }
//}
//

