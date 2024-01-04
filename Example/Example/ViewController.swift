//
//  ViewController.swift
//  Example
//
//  Created by Ven on 2023/12/21.
//

import LZUIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] = [
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LZUIKit範例"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let className = "Example\(items[indexPath.row])ViewController"
        let controllerItem = ControllerItem(controller: className)
        if let viewController = controllerItem.viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            print("Unknow class name => \(className)")
        }
    }
}

