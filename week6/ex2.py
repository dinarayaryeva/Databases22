from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

db = client['test']

def query():
    result = db.restaurant.insert_one({"address.zipcode": "10075", "address.building": "1480", "address.coord":"[-73.9557413, 40.7720266]", "borough": "Manhattan", "cuisine":"Italian", "name": "Vella", "id": "41704620", "grades": [{"date": "2014-10-01", "grade":"A" , "score": "11"}]})

    c = db.restaurant.find({"id":"41704620"})

    for k in c:
        print(k)

query() 
