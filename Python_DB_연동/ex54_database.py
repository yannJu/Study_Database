'''
#pymysql설치
pip install pymysql
#절차
[1]MariaDB연결: 연결자이름=pymysql.connect(연결옵션)
[2] 커서생성: 커서명=연결자이름.cursor()
[3] sql문 실행: 커서명.execute("SQL문장")
[4] 트랜잭션 완료: 연결자이름.commit()
[5] MariaDB 연결 종료: 연결자이름.close()
'''
import pymysql

config = {
    'host' : '127.0.0.1',
    'user' : 'yannju',
    'password' : 'dlduswn',
    'port' : 3307,
    'db' : 'multidb',
    'charset' : 'utf8'
}
conn = pymysql.connect(**config) # **를 붙이면 dict 를 풀어 쓴 효과
cursor = conn.cursor()

# sql문 작성
query = "show tables"
cursor.execute(query)

# sql문 수행 결과 추출 : cursor 사용
tables = cursor.fetchall()
#print(tables)

if tables:
    print("table 이 있어오")
else:
    print("table 이 없어오. .")

# db연결자원 반납
#cursor.close()
#conn.close()