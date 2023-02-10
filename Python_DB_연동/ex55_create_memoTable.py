import pymysql

conn = pymysql.connect(host='127.0.0.1', user='yannju', passwd='dlduswn', port=3307, db='multidb', charset='utf8')
cursor = conn.cursor()

# query = '''
# CREATE TABLE MEMO (
#     IDX INT PRIMARY KEY AUTO_INCREMENT,
#     NAME VARCHAR(20),
#     MSG VARCHAR(200),
#     WDATE DATE DEFAULT CURDATE()
# )
# '''
# cursor.execute(query)

query = '''select * from memo'''
cursor.execute(query)

table = cursor.fetchall()
print(table)

cursor.close()
conn.close()