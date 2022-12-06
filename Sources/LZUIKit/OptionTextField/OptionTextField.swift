import UIKit

public class OptionTextField: UITextField {
    private let toolBar = UIToolbar()
    private let pickerView = UIPickerView()
    public var selectedOption = "請選擇"
    public var options: [String]? {
        didSet {
            if let options = options {
                selectedOption = options.first ?? ""
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        toolBar.sizeToFit()
        toolBar.setItems([
            UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "確定", style: .plain, target: self, action: #selector(done))
        ], animated: false)
        inputAccessoryView = toolBar
        
        pickerView.dataSource = self
        pickerView.delegate = self
        inputView = pickerView
    }
    
    @objc private func done() {
        text = selectedOption
        endEditing(true)
    }
    
    @objc private func cancel() {
        endEditing(true)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialize()
    }
}

extension OptionTextField: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options?.count ?? 0
    }
}

extension OptionTextField: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        options?[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options?[row] ?? "請選擇"
    }
}
