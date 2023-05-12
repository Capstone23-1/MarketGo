//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//

import SwiftUI

struct MarketTableWrapper: UIViewControllerRepresentable {
    var data: [Document]
    @Binding var selectedMarket: Document?
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
        Coordinator(data: data, selectedMarket: $selectedMarket)
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var data: [Document]
        @Binding var selectedMarket: Document?

        init(data: [Document], selectedMarket: Binding<Document?>) {
            self.data = data
            self._selectedMarket = selectedMarket
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let place = data[indexPath.row]
            cell.textLabel?.text = "\(place.placeName)   \(place.distance)m"
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedMarket = data[indexPath.row]
        }
        
        func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            selectedMarket = data[indexPath.row]
        }
        
        func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
            if let selectedMarket = selectedMarket {
                if let index = data.firstIndex(where: { $0.id == selectedMarket.id }) {
                    let indexPath = IndexPath(row: index, section: 0)
                    uiViewController.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                }
            }
        }
    }
}
