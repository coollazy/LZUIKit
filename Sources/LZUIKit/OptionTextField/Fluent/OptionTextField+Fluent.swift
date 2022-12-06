import UIKit

extension OptionTextField {
    @discardableResult
    public func setSelectedOption(_ option: String) -> Self {
        selectedOption = option
        return self
    }
    
    @discardableResult
    public func setOptions(_ options: [String]) -> Self {
        self.options = options
        return self
    }
}
