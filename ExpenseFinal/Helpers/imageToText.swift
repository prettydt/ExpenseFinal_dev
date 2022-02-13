////
////  imageToText.swift
////  Url_Demo
////
////  Created by 国梁李 on 2021/4/26.
////
//
//import SwiftUI
//import Purchases
//
//struct imageToText: View {
//    @State var subscriptionActive: Bool = false
//    @State private var showingAlert = false
//    func checkUserStatus()  {
//        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
//            subscriptionActive = purchaserInfo?.entitlements["pro"]?.isActive == true
//            print("purchaserInfo?.originalAppUserId")
//            print(purchaserInfo?.originalAppUserId)
//        }
//    }
//
//    func checkInuse() {
//        //如果已激活，或者次数有
//
//        checkUserStatus()
//        if (subscriptionActive) {
//            self.isShowPhotoLibrary = true
//        }else if ((Constant.totolLeftCount - userSettings.usedCount) >= 0 ) {
//            userSettings.usedCount += 1
//            self.isShowPhotoLibrary = true
//        }else {
//            showingAlert = true
//        }
//    }
//
//    @ObservedObject var vm = OcrService()
//    @State private var isShowPhotoLibrary = false
//    @State private var image = UIImage()
//    @ObservedObject var userSettings = UserSettings()
//    @State private var selection: Int = 1
//
//   // @AppStorage("history") var history:String = ""
//
//    var body: some View {
//        TabView{
//            VStack{
//                //文字
//                VStack{
//                    TextEditor(text: $vm.convertText)
//                        .background(Color.gray)
//                        .multilineTextAlignment(.leading)
//                        .padding()
//                    
//                }
//                
//                //按钮
//                Button(action: {
//
//                    checkInuse()
//                }) {
//                    HStack {
//                        Image(systemName: "photo")
//                            .font(.system(size: 20))
//                        
//                        Text("照片")
//                            .font(.headline)
//                    }
//                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width/2, minHeight: 0, maxHeight: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//                    .padding()
//                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("你的试用已结束，请订阅"), message: Text("订阅方法：个人->订阅"), dismissButton: .default(Text("知道了")))
//                }
//                .sheet(isPresented: $isShowPhotoLibrary) {
//                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
//                        .onDisappear{
//                            print("disappear")
//                            vm.callOCRSpace(image: image)
//                            
//                        }
//                }
//                
//            }
//            .tabItem {
//                HStack{
//                    Image(systemName: "photo")
//                    Text("照片")
//                }
//
//            }
//            .tag("1")
//            VStack{
//                //文字
//                VStack{
//                    TextEditor(text: $vm.convertText)
//                        .background(Color.gray)
//                        .multilineTextAlignment(.leading)
//                        .padding()
//                    
//                }
//                
//                //按钮
//                Button(action: {
//                    checkInuse()
//                }) {
//                    HStack {
//                        Image(systemName: "camera")
//                            .font(.system(size: 20))
//                        
//                        Text("拍照")
//                            .font(.headline)
//                    }
//                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width/2, minHeight: 0, maxHeight: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//                    .padding()
//                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("你的试用已结束，请订阅"), message: Text("订阅方法：个人->订阅"), dismissButton: .default(Text("知道了")))
//                }
//                .sheet(isPresented: $isShowPhotoLibrary) {
//                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
//                        .onDisappear{
//                            print("disappear")
//                            vm.callOCRSpace(image: image)
//                            
//                        }
//                }
//                
//            }
//            .tabItem {
//                VStack{
//                    Image(systemName: "camera")
//                    Text("拍照")
//                }
//            }
//            .tag("2")
//            historyView()
//                .tabItem {
//                    Image(systemName: "list.star")
//                    Text("历史")
//                }
//                .tag("3")
//            personView()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("个人")
//                }
//                .tag("4")
//            
//        }
//        
//    }
//}
//
//struct imageToText_Previews: PreviewProvider {
//    static var previews: some View {
//        imageToText()
//    }
//}
//
//struct textView: View {
//    @Binding var text1:String
//    var body: some View {
//        //VStack {
//        // 2.
//        //Text(text1)
//        TextEditor(text: $text1)
//            //   .padding()
//            //.fixedSize()
//            //.multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//            .foregroundColor(Color.red)
//        //.font(.custom("HelveticaNeue", size: 13))
//        //                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 50, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        //.ignoresSafeArea(.keyboard, edges: .top)
//        //  }
//    }
//}
////func exportToPDF() {
////    let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
////    let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
////
////    //View to render on PDF
////    let myUIHostingController = UIHostingController(rootView: textView(text1: $vm.convertText))
////    myUIHostingController.view.frame = CGRect(origin: .zero, size: pageSize)
////
////
////    //Render the view behind all other views
////    guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
////        print("ERROR: Could not find root ViewController.")
////        return
////    }
////    rootVC.addChild(myUIHostingController)
////    //at: 0 -> draws behind all other views
////    //at: UIApplication.shared.windows.count -> draw in front
////    rootVC.view.insertSubview(myUIHostingController.view, at: 0)
////
////
////    //Render the PDF
////    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
////    DispatchQueue.main.async {
////        do {
////            try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
////                context.beginPage()
////                myUIHostingController.view.layer.render(in: context.cgContext)
////            })
////            print("wrote file to: \(outputFileURL.path)")
////        } catch {
////            print("Could not create PDF file: \(error.localizedDescription)")
////        }
////
////        //Remove rendered view
////        myUIHostingController.removeFromParent()
////        myUIHostingController.view.removeFromSuperview()
////    }
////}
