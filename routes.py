from flask import Flask, render_template, request, redirect, flash, url_for, session, logging, jsonify
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
import datetime
from flask_socketio import SocketIO
app = Flask(__name__)

#config mysql
# mysql://bc980892c23eac:1c6985af@us-cdbr-iron-east-02.cleardb.net/heroku_66591423b270015?reconnect=true
app.config['MYSQL_HOST'] = 'us-cdbr-iron-east-02.cleardb.net'
app.config['MYSQL_USER'] = 'b693543105bea1'
app.config['MYSQL_PASSWORD'] = 'e9b1bf91'
app.config['MYSQL_DB'] = 'heroku_b73dff108c0f588'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
socketio = SocketIO(app)
#init MySQL
mysql = MySQL(app)


#Question form class
class QuestionAnswerForm(Form):
	textBox = StringField('textBox', [validators.Length(min=1)])

class RegisterForm(Form):
	FirstName = StringField('FirstName', [validators.Length(min=1, max = 50)])
	LastName = StringField('LastName', [validators.Length(min=1, max=50)])
	Email = StringField('email', [validators.Length(min=1, max=50)])
	password = PasswordField('Password', 
	[
		validators.DataRequired(), 
		validators.EqualTo('confirm', message = 'Passwords do not match')
	
	])
	confirm = PasswordField('passwordAgain')

#index route

@app.route('/', methods=['GET'])
def index():
	return render_template('index.html')

#home route

@app.route('/home', methods=['GET', 'POST'])
def home():
	return render_template('home.html')

#User Login

@app.route('/login', methods = ['GET', 'POST'])
def login():
	if request.method == 'POST':
		#Get form fields
		email = request.form['email']
		password_candidate = request.form['password']

		#Create Cursor
		cur = mysql.connection.cursor()

		#Get user by email

		result = cur.execute("SELECT * FROM login WHERE Email = %s", [email])

		if result > 0:
			#Get stored hash
			data = cur.fetchone()
			password = data['Password']
			EmpType = data['EmpType']

			#compare passwords
			if sha256_crypt.verify(password_candidate, password):
				#password passed
				app.logger.info('PASSWORD MATCHED')
				session['logged_in'] = True
				session['email'] = email
				session['emptype'] = EmpType

				flash('You are now logged in', 'success')
				return redirect(url_for('home'))
			else:
				error = "Invalid Login"
				return render_template('login.html', error=error)

			#connection close
			cur.close()
		else:
			error = "Username not found"
			return render_template('login.html', error=error)
	return render_template('login.html')

#Register Route

@app.route('/register', methods=['GET','POST'])
def register():
	form = RegisterForm(request.form)
	if request.method == 'POST' and form.validate():
		FirstName = form.FirstName.data
		LastName = form.LastName.data
		email = form.Email.data
		password = sha256_crypt.encrypt(str(form.password.data))

		#create cursor
		cur = mysql.connection.cursor()
		cur.execute("INSERT INTO registration(FirstName, LastName, Email, Password, EmpType) VALUES(%s, %s, %s, %s, 'C')", (FirstName, LastName, email, password))

		#commit to DB
		mysql.connection.commit()

		cur.execute("INSERT INTO login(Email, Password, EmpType) VALUES(%s, %s, 'C')", (email, password))

		#commit to DB
		mysql.connection.commit()

		#close Connection

		cur.close()

		flash('You are now registered and can log in', 'success')
		return redirect(url_for('login'))
	return render_template('register.html', form=form)

#Logout Route

@app.route('/logout')
def logout():
	session.clear()
	flash('You are now logged out', 'success')
	return redirect(url_for('login'))

@app.route('/questions', methods =['GET', 'POST'])

def questions():
	if request.method == "POST":
		if 'Submit_Question' in request.form:
			#grabbing user question from form
			userQuestion = request.form['questionInp']
			today = datetime.date.today()
			#making a cursor for sql query
			cur = mysql.connection.cursor()
			cur.execute("INSERT INTO questions(question, Email, Date) VALUES(%s, %s, %s)", (userQuestion, session['email'], today))

			#commit to db
			mysql.connection.commit()

			#close connection
			cur.close()
			app.logger.info("You have successfully entered in a Question")
		else:
			app.logger.info("Something went wrong with the sql")
	if request.method == "POST":
		if 'Submit_Answer' in request.form:
			textAnswer = request.form['txt']
			ID = request.form['questionID']
			cur = mysql.connection.cursor()

			result = cur.execute("UPDATE questions SET answer = %s WHERE ID = %s", (textAnswer, ID))

			mysql.connection.commit()

			cur.close()
			app.logger.info("You have successfully entered in a Answer")
	if request.method == "POST":
		if 'Delete_Question' in request.form:
			ID = request.form['questionIDDelete']
			cur = mysql.connection.cursor()
			app.logger.info(ID)
			result = cur.execute("DELETE FROM questions WHERE ID = %s", (ID,))

			mysql.connection.commit()

			cur.close()
			app.logger.info("You have successfully deleted a question")
	cur = mysql.connection.cursor()

	result = cur.execute("SELECT * FROM questions ORDER BY ID DESC")
	questions = cur.fetchall()

	if result > 0:
		return render_template('questions.html', questions=questions)
	else:
		msg = "No Questions found"
		return render_template('questions.html', msg=msg)
	cur.close()

@app.route('/teachers', methods=['GET', 'POST'])
def teachers():
	cur = mysql.connection.cursor()

	result = cur.execute("SELECT * FROM teachers")
	data = cur.fetchall()

	if result > 0:
		return render_template('teachers.html', data = data)
	else:
		msg = "No Teachers Available"
		return render_template('teachers.html', msg=msg)
	cur.close()
@app.route('/users', methods=['GET', 'POST'])
def users():
	if request.method == "POST":
		app.logger.info(request.form['nameUser'])
		if 'deleteUser' in request.form:
			user = request.form['nameUser']
			cur = mysql.connection.cursor()
			result = cur.execute("DELETE FROM registration WHERE Email = %s", (user,))

			mysql.connection.commit()

			cur.close()
			app.logger.info("You have successfully deleted a question")
	cur = mysql.connection.cursor()

	result = cur.execute("SELECT * FROM registration")
	data = cur.fetchall()
	if result > 0:
		return render_template('users.html', data = data)
	else:
		msg = "No Users are Registered"
		return render_template('users.html', msg=msg)
@app.route('/chat', methods = ['GET', 'POST'])
def chat():
	return render_template('chat.html')
def messageReceived(methods=['GET','POST']):
	print('message was received')

@socketio.on('my event')
def handle_my_custom_event(json, methods=['GET', 'POST']):
	app.logger.info('received my event: '+ str(json))
	socketio.emit('my response', json, callback=messageReceived)

#main method
if __name__ == "__main__":
	app.secret_key= "secretstuff"
	# app.run(debug=True)
	socketio.run(app, debug=True)