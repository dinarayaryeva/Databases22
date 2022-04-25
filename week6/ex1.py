from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

db = client['test']

def query1():
    c = db.restaurants.find({"cuisine":"Indian"})

    return c

def query2():
    c = db.restaurants.find({"$or":[ {"cuisine":"Indian"}, {"cuisine":"Thai"}]})

    return c

def query3():
    db.restaurants.find({"address.street":"Rogers Avenue", "address.zipcode": "11226", "address.building": "1115"})

    return c

c = []
c.append(query1())
c.append(query2())
c.append(query3())

for e in c:
    for k in e:
        print(k)
