//
//  KeyPadRow.swift
//  NumberKeyboard
//
//  Created by 夕拾 on 2022/2/9.
//

import SwiftUI

struct KeyPadRow: View {
    var keys: [String]

    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}
//struct KeyPadRow_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyPadRow()
//    }
//}
