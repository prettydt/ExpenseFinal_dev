//
//  KeyPad.swift
//  NumberKeyboard
//
//  Created by 夕拾 on 2022/2/9.
//

import SwiftUI

struct KeyPad: View {
    @Binding var string: String

    var body: some View {


        VStack{

            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: ["0", ".", "⌫"])

        }

        .foregroundColor(Color.black)




        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }

    private func keyWasPressed(_ key: String) {
        switch key {
            case "." where string.contains("."): break
            case "." where string == "0": string += key
            case "⌫":
                string.removeLast()
                if string.isEmpty { string = "0" }
            case _ where string == "0": string = key
            default: string += key
        }
    }
}

//struct KeyPad_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyPad()
//    }
//}
