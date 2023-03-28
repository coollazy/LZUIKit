import Foundation

extension JSONDecoder {
    // 針對時間欄位格式為 iso8601 的 JSONDecoder
    public static var iso8601: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
