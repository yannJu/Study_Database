from pymongo import MongoClient

try:
    client=MongoClient("mongodb://localhost:27017")
    print(client.list_database_names())
    print()
    #mydb 데이터베이스에 접속
    db=client['mydb']
    print('db=', db)

    result=db.emp.insert_one({'empno':7788,'ename':'SCOTT','job':'Analyst'})
    print(result)
    print('데이터 저장 성공======')

    cr=db.emp.find()
    # print(cr)


    for data in cr:
        # print(data)
        print(data['empno'], data['ename'], data['job'])

except Exception as ex:
    print('Error: ', ex)