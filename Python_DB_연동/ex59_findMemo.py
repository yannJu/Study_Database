import pymysql

'''
-- 검색메뉴 --
1. 작성자
2. 메모내용

1번 선택 -> 작성자 이름을 입력하세요 -> 입력받고 -> 관련 글 모두 출력
2번 선택 -> 글 내용 입력 -> 입력받고 -> 관련 글 모두 출력
'''

def searchMemo(option, name = None, keyword = None):
    config = {
        'host' : '127.0.0.1',
        'user' : 'yannju',
        'passwd' : 'dlduswn',
        'port' : 3307,
        'db' : 'multidb',
        'charset' : 'utf8'
    }
    
    try:
        with pymysql.connect(**config) as conn:
            with conn.cursor() as cursor:
                if option == 1:
                    query = f"SELECT NAME, MSG, WDATE FROM MEMO WHERE NAME LIKE '%{name}%'"
                elif option == 2:
                    query = f"SELECT NAME, MSG, WDATE FROM MEMO WHERE MSG LIKE '%{keyword}%'"
                cursor.execute(query)
                
                result = cursor.fetchall()    
                return result
    except Exception as ex:
        print("Search DB Err : ", ex)        
        

def printMemo(result):
    print(" ---- 검색결과 ----  ")
    for i in result:
        print(f'''
            작성자 : {i[0]}
            작성일 : {i[2]}
            내용 : {i[1]}\n
            ''')
    print(" -----------------  ")

def startSearch():
    while(True):
        print(" ---- MEMO 글 검색하기 ----  ")
        print("1.   작성자로 찾기")
        print("2.   메모 내용으로 찾기")
        print("9.   종료")
        option = int(input("    >>  "))
        
        if option == 9: 
            print("검색을 종료합니다 - ")
            return
        else:
            if option == 1:
                writer = input("작성자의 이름을 입력해주세요 >> ")
                result = searchMemo(option = 1, name = writer)
            elif option == 2:
                msgKeyword = input("메모 내용을 입력해주세요 >> ")
                result = searchMemo(option = 2, keyword = msgKeyword)
            else:
                print("잘못된 값이 입력되었습니다! 다시 입력해주세요!")
                continue
                
            if len(result) > 0: printMemo(result)       
            else: print("검색 결과가 없습니다. ")

if __name__ == "__main__":
    startSearch()