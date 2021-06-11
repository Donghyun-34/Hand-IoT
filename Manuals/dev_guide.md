[<= back to Table of Contents](table_of_contents.md)
<br/>

# Internal Function Explanation

해당 페이지는 소스코드 상 정의된 함수들을 설명하는 페이지입니다.


## Dynamic_gesture.pde
동적 제스처 관련 함수들을 모아둔 스케치입니다.


항목|설명
:---:|---
Name | gestureInit()
Description | 제스처 코드를 “00”으로 초기화
Stntax | gestureInit()
Parameters | None 
Returns | None
</br>

항목|설명
:---:|---
Name | leapOnCircleGesture()
Description | 서클 제스처를 인식하는 함수 <br>1) Leap motion에 인식된 손동작의 벡터를 분석하여 매 frame마다 direction에 저장<br>2) getDirection을 통해 반 시계(direction= 0)/시계(direction =1) 방향 서클 제스처 판단<br>3) 반시계 방향으로 서클 제스처를 했을 경우 “c0”를 result의 값으로 저장 / 시계 방향으로 서클 제스처를 했을 경우 “c1”를 저장
Stntax | leapOnSwipeGesture(g, state)
Parameters | SwipeGesture g : 기본적인 제스처의 정보를 받아온다.(direction)<br><br>int state : 제스처의 진행 상태를 가져온다. <br>1(Start) / (Update) / 3(Stop
Returns | None
</br>

항목|설명
:---:|---
Name | leapOnSwipeGesture()
Description | 스와이프 제스처를 인식하는 함수<br>1) Leap motion에 인식된 손동작의 벡터를 분석하여 매 frame마다 direction에 저장<br>2) direction에 저장된 x, y, z 축 중에서 x축를 이용하여 스와이프의 좌우 방향을 분류한다. <br>3) 왼쪽으로 스와이프 했을 경우 “s0”를 result의 값으로 저장 / 오른쪽으로 스와이프 했을 경우 “s1”를 저장
Stntax | leapOnSwipeGesture(g, state)
Parameters | SwipeGesture g : 기본적인 제스처의 정보를 받아온다.(direction)<br><br>int state : 제스처의 진행 상태를 가져온다.<br> 1(Start) / 2(Update) / 3(Stop)
Returns | None
</br>


## Static_gesture.pde
정적 제스처 관련 함수들을 모아둔 스케치입니다.

항목|설명
:---:|---
Name | static_gesture()
Description | Leap motion에 인식된 손을 분석하여 왼손/오른손을 구별하고 펴진 손가락을 파악하여 6자리의 정적 코드를 생성
Stntax | static_gesture()
Parameters | None
Returns | String[]
</br>


## Iot_comm.pde
아두이노와 통신하는 함수들을 모아둔 스케치입니다.

항목|설명
:---:|---
Name | getDevice()
Description | gesture 클래스의 st_code와 dy_code를 이용하여 device의 클래스에 저장된 아두이노 기기의 정보를 매칭시켜 아두이노 통신에 필요한 통신 코드를 생성하는 함수 매칭에 성공하면 http 형식의 주소를 반환/ 매칭에 실패하면 “error“ 반환
Stntax | getDevice(st_code, dy_code)
Parameters | String st_code : static_gesture()에서 생성된 6자리 정적 코드<br><br>String dy_code : leapOnCircleGesture() / leapOnSwipeGesture()에서 생성된 2자리 동적 코드
Returns | String[]
</br>

항목|설명
:---:|---
Name | sendSignal()
Description | getDevice에서 작성된 통신 코드를 받아서 아두이노 기기에 통신을 보내는 함수. 통신에 성공하면 반환 값으로 아두이노에서 설정된 반환 메시지를 받아온다.
Stntax | sendSignal(http_add)
Parameters | String http_add : getDevice()에서 생성된 http 형식의 신호
Returns | String[]
</br>


## Read_data.pde
JSON 파일을 불러오는 함수들을 모아둔 스케치입니다.

항목|설명
:---:|---
Name | readMetaDataJson()
Description | 아두이노 기기의 JSON 파일을 관리하는 metadata 파일에서 기기의 이름을 가져오는 함수
Stntax | readMetaDataJson()
Parameters | None
Returns |  ArrayList&#60;String&#62;
</br>

항목|설명
:---:|---
Name | readDeviceJson()
Description | 기기 JSON 파일에서 해당 기기의 이름, ip주소, 정적 제스처 아이디(st_id), 동적 제스처 아이디(dy_id)를 가져오는 함수
Stntax | readDeviceJson(DeviceJson, i)
Parameters | None
Returns | Device::Class
</br>

## Trigger.pde
트리거 인식에 필요한 함수들을 모아둔 스케치입니다.

항목|설명
:---:|---
Name | trigger()
Description | Leap motion에 인식된 손의 주먹 진 정도를 인식하여 주먹을 쥐었다 손을 펴는 데 걸린 시간을 측정하여 s초 미만일 경우 1번의 트리거가 발생한 것으로 간주. 주먹을 쥐었다가 핀 시간이 s초 이상일 경우 False를 출력
Stntax | trigger(s)
Parameters | int s : 트리거를 인식할 손 변화 시간의 간격
Returns | Boolean
</br>

## etc_function.pde
프로젝트에서 쓰이는 기타 함수들이 담겨 있는 스케치입니다. 주로 stage 초기화, 시간 초기화하는 함수들이 담겨 있습니다.

항목|설명
:---:|---
Name | statusInit()
Description | 제스처 인식 상태를 초기화하는 함수
Stntax | statusInit()
Parameters | None
Returns | None
</br>

항목|설명
:---:|---
Name | setTimetemp()
Description | 현재 제스처가 인식된 시간을 기록
Stntax | setTimetemp(t_leap)
Parameters | LeapMotion t_leap : Leap Motion 객체를 인자로 받음. 자세한 내용은 [여기에서](https://github.com/nok/leap-motion-processing/blob/master/src/de/voidplus/leapmotion/LeapMotion.java)
Returns | None 
</br>

## project.pde

1. 이 프로젝트의 메인 스케치
2. 제스처 인식 3단계로 구분
    - Stage 1 (트리거 인식 단계) - Trigger.pde 호출
        - trigger 함수를 호출하여 트리거가 인식되는지 확인
 
    - Stage 2 (정적 제스처 인식 단계) - Static_gesture.pde 호출
        - (가) 일정 시간 동안 정적 제스처가 인식되지 않으면 Time-out을 일으키며 첫 단계로 돌아간다.
 
        - (나) 일정 시간 내에 정적 제스처가 인식되면 gesture code 클래스의 st_code에 저장한 후 정적 코드를 출력

    - Stage 3 (동적 제스처 인식 단계) - Dynamic_gesture.pde 호출
        - (가) 일정 시간 동안 동적 제스처가 인식되지 않으면 Time-out을 일으키며 첫 단계로 돌아간다.
        - (나) 일정 시간 내에 동적 제스처가 인식되면 gesture code 클래스의 dy_code에 저장한 후 동적 코드를 출력
        - (다) 인식된 정적, 동적 코드를 이용하여 해당하는 아두이노 기기를 매칭 후 보낼 신호를 조합 (Iot_comm.pde – getDevice 함수 호출)
        - (라) 매칭된 기기의 주소로 조합된 신호를 송신, 아두이노 기기 동작 후 오는 response 신호를 수신한 후 수신된 신호를 출력 (Iot_comm.pde – sendSignal 함수 호출)

3. 이후 인식된 아두이노 디바이스 목록 출력
</br>