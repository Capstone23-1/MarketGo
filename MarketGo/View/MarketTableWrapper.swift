import SwiftUI

struct MarketTableViewWrapper: UIViewControllerRepresentable {
    var data: [Document]  // 데이터 배열
    @Binding var selected: Document?  // 선택된 데이터를 바인딩할 프로퍼티
    var didSelectRowAt: ((Document) -> Void)?  // 선택된 셀에 대한 클로저
    @StateObject var vm = MarketSearchViewModel()
    @State var isLinkActive = true

   func makeUIViewController(context: Context) -> UITableViewController {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = context.coordinator  // 데이터 소스를 설정
        tableView.delegate = context.coordinator  // 델리게이트를 설정
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")  // 셀을 등록
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
            Coordinator(data: data, selected: $selected, vm: vm, parent: self)
        }

    // 데이터 소스 및 델리게이트를 구현할 Coordinator 클래스
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var data: [Document]  // 데이터 배열
            @Binding var selected: Document?  // 선택된 데이터를 바인딩할 프로퍼티
            var vm: MarketSearchViewModel  // 뷰 모델
            var parent: MarketTableViewWrapper  // 부모 뷰

            init(data: [Document], selected: Binding<Document?>, vm: MarketSearchViewModel, parent: MarketTableViewWrapper) {
                self.data = data
                self._selected = selected
                self.vm = vm
                self.parent = parent
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
                let place = data[indexPath.row]
                cell.textLabel?.text = "\(place.placeName)   \(place.distance)m"  // 셀에 데이터 표시
                
                cell.buttonAction = {
//                    self.vm.fetchMarketData(marketName: place.placeName) {
//                        // 데이터를 가져온 후에 페이지를 전환합니다.
//                        
//                                            NavigationLink(destination: MarketInfoView(selectedMarket: vm.selectedMarket), isActive: $isLinkActive) {
//                                                EmptyView()
//                                            }
//                                                .hidden()
//                                        
//                    }
                }
                return cell
            }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count  // 데이터 배열의 개수 반환
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
class CustomTableViewCell: UITableViewCell {
    var buttonAction: (() -> Void)?
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
            buttonAction?()
        }
}
