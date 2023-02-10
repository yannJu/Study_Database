import pymysql

config = {
    'host' : '127.0.0.1',
    'user' : 'yannju',
    'passwd' : 'dlduswn',
    'port' : 3307,
    'db' : 'multidb',
    'charset' : 'utf8'
}

def insertMemo1():
    with pymysql.connect(**config) as conn: # with 를 쓰면 close() 를 신경 안써도됌
        cursor = conn.cursor()
        
        name = "삼연조"
        msg = "이연주 배불러...."
        query = f"INSERT INTO MEMO(NAME, MSG) VALUES(\'{name}\', \'{msg}\')"
        cursor.execute(query)
        conn.commit() # --> auto commit 이 아니기 때문에 commit 하지 않으면 insert 안됌!

        query = "select * from memo"
        cursor.execute(query)
        result = cursor.fetchall()
        
        for i in result:
            print(i)
    # cursor.close()
    # conn.close()
    
def insertMemo2():
    name = input("작성자를 입력하세요 > ")
    msg = input("메모 내용을 입력하세요 > ")
    
    with pymysql.connect(**config) as conn:
        with conn.cursor() as cursor:
            # query = "INSERT INTO MEMO(name, msg) VALUES(\'{}\', \'{}\')".format(name, msg)
            query = "INSERT INTO MEMO(name, msg) VALUES(%s, %s)"
            
            cursor.execute(query, (f'{name}', f'{msg}'))
            print(f"{name} 님의 글 등록이 완료되었습니다 -")
            
            conn.commit()
            
            query = "select * from memo"
            cursor.execute(query)
            
            result = cursor.fetchall()
            for i in result:
                print(i)

insertMemo2()