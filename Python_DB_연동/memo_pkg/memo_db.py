import pymysql as sql

# print('--memo__db.py 모듈--')
# 검색, 업로드, 삭제, 수정 서비스를 제공
# 검색 -> 메모 번호, 작성자명, 내용으로 검색 가능
# 업로드 -> Memo를 만들고 업로드
# 삭제 -> 검색 후 삭제
# 수정 -> 검색 후 수정

class Memo:
    '''
        memo 테이블이 가지고 있는 컬럼들을 Memo 클래스의
        멤버변수(instance변수) 로 구성하기
        생성자 구성하기
    '''
    def __init__(self):
        self.__idx = 0
        self.__name = None
        self.__msg = None
        self.__wdate = None
        
    # === Setter ===
    def setIdx(self, idx):
        self.__idx = idx
        
    def setName(self, name):
        self.__name = name
        
    def setMsg(self, msg):
        self.__msg = msg
        
    def setWdate(self, wdate):
        self.__wdate = wdate
    
    # === Getter ===
    def getIdx(self):
        return self.__idx
        
    def getName(self):
        return self.__name
        
    def getMsg(self):
        return self.__msg
        
    def getWdate(self):
        return self.__wdate
    
class DataManager:
    '''
        CRUD기능을 갖는 메소드를 구성
        생성자 구성하기
    ''' 
    def __init__(self):
        self.__config = {
            'host' : '127.0.0.1',
            'user' : 'yannju',
            'passwd' : 'dlduswn',
            'port' : 3307,
            'db' : 'multidb',
            'charset' : 'utf8'
        }
        self.__conn = sql.connect(**self.__config)
        self.__cursor = self.__conn.cursor()
        
    def __del__(self):
        self.__conn.close()
        self.__cursor.close()
    
    def addMemo(self, memo): 
        '''
        memo 객체를 변수로 받아서 insert 문 실행
        '''
        try:
            writer = memo.getName()
            msg = memo.getMsg()
            
            query = f"INSERT INTO MEMO(NAME, MSG) VALUES ('{writer}', '{msg}')"
            self.__cursor.execute(query)
            self.__conn.commit()
            
            print("[메모가 업로드 되었습니다 - ]\n")
                    
        except Exception as e:
            print(f"addMemo Err - : ", e)
    
    def createMemo(self): # Create
        tmpMemo = Memo()
        
        writer = input("작성자명을 입력해주세요 >> ")
        msg = input("내용을 입력하세요 >> ")
        
        tmpMemo.setName(writer)
        tmpMemo.setMsg(msg)
        
        return tmpMemo
    
    def researchMemo(self, option = None): 
        keyword=None
        
        while(True):
            if option == 4: break
            option = int(input('''
                            1. 메모번호로 검색
                            2. 작성자명으로 검색
                            3. 내용으로 검색
                            4. 전체 검색
                                >>
                            '''))
            if option in [1, 2, 3, 4]: break
            else:
                print("잘못된 번호를 입력하였습니다. - \n")
        
        try:
            query = ""
            if option == 1:
                keyword = int(input("메모 번호를 입력해주세요 >> "))
                query = f"SELECT * FROM MEMO WHERE IDX = {keyword}"
            elif option == 2:
                keyword = input("작성자명을 입력해주세요 >> ")
                query = f"SELECT * FROM MEMO WHERE NAME LIKE'%{keyword}%'"
            elif option == 3:
                keyword = input("메모 내용을 입력해주세요 >> ")
                query = f"SELECT * FROM MEMO WHERE MSG LIKE '%{keyword}%'"
            elif option == 4:
                query = "SELECT * FROM MEMO"
            
            self.__cursor.execute(query)
            result = self.__cursor.fetchall()
            
            return result
                
        except Exception as e:
            print("researchMemo DB Err - ", e)
            
    def processDelModMemo(self, option=None):
        type = ""
        if option == 1: #Del
            type = "삭제"
        elif option == 2: #Modify
            type = "수정"
        else:
            Exception(e)
            
        print(f" -*-*-*-* [ {type} ] -*-*-*-* \n")
        print(f"((   {type} 항목 검색  ))")
        
        result = self.researchMemo()
        num = -1
        
        if result == None:
            print(f"{type}할 메모가 없습니다.\n")
        elif len(result) <= 0:
            print(f"{type}할 메모가 없습니다.\n")
        else:
            for r in range(1, len(result) + 1):
                print(f"[{r}].\n{result[r - 1][1]} |   {result[r - 1][3]}\n\"{result[r - 1][2]}\"\n")
            print(f"((   {type}할 메모를 선택해 주세요 ))")
            while True:
                num = int(input("   >>  "))
                
                if (num > 0 and num <= len(result)):
                    try:
                        if option == 1: #Del
                            query = f"DELETE FROM MEMO WHERE IDX = {result[num - 1][0]}"
                        elif option == 2: #Modify
                            print("무엇을 수정하시겠습니까 ? \n")
                                
                            while(True):
                                modifyOption = int(input('''
                                                        ===============
                                                        1. 작성자명
                                                        2. 내용
                                                        ===============
                                                        '''))
                                if (modifyOption not in [1, 2]):
                                    print("잘못된 항목을 선택하였습니다 - ")
                                else: break
                            
                            modifyAfter = input("변경 내용을 입력하여 주세요\n   >> ")
                            if modifyOption ==  1:
                                query = f"UPDATE MEMO SET NAME = '{modifyAfter}' WHERE IDX = {result[num - 1][0]}"
                            else:
                                query = f"UPDATE MEMO SET MSG = '{modifyAfter}' WHERE IDX = {result[num - 1][0]}"
                    
                        self.__cursor.execute(query)
                        self.__conn.commit()
        
                    except Exception as e:
                        print("processDelModMemo DB Err - ", e)
                    
                    print(f"[메모가 {type} 되었습니다 - ]\n")
                    break
                
                else :
                    print("잘못된 항목을 선택하였습니다 -")
                
    def printMemo(self, option=None): #option == all -> 바로 전체 검색하도록
        if option == "all":  result = self.researchMemo(option = 4)
        else: result = self.researchMemo()
        
        print('''
                =====================
                       Print Memo - 
                =====================
              ''')
        if result == None or len(result) == 0:
            print("검색 결과가 없습니다 - ")
        else:
            for r in result:
                print(f'''
                    NO[{r[0]}]
                    작성자 : {r[1]}
                    작성 일자 : {r[3]}
                    내용 : {r[2]}\n
                    ''')

if __name__ == "__main__":
    dataManager = DataManager()
    while(True):
        print('''
                =====================
                Memo Manager System
                =====================
                1.  메모 업로드
                2.  메모 수정
                3.  메모 삭제
                4.  메모 검색
                9.  종료\n
            ''')
        systemOption = int(input("  >>  "))

        if (systemOption == 9):
            print(" 시스템을 종료합니다 - ")
            break
        else:
            if (systemOption == 1):
                memo = dataManager.createMemo()
                dataManager.addMemo(memo)
            elif (systemOption == 2):
                dataManager.processDelModMemo(2)
            elif (systemOption == 3):
                dataManager.processDelModMemo(1)
            
            if (systemOption == 4): dataManager.printMemo()
            else: dataManager.printMemo("all")
               