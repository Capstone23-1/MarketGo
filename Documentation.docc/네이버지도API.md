#  네이버지도 API를 연동해봅시다

1. Cocoa Pods 설치
- CocoaPods 다운법.md를 참고하세요
- ruby말고 brew이용하시길...

2.git-lfs 설치
```
brew install git-lfs
//해당 프로젝트 경로에서 
pod init
git-lfs install
```
3. 문서 편집
- 문서 열기
```
vi Podfile
```
- 입력모드는 `i` , 입력모드 종료 `esc` , 저장 후 파일 닫기 `:wq`
- 예시
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target '내 프로젝트 이름' do
  # Comment the next line if you don't want to use dynamic frameworks
  pod 'NMapsMap'
  # Pods for FindMiddlePoint

end
```
4. 라이브 설치
```
pod install --repo-update
```
5. <주의>pod install 후에는 .xcworkspace 파일로 프로젝트를 열어야한다.
