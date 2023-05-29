//
//  UITableViewWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/04/30.
//

import SwiftUI

struct UITableViewWrapper: UIViewControllerRepresentable {
    var data: [Document]  // 데이터 배열
    @Binding var selected: Document?  // 선택된 데이터를 바인딩할 프로퍼티
    var didSelectRowAt: ((Document) -> Void)?  // 선택된 셀에 대한 클로저

    // UIViewControllerRepresentable 프로토콜 메서드 중 하나
    func makeUIViewController(context: Context) -> UITableViewController {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = context.coordinator  // 데이터 소스를 설정
        tableView.delegate = context.coordinator  // 델리게이트를 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")  // 셀을 등록
        let controller = UITableViewController(style: .plain)
        controller.tableView = tableView
        return controller
    }

    // UIViewControllerRepresentable 프로토콜 메서드 중 하나
    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        uiViewController.tableView.reloadData()  // 테이블 뷰 업데이트
    }

    // UIViewControllerRepresentable 프로토콜 메서드 중 하나
    func makeCoordinator() -> Coordinator {
        Coordinator(data: data, selected: $selected)
    }

    // 데이터 소스 및 델리게이트를 구현할 Coordinator 클래스
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var data: [Document]  // 데이터 배열
        @Binding var selected: Document?  // 선택된 데이터를 바인딩할 프로퍼티

        init(data: [Document], selected: Binding<Document?>) {
            self.data = data
            self._selected = selected
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count  // 데이터 배열의 개수 반환
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let place = data[indexPath.row]
            cell.textLabel?.text = "\(place.placeName)   \(place.distance)m"  // 셀에 데이터 표시
            //            tableView.deselectRow(at: indexPath, animated: true) // 선택된 셀의 하이라이트를 해제
            
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selected = data[indexPath.row]  // 선택된 데이터를 바인딩
            //            tableView.deselectRow(at: indexPath, animated: true) // 선택된 셀의 하이라이트를 해제
        }
        func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
            if let selectedMarket = selected {
                if let index = data.firstIndex(where: { $0.id == selectedMarket.id }) {
                    let indexPath = IndexPath(row: index, section: 0)
                    uiViewController.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                }
            }
        }
    }
}
