import pymysql

config = {
    'host' : '127.0.0.1',
    'user' : 'yannju',
    'passwd' : 'dlduswn',
    'port' : 3307,
    'db' : 'multidb',
    'charset' : 'utf8'
}

def selectMemoAll():
    try:
        with pymysql.connect(**config) as conn:
            with conn.cursor() as cursor:
                sql =  "SELECT IDX, NAME, MSG, WDATE FROM MEMO ORDER BY IDX DESC" #최근 게시글이 가장 위로 오도록
                cursor.execute(sql)
                
                result = cursor.fetchall()
                
                empLst = []
                for i in result:
                    empLst.append(i)
                    print(f'''
                         작성자 : {i[1]}\n
                         작성일 : {i[3]}\n
                         내용 : {i[2]}\n 
                          ''')
                    
    except Exception as e:
        print("selectMemoAll() DB Error : ", e)
        
if __name__ == "__main__":
    selectMemoAll()