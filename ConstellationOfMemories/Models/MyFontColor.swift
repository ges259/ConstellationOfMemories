//
//  MyFontColor.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/31.
//

import UIKit

let fontCount: Int = 10 * 9

func fontColor(index: Int) -> UIColor {
    // 하나의 텀의 개수
//    let term1 = 10
//    lazy var term2 = 10 + term1
//    lazy var term3 = 10 + term2
//    lazy var term4 = 10 + term3
//    lazy var term5 = 10 + term4
//    lazy var term6 = 10 + term5
//    lazy var term7 = 10 + term6
//    lazy var term8 = 10 + term7
    
    // 모든 Font_Color의 개수
//    lazy var term9 = 10 + term8
    
    
//    let term = 10
//    let toal = 10 * 9
    
    if index < 10 {
        switch index {
        case -1: return UIColor.rgb(r: 255, g: 255, b: 255)
        case -2: return UIColor.rgb(r: 255, g: 255, b: 255)
        case -3: return UIColor.rgb(r: 255, g: 255, b: 255)
        case -4: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        case 0: return UIColor.rgb(r: 255, g: 204, b: 204)
        case 1: return UIColor.rgb(r: 255, g: 153, b: 153)
        case 2: return UIColor.rgb(r: 255, g: 102, b: 102)
        case 3: return UIColor.rgb(r: 204, g: 51, b: 51)
        case 4: return UIColor.rgb(r: 255, g: 0, b: 0)
        case 5: return UIColor.rgb(r: 204, g: 0, b: 0)
        case 6: return UIColor.rgb(r: 153, g: 0, b: 0)
        case 7: return UIColor.rgb(r: 102, g: 0, b: 0)
        case 8: return UIColor.rgb(r: 255, g: 255, b: 255)
        case 9: return UIColor.rgb(r: 255, g: 255, b: 255)
        
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 20 {
        switch index + 40 {
        case 50: return UIColor.rgb(r: 255, g: 204, b: 153)
        case 51: return UIColor.rgb(r: 255, g: 153, b: 102)
        case 52: return UIColor.rgb(r: 255, g: 102, b: 51)
        case 53: return UIColor.rgb(r: 255, g: 102, b: 0)
        case 54: return UIColor.rgb(r: 255, g: 51, b: 0)
        case 55: return UIColor.rgb(r: 204, g: 51, b: 0)
        case 56: return UIColor.rgb(r: 153, g: 51, b: 0)
        case 57: return UIColor.rgb(r: 102, g: 51, b: 0)
        case 58: return UIColor.rgb(r: 0, g: 0, b: 0)
        case 59: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 30 {
        switch index + 80 {
        case 100: return UIColor.rgb(r: 255, g: 255, b: 204)
        case 101: return UIColor.rgb(r: 255, g: 255, b: 153)
        case 102: return UIColor.rgb(r: 255, g: 255, b: 102)
        case 103: return UIColor.rgb(r: 255, g: 255, b: 51)
        case 104: return UIColor.rgb(r: 255, g: 255, b: 0)
        case 105: return UIColor.rgb(r: 255, g: 204, b: 0)
        case 106: return UIColor.rgb(r: 204, g: 153, b: 0)
        case 107: return UIColor.rgb(r: 102, g: 50, b: 0)
        case 108: return UIColor.rgb(r: 51, g: 51, b: 51)
        case 109: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 40 {
        switch index + 120 {
        case 150: return UIColor.rgb(r: 204, g: 255, b: 204)
        case 151: return UIColor.rgb(r: 153, g: 255, b: 153)
        case 152: return UIColor.rgb(r: 102, g: 255, b: 102)
        case 153: return UIColor.rgb(r: 0, g: 255, b: 0)
        case 154: return UIColor.rgb(r: 0, g: 204, b: 0)
        case 155: return UIColor.rgb(r: 0, g: 153, b: 0)
        case 156: return UIColor.rgb(r: 0, g: 102, b: 0)
        case 157: return UIColor.rgb(r: 0, g: 51, b: 0)
        case 158: return UIColor.rgb(r: 102, g: 102, b: 102)
        case 159: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 50 {
        switch index + 160 {
        case 200: return UIColor.rgb(r: 153, g: 255, b: 204)
        case 201: return UIColor.rgb(r: 102, g: 255, b: 204)
        case 202: return UIColor.rgb(r: 102, g: 204, b: 204)
        case 203: return UIColor.rgb(r: 0, g: 204, b: 204)
        case 204: return UIColor.rgb(r: 0, g: 153, b: 153)
        case 205: return UIColor.rgb(r: 0, g: 102, b: 102)
        case 206: return UIColor.rgb(r: 51, g: 102, b: 102)
        case 207: return UIColor.rgb(r: 0, g: 51, b: 51)
        case 208: return UIColor.rgb(r: 153, g: 153, b: 153)
        case 209: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 60 {
        switch index + 200 {
        case 251: return UIColor.rgb(r: 204, g: 255, b: 255)
        case 252: return UIColor.rgb(r: 153, g: 255, b: 255)
        case 253: return UIColor.rgb(r: 0, g: 255, b: 255)
        case 254: return UIColor.rgb(r: 0, g: 204, b: 255)
        case 255: return UIColor.rgb(r: 0, g: 153, b: 255)
        case 256: return UIColor.rgb(r: 0, g: 102, b: 255)
        case 257: return UIColor.rgb(r: 0, g: 51, b: 255)
        case 258: return UIColor.rgb(r: 204, g: 204, b: 204)
        case 259: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 70 {
        switch index + 240 {
        case 300: return UIColor.rgb(r: 153, g: 204, b: 255)
        case 301: return UIColor.rgb(r: 102, g: 204, b: 255)
        case 302: return UIColor.rgb(r: 51, g: 153, b: 255)
        case 303: return UIColor.rgb(r: 51, g: 102, b: 255)
        case 304: return UIColor.rgb(r: 0, g: 0, b: 255)
        case 305: return UIColor.rgb(r: 0, g: 0, b: 204)
        case 306: return UIColor.rgb(r: 0, g: 0, b: 153)
        case 307: return UIColor.rgb(r: 0, g: 0, b: 102)
        case 308: return UIColor.rgb(r: 204, g: 204, b: 153)
        case 309: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else if index < 80 {
        switch index + 280 {
        case 350: return UIColor.rgb(r: 204, g: 204, b: 255)
        case 351: return UIColor.rgb(r: 153, g: 153, b: 255)
        case 352: return UIColor.rgb(r: 153, g: 102, b: 255)
        case 353: return UIColor.rgb(r: 153, g: 51, b: 255)
        case 354: return UIColor.rgb(r: 153, g: 0, b: 204)
        case 355: return UIColor.rgb(r: 102, g: 51, b: 153)
        case 356: return UIColor.rgb(r: 102, g: 0, b: 153)
        case 357: return UIColor.rgb(r: 51, g: 0, b: 102)
        case 358: return UIColor.rgb(r: 153, g: 153, b: 204)
        case 359: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
        
    } else {
        switch index + 320 {
        case 400: return UIColor.rgb(r: 255, g: 204, b: 255)
        case 401: return UIColor.rgb(r: 255, g: 153, b: 255)
        case 402: return UIColor.rgb(r: 255, g: 102, b: 255)
        case 403: return UIColor.rgb(r: 255, g: 51, b: 255)
        case 404: return UIColor.rgb(r: 255, g: 0, b: 255)
        case 405: return UIColor.rgb(r: 255, g: 0, b: 153)
        case 406: return UIColor.rgb(r: 204, g: 0, b: 153)
        case 407: return UIColor.rgb(r: 153, g: 0, b: 102)
        case 408: return UIColor.rgb(r: 102, g: 102, b: 102)
        case 409: return UIColor.rgb(r: 255, g: 255, b: 255)
            
        default: return UIColor.rgb(r: 255, g: 255, b: 255)
        }
    }
}
