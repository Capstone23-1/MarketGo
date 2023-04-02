//
//  KakaoMapVCWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/04/03.
//

import Foundation
import SwiftUI

struct KakaoMapVCWrapper : UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        return KakaoMapVC()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
class KakaoMapVC: UIViewController{
//    #import <DaumMap/MTMapView.h>
//    - (void)viewDidLoad {
//        [super viewDidLoad];
//        _mapView = [[MTMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        _mapView.delegate = self;
//        _mapView.baseMapType = MTMapTypeHybrid;
//        [self.view addSubview:_mapView];
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID,#function,#line,"-")
        let mapView = MTMapView(frame: self.view.frame)
        mapView.baseMapType = .standard //예제소스대로
        
        
        self.view.addSubview(mapView)
    }
    
}
