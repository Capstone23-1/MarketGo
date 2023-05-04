//
//  UITableViewWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/04/30.
//

import SwiftUI

struct UITableViewWrapper: UIViewControllerRepresentable {
    var data: [Document]
    @Binding var selected: Document?
    var didSelectRowAt: ((Document) -> Void)?
    
    func makeUIViewController(context: Context) -> UITableViewController {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let controller = UITableViewController(style: .plain)
        controller.tableView = tableView
        return controller
    }

    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        uiViewController.tableView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(data: data, selected: $selected)
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var data: [Document]
        @Binding var selected: Document?

        init(data: [Document], selected: Binding<Document?>) {
            self.data = data
            self._selected = selected
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let place = data[indexPath.row]
            cell.textLabel?.text = "\(place.placeName)   \(place.distance)m"
//            tableView.deselectRow(at: indexPath, animated: true) // 선택된 셀의 하이라이트를 해제

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selected = data[indexPath.row]
//            tableView.deselectRow(at: indexPath, animated: true) // 선택된 셀의 하이라이트를 해제
            
        }
        
    }
}
