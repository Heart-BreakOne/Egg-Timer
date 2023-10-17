//

import Foundation

struct HardnessModel {
    let hardness: [String:Int]
    let hard : String
    let time : Int
    init (h: String, t: Int) {
        hardness = [h:t]
        hard = h
        time = t
    }
}
