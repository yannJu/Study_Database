from pymongo import *
import time

try:
    client = MongoClient('mongodb://localhost:27017')
    db = client['yannjuDB']
    
    print('#' * 50)
    cr = db.emp.find()
    for r in cr:
        print(r)
    print('#' * 50)
    
    name = input("삭제할 사원의 이름을 입력하세요 : ")
    result = db.emp.delete_many({'ename' : name})
    # result = db.emp.delete_one({'ename' : name})
    
    time.sleep(1)
    cr = db.emp.find()
    for r in cr:
        print(r)
    print(result.deleted_count, '명의 데이터가 삭제되었습니다 :))')

except Exception as e:
    print("Error - ", e)