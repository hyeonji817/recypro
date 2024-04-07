# recypro
[소개] 

리싸이프로 : 재활용품으로 만든 상품을 판매 및 운영관리하는 웹 페이지 

사용한 개발툴 : 이클립스

사용하는 웹 서버 환경 : Tomcat 9.062 

사용한 언어 : JSP, JAVA, CSS3, Javascript 

사용한 DB : MySQL


1. 메인페이지
![image](https://github.com/hyeonji817/recypro/assets/75878010/c78b713f-71a7-49df-85f2-0d10f9be816f)
![image](https://github.com/hyeonji817/recypro/assets/75878010/c19adf21-b717-4879-8731-cb9731fa3d3f)
![image](https://github.com/hyeonji817/recypro/assets/75878010/4671b760-0e49-4d55-ac29-0dea9c00a627)
- 구성페이지 : 로그인 이전(main.jsp), 로그인 이후(loginOK.jsp), 관리자 계정 로그인 이후(login_admin.jsp)     
- 배너 구현 (웹 사이트 홍보)
- 상단 서비스 옵션 구현
- 인기상품 나열
- 관리자 계정으로 로그인한 페이지일 경우, 관리자 페이지로 이동할 수 있음 


2. 계정페이지

![image](https://github.com/hyeonji817/recypro/assets/75878010/a2537ba9-2583-4dda-a09c-efe52bdd452c)
![image](https://github.com/hyeonji817/recypro/assets/75878010/c8896a5e-24ef-47be-908c-6f4214d91e1e)
![image](https://github.com/hyeonji817/recypro/assets/75878010/411b63c7-4efd-492e-a6b1-bde08fcdb623)
![image](https://github.com/hyeonji817/recypro/assets/75878010/3a51ba0d-4ebe-4621-8b1a-6179fb4d4803)

- 구성페이지 : 로그인, 회원가입, 아이디찾기, 비밀번호찾기
- MySQL 데이터베이스 연동
- 회원가입 처리 시, 회원정보가 DB로 저장 


3. 상품페이지
- 구성페이지 : 상품리스트, 상품상세, 상품리뷰, 상품주문

1) 상품리스트

![image](https://github.com/hyeonji817/recypro/assets/75878010/13957a19-4c82-4442-93a3-cadae5af90e3)
- 판매할 상품들을 리스트로 구현
- DB를 사용하여 상품 이미지 및 설명을 호출 

2) 상품상세

![image](https://github.com/hyeonji817/recypro/assets/75878010/f1aded18-d916-4cc2-894b-ceaf802a0c28)
- 특정 상품에 대한 정보 조회 (상품명, 설명, 가격 등)
- 장바구니에 담을 수 있는 기능 구현
- 상품리뷰 작성할 수 있도록 하는 옵션 구현
- 주문내역 조회 가능 


3) 상품리뷰

![image](https://github.com/hyeonji817/recypro/assets/75878010/0699e4f5-1b20-453e-88d0-ccf8cd8cba48)
- 상품상세 페이지를 통해 볼 수 있음


![image](https://github.com/hyeonji817/recypro/assets/75878010/83fec653-d39c-48e5-bf1b-66829eae29b3)
- 리뷰를 작성하거나 수정 및 삭제 가능
- 작성한 리뷰 내용이 DB에 저장되도록 구현 


4) 상품주문

![image](https://github.com/hyeonji817/recypro/assets/75878010/62d6f32a-377a-4eda-aec8-70b522068d6f)
![image](https://github.com/hyeonji817/recypro/assets/75878010/aa77044c-c107-4451-8b0a-318127bb2f50)
- 상품상세 페이지 내, '주문하기' 버튼 클릭 시 조회할 수 있는 페이지
- '장바구니' 버튼을 거쳐서도 주문 가능
- 구매할 상품에 대한 정보와 정보입력란 띄워짐 (배송지와 주문자 성명 등을 입력하면 됨)


![image](https://github.com/hyeonji817/recypro/assets/75878010/00b98c7a-4546-4b3b-9a6e-ae8cdbf515eb)
- 인적사항 입력 후, 영수증 페이지 띄우면서 인적사항이 맞는지 확인가능함 


![image](https://github.com/hyeonji817/recypro/assets/75878010/ce612f49-8d84-488e-9560-c2d1b5db2445)
- 주문완료 처리됨 


4. 마이페이지

5. 게시판페이지

6. 고객센터페이지

7. 관리자페이지

   
