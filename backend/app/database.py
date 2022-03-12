from peewee import *

user = 'root'
password = 'play'
db_name = 'realestate'

conn = MySQLDatabase(
    db_name, user=user,
    password=password,
    host='localhost'
)