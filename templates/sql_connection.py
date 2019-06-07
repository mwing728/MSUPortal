from flask import Flask, request, render_template
import mysql.connector
import hashlib

@app.route('/sql_connection', methods = ['POST'])
def registerUser():
    mydb = mysql.connector.connect(
        host = "localhost",
        user = "root",
        passwd = ""
    )
    mycursor = mydb.cursor()
    Firstname = request.form['FirstName']
    LastName = request.form['LastName']
    Email = request.form['email']
    OldPassword = request.form['password']
    newPassword = hashlib.md5(OldPassword.encode())

    sql = "INSERT INTO Registration (FirstName, LastName, Email, Password VALUES (%s, %s, %s, %s)"
    val = (Firstname, LastName, Email, newPassword)

    mycursor.execute(sql, val)

    mydb.commit()
    print(mycursor.rowcount, "record inserted")
        