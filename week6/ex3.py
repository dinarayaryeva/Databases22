from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

db = client['test']

def query():
    result = db.restaurants.delete_one({"borough": "Manhattan"})
    result = db.restaurants.delete_many({"cuisine": "Thai"})

query()
