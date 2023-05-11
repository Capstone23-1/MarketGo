//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//

import SwiftUI
import UIKit

struct MarketTableWrapper: UIViewControllerRepresentable {
    var data: [Document]
    @Binding var selected: Document?
    
    func makeUIViewController(context: Context) -> UITableViewController {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let controller = UITableViewController(style: .plain)
        controller.tableView = tableView
        context.coordinator.viewController = controller
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
        weak var viewController: UIViewController?

        init(data: [Document], selected: Binding<Document?>) {
            self.data = data
            self._selected = selected
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let document = data[indexPath.row]
            cell.textLabel?.text = "\(document.placeName)   \(document.distance)m"
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selected = data[indexPath.row]
//            let documentDetailView = DocumentDetailView(document: data[indexPath.row])
            let documentDetailView = EmptyView()
            let detailViewController = UIHostingController(rootView: documentDetailView)
            viewController?.navigationController?.pushViewController(detailViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
