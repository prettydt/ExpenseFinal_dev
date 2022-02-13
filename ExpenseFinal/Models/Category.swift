import Foundation
import SwiftUI

enum Category: String, CaseIterable {

    case 餐饮
    case 购物
    case 日用
    case 交通
    case 蔬菜
    case 水果
    case 运动
    case 娱乐
    case 通讯
    case 服饰
    case 住房
    case 家庭
    case 社交
    case 旅行
    case 医疗
    case 汽车
    case 学习
    case 宠物
    case 礼物
    case 转账
    case 饮料
    case 追星

    var systemNameIcon: String {
        switch self {
            case .餐饮:    return   "fork.knife"
            case .购物:    return   "cart.fill"
            case .日用:    return   "paperplane.fill"
            case .交通:    return   "car.fill"
            case .蔬菜:    return   "leaf.fill"
            case .水果:    return   "applelogo"
            case .运动:    return   "sportscourt.fill"
            case .娱乐:    return   "camera.on.rectangle.fill"
            case .通讯:    return   "bubble.left.fill"
            case .服饰:    return   "tshirt.fill"
            case .住房:    return   "house.fill"
            case .家庭:    return   "music.note.house.fill"
            case .社交:    return   "person.3.fill"
            case .旅行:    return   "airplane.circle.fill"
            case .医疗:    return   "cross.case.fill"
            case .汽车:    return   "car.2.fill"
            case .学习:    return   "book.fill"
            case .宠物:    return   "pawprint.fill"
            case .礼物:    return   "gift.fill"
            case .转账:    return   "creditcard.fill"
            case .饮料:    return   "drop.fill"
            case .追星:    return   "wand.and.stars"
        }
    }

    var color: Color {
        switch self {
            case .餐饮:    return     Color("餐饮")
            case .购物:    return     Color("购物")
            case .日用:    return     Color("日用")
            case .交通:    return     Color("交通")
            case .蔬菜:    return     Color("蔬菜")
            case .水果:    return     Color("水果")
            case .运动:    return     Color("运动")
            case .娱乐:    return     Color("娱乐")
            case .通讯:    return     Color("通讯")
            case .服饰:    return     Color("服饰")
            case .住房:    return     Color("住房")
            case .家庭:    return     Color("家庭")
            case .社交:    return     Color("社交")
            case .旅行:    return     Color("旅行")
            case .医疗:    return     Color("医疗")
            case .汽车:    return     Color("汽车")
            case .学习:    return     Color("学习")
            case .宠物:    return     Color("宠物")
            case .礼物:    return     Color("礼物")
            case .转账:    return     Color("转账")
            case .饮料:    return     Color("饮料")
            case .追星:    return     Color("追星")



        }
    }
}

extension Category: Identifiable {
    var id: String { rawValue }
}
