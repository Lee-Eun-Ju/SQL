
import pymysql


# 데이터 입력 -----------------------
# MySQL(데이터베이스) 연결 및 커서 생성
conn = pymysql.connect(host='127.0.0.1', user='root', password='dmswn1578^', db='hanbitDB', charset='utf8')
cur = conn.cursor()

# 테이블 만들기 및 데이터 입력
cur.execute("CREATE TABLE IF NOT EXISTS usertable (id char(4), username char(15), email char(20), birthyear int)")
cur.execute("INSERT INTO usertable VALUES('john','John Bann','john@naver.com',1990)")
cur.execute("INSERT INTO usertable VALUES('kim','Kim Chi','kim@daum.net',1992)")
cur.execute("INSERT INTO usertable VALUES('lee','Lee Pal','lee@paran.com',1988)")
cur.execute("INSERT INTO usertable VALUES('park','Park Su','park@gmail.com',1980)")

# 커밋 및 데이터베이스 닫기
conn.commit()
conn.close()


# 데이터 조회 -----------------------
# MySQL(데이터베이스) 연결 및 커서 생성
conn = pymysql.connect(host="127.0.0.1", user="root", password="dmswn1578^", db="hanbitDB", charset="utf8")
cur = conn.cursor()

# 데이터 조회 및 출력
cur.execute("SELECT * FROM usertable")
cur.fetchall()

# 데이터베이스 닫기
conn.close()