[<= back to Table of Contents](table_of_contents.md)
<br/>

# Initial Set Up
## 1. Leap Motion 장비와 프로그램을 설치할 컴퓨터를 준비한다
- 사용 가능한 OS로 윈도우10, 맥OS에서 태스트 후 정상 작동 완료, 리눅스 환경에서도 가능한 것으로 보지만 테스트 진행이 필요
- Leap Motion의 하드웨어 스펙과 사용하는데 필요한 시스템 사양은 [링크](https://www.ultraleap.com/product/leap-motion-controller/)에서 확인 가능
<br/>

## 2. 최신 Processing을 다운받는다. [링크](https://processing.org/download/)
<br/>

## 3. 받은 Processing.exe를 실행 후 상단 옵션바에서 
-   [스케치]->[내부 라이브러리...]->[라이브러리 추가하기...]
## 로 이동한다.
<br/>

## 4. 팝업된 [Contribution Manager]창의 [Libraries]탭에서 Filter검색을 통해 다음 라이브러리들을 설치해준다.
- Leap Motion for Processing - Darius Morawiec
- HTTP Requests for Processing - Rune Madsen, Daniel Shiffman
<br/>

## 5. 프로젝트의 레파지토리를 사용하고자 하는 시스템에 다운받는다.
<br/>

## 6. 프로젝트 root에서 <set_mapping.py>를 실행해서 사용할 아두이노 디바이스에 대한 정보들을 등록해준다.
<br/>