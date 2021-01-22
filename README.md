# memoApp
-------------------------------------------------------------
## 기능
- 구글 계정을 통해 로그인(추후에 페이스북 카카오톡 등 다른 sns로그인 추가 예정)
- 메모를 적은 뒤 firebase realtime database에 저장
- 오늘부터 일주일 까지의 메모를 database에서 불러오기
- 구글 계정 정보(프로필 사진, 이메일, 이름)을 보여주고 오늘 메모 수 보여주기
## 개발 환경
- 안드로이드 스튜디오
- flutter(Dart)

## 구성 및 캡쳐

### 로그인 화면
- goologin.dart(https://github.com/cpcp127/memoApp/blob/master/lib/goologin.dart)


<img src="https://user-images.githubusercontent.com/53109077/100846642-1aa12400-34c2-11eb-814f-9b0bdd2626e6.jpg" width="300"></img>
<img src="https://user-images.githubusercontent.com/53109077/100846709-30164e00-34c2-11eb-8910-8d943b87eff7.jpg" width="300"></img>

- 초기 화면이고 하단 'Google 계정으로 로그인' 버튼 클릭하면 왼쪽 화면 처럼 구글 로그인 창이 나온다


- bottomNavigationBar로 메모하기, 마이페이지, 메모지 아이템을 설정해줬다
- appbar 왼쪽에 열쇠 아이콘을 클릭하면 alertdialog가 뜨며 로그아웃이 가능하다

### 메모하기 화면
- memoboard.dart(https://github.com/cpcp127/memoApp/blob/master/lib/memoboard.dart)

<img src="https://user-images.githubusercontent.com/53109077/105489785-2a392e00-5cf7-11eb-968f-7a04f7c48c63.jpg" width="300"></img>

- bottomNavigationBar로 메모하기, 일정 달력, 마이페이지 아이템을 설정해줬다
- dropdownbutton을 통해 과제, 약속, 기타 로 분류를 설정한다
- textfield에 메모를 적는다
- 날짜 버튼을 클릭하면 datapicker가 나와서 날짜 설정이 가능하다
- 저장 버튼을 클릭하면 snackbar가 나와서 저장됬다고 알려준다

### 마이페이지 화면
- account_page.dart(https://github.com/cpcp127/memoApp/blob/master/lib/accout_page.dart)

<img src="https://user-images.githubusercontent.com/53109077/100848113-09591700-34c4-11eb-97b7-041ee42c9084.jpg" width="300"></img>
- 구글 계정 정보를 받아온 화면이다
- user.displayname, user.email, user.photoUrl 을 통해 이름, 이메일, 프로필 사진을 받아온다
- database에서 날짜를 받아와 오늘까지 해야 할 일 개수를 알려준다

### 메모지 화면
- schedule_main.dart(https://github.com/cpcp127/memoApp/blob/master/lib/schedule_main.dart)

<img src="https://user-images.githubusercontent.com/53109077/100848670-c9defa80-34c4-11eb-8318-0980137742f2.jpg" width="300"></img>
- DateTime.now를 사용해 오늘과 일주일 까지 일정을 보여주기 위해 버튼을 만들었다

### 메모 목록 화면
- schedule_list(https://github.com/cpcp127/memoApp/tree/master/lib/schedule_list)

<img src="https://user-images.githubusercontent.com/53109077/100849105-6acdb580-34c5-11eb-96a4-31929bfa94a1.jpg" width="300"></img>
- 메모지 화면에서 이동한 날짜에 따른 메모 목록화면이다
- 분류, 메모, 날짜를 card위젯에 넣어서 리스트뷰로 보여준다

