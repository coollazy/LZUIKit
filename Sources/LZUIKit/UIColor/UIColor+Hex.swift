import UIKit

extension UIColor {
    /**
     UIColor hex string initialize
     
     支援3碼: #RGB or RGB
     支援6碼: #RRGGBB or RRGGBB, 預設Alpha為1
     支援8碼: #RRGGBBAA or RRGGBBAA
     */
    public convenience init(hex: String) {
        // 去除多餘空白或是換行符號, 去除開頭的#
        var hexString: String = hex
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        guard hexString.count == 3 || hexString.count == 6 || hexString.count == 8 else {
            debugPrint("Initialize UIColor with illegal hex format")
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        // 將3碼轉換為6碼
        if hexString.count == 3 {
            for (index, char) in hexString.enumerated() {
                hexString.insert(char, at: hexString.index(hexString.startIndex, offsetBy: index * 2))
            }
        }
        
        // 將6碼轉換為8碼
        if hexString.count == 6 {
            hexString = hexString + "FF"
        }
        
        let scanner = Scanner(string: hexString)
        var rgbInt: UInt64 = 0
        scanner.scanHexInt64(&rgbInt)
        
        let r: CGFloat = CGFloat((rgbInt & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgbInt & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgbInt & 0x0000FF00) >> 8) / 255.0
        let a: CGFloat = CGFloat(rgbInt & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public func hexString(withAlpha: Bool = false) -> String {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard withAlpha else {
            return String(format:"#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
        return String(format:"#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    }
}

extension String {
    public var color: UIColor {
        return .init(hex: self)
    }
}
