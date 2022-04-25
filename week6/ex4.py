from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

db = client['test']

def query():
    c = db.restaurants.find({"address.street": "Rogers Avenue"})

    for k in c:
        count = 0
        for g in k["grades"]:
           if g["grade"] == "C" :
               count += 1
        if count > 1:
            r = db.restaurants.delete_one({"id": k["_id"]})
        else:
            r = db.restaurants.update_one({ "id" : k["_id"]},
   {
      "$push": { "grades": [{"grade": "C"}] }
   })

query()
