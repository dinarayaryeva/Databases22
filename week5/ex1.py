import psycopg2
from geopy.geocoders import Nominatim


def retrieve():

    conn = None
    try:
        
        conn = psycopg2.connect(dbname='dvdrental', user='postgres', 
                        password='12345', host='localhost', port='5432')
        
        cur = conn.cursor()

        cur.execute("ALTER TABLE address add column lat integer default 0")
        cur.execute("ALTER TABLE address add column lon integer default 0")
        
        cur.callproc('my_function')

        continue_ = True

        geolocator = Nominatim(user_agent="custom____my-application")
                   
        a = cur.fetchall()
        for row in a:
            
            location = geolocator.geocode(row[1], timeout=None)

            if location:
                lat=location.latitude
                lon=location.longitude
            else :
              lat = 0
              long = 0
              
            print(lat)
            print(lon)
            cur.execute("UPDATE address SET lon = %s, lat = %s WHERE address_id = %s; ",(lon, lat, row[0]))
            
        conn.commit()
        cur.close()
        return

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            
def f():
  retrieve()

if __name__ == '__main__':
    f()
