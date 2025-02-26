create database ssgdb; -- root 계정으로 ssgdb라는 사용자 정의 DB생성
create user ssg@localhost identified by 'ssg1234'; -- ssg db를 사용하는 사용자 ssg 사용자 패스워드 'ssg1234'

grant all privileges on ssgdb. * to ssg@localhost;
commit;