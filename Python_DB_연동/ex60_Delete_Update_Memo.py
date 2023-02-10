import pymysql as sql

config = {
        'host' : '127.0.0.1',
        'user' : 'yannju',
        'passwd' : 'dlduswn',
        'port' : 3307,
        'db' : 'multidb',
        'charset' : 'utf8'
}

def deleteMemo():
    while(True):
        no = int(input("삭제할 메모의 번호를 입력해주세요 >> "))
        if no == None:
            print("삭제할 글 번호를 입력해주세요 ! ")
        else: break
    
    try:
        with sql.connect(**config) as conn:
            with conn.cursor() as cursor:
                query = f"SELECT IDX FROM MEMO WHERE IDX = {no}"
                cursor.execute(query)
                
                result = cursor.fetchall()
                if len(result) > 0:
                    query = f"DELETE FROM MEMO WHERE IDX = {no}"
                    
                    cursor.execute(query)
                    conn.commit()
                
                    print(f"{no}번 메모가 삭제되었습니다.")
                    
                else:
                    print(f"{no}번 메모가 존재하지 않습니다.")
                
    except Exception as e:
        print("deleteMemo DB Err - ", e)
        
def updateMemo():
    while(True):
        no = int(input("수정할 메모의 번호를 입력해주세요 >> "))
        if no == None:
            print("수정할 글 번호를 입력해주세요 ! ")
        else: 
            break
    
    try:           
        with sql.connect(**config) as conn:
            with conn.cursor() as cursor:
                query = "SELECT * FROM MEMO WHERE IDX = {}".format(no)
                cursor.execute(query)
                
                result = cursor.fetchall()
                if len(result) > 0:
                    print(" ----- 수정할 항목 선택 ----- ")
                    print("1.   작성자명")
                    print("2.   메모내용")
                    option = int(input("    >>  "))
                    if (option == 1):
                        editName = input("변경할 이름을 입력하여 주세요 >> ")
                        query = f"UPDATE MEMO SET NAME = \"{editName}\" WHERE IDX = {no}"
                        
                        cursor.execute(query)
                        conn.commit()
                    elif (option == 2):
                        editMemo = input("변경할 내용을 입력하여 주세요 >> ")
                        query = f"UPDATE MEMO SET MSG = '{editMemo}' WHERE IDX = {no}"
                        
                        cursor.execute(query)
                        conn.commit()
                    else: 
                        print("잘못된 숫자를 입력하셨습니다- ")
                        return
                    
                    print("{}번 메모가 변경되었습니다. - ".format(no))
                    query = f"SELECT IDX, NAME, MSG FROM MEMO WHERE IDX = {no}"
                    cursor.execute(query)
                    
                    result = cursor.fetchall()
                    print(f"{result[0][0]}|    {result[0][1]}\n내용 : {result[0][2]}")            
                else:
                    print("{}번 메모가 존재하지 않습니다.".format(no))
                        
    except Exception as e:
        print("updateMemo DB Err - ", e)
    
def startUD():
    while(True):
        print(" ---- MEMO 글 삭제 및 수정하기 ----  ")
        print("1.   삭  제")
        print("2.   수  정")
        print("9.   종료")
        option = int(input("    >>  "))
        
        if option == 9: 
            print("삭제 및 수정을 종료합니다 - ")
            return
        else:
            if option == 1: deleteMemo()
            elif option == 2: updateMemo()
            else:
                print("잘못된 값이 입력되었습니다! 다시 입력해주세요!")
                continue
        
if __name__ == "__main__":
    startUD()