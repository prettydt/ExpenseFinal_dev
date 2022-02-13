//
//  NewAds.swift
//  牛牛记账
//
//  Created by 夕拾 on 2022/2/13.
//

import SwiftUI

struct NewAds: View {
    var body: some View {
        VStack{
            Text("google 广告")
            BannerVC().frame(width: 320, height: 50, alignment: .center)

        }
    }
}

struct NewAds_Previews: PreviewProvider {
    static var previews: some View {
        NewAds()
    }
}
