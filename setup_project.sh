#!/bin/bash

# Define the project directory
PROJECT_DIR="flask_app"

# Create the project directory
mkdir -p $PROJECT_DIR

# Create the static and templates directories
mkdir -p $PROJECT_DIR/static
mkdir -p $PROJECT_DIR/templates

# Create the app.py file
cat <<EOF > $PROJECT_DIR/app.py
from flask import Flask, request, render_template, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class UserData(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    college = db.Column(db.String(100), nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    source = db.Column(db.String(50), nullable=False)
    purpose = db.Column(db.String(50), nullable=False)
    subject = db.Column(db.String(50), nullable=False)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        name = request.form['name']
        age = request.form['age']
        college = request.form['college']
        gender = request.form['gender']
        source = request.form['source']
        purpose = request.form['purpose']
        subject = request.form['subject']

        new_data = UserData(name=name, age=age, college=college,
                            gender=gender, source=source, purpose=purpose,
                            subject=subject)
        db.session.add(new_data)
        db.session.commit()
        return redirect(url_for('index'))

    return render_template('index.html')

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
EOF

# Create the index.html file
cat <<EOF > $PROJECT_DIR/templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Interview Room</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='styles.css') }}">
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1>Welcome to AI Interview Room</h1>
            <form method="POST">
                <label for="name">Please enter your name:</label>
                <input type="text" id="name" name="name" required>

                <label for="age">Please enter your age:</label>
                <input type="number" id="age" name="age" required>

                <label for="college">Enter your college name:</label>
                <input type="text" id="college" name="college" required>

                <label for="gender">Select your gender:</label>
                <select id="gender" name="gender">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>

                <label for="source">Select the Source:</label>
                <select id="source" name="source">
                    <option value="website">Website</option>
                    <option value="social_media">Social Media</option>
                    <option value="referral">Referral</option>
                </select>

                <label for="purpose">Select the purpose:</label>
                <select id="purpose" name="purpose">
                    <option value="career_advice">Career Advice</option>
                    <option value="job_search">Job Search</option>
                    <option value="networking">Networking</option>
                </select>

                <label for="subject">Select your interview subject:</label>
                <select id="subject" name="subject">
                    <option value="technology">Technology</option>
                    <option value="business">Business</option>
                    <option value="finance">Finance</option>
                </select>

                <button type="submit">Continue</button>
            </form>
        </div>
    </div>
</body>
</html>
EOF

# Create the styles.css file
cat <<EOF > $PROJECT_DIR/static/styles.css
body {
    background-image: url("AI-Room.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment: fixed;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    overflow: hidden; /* Prevent scrollbars from appearing */
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
    box-sizing: border-box;
}

.form-container {
    background: rgba(255, 255, 255, 0.2); /* Transparent white background */
    border-radius: 10px;
    backdrop-filter: blur(10px); /* Glassy effect */
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.3); /* Subtle border for glassy effect */
    box-sizing: border-box;
    width: 80vw; /* Width set to 80% of viewport width */
    height: 50vw; /* Height set to 50% of viewport width (maintains 50:80 ratio) */
    max-width: 1200px; /* Max width to ensure container doesn't become too large */
    max-height: 750px; /* Max height to maintain ratio with max-width */
    display: flex;
    flex-direction: column;
    justify-content: center; /* Center content vertically */
    text-align: center;
}

h1 {
    margin-bottom: 15px;
    font-size: 24px; /* Increased font size */
    color: #fff; /* White text color for contrast */
}

form {
    display: flex;
    flex-direction: column;
    align-items: center; /* Center align items horizontally */
}

label {
    margin: 5px 0 3px;
    color: #fff; /* White text color for labels */
    text-align: left;
    width: 100%; /* Full width for labels */
}

input[type="text"],
input[type="number"],
select,
button {
    width: calc(100% - 20px); /* Full width minus padding */
    padding: 10px;
    margin: 8px auto; /* Center horizontally */
    border: 1px solid rgba(255, 255, 255, 0.5); /* Semi-transparent border */
    border-radius: 3px;
    background: rgba(255, 255, 255, 0.2); /* Light background for input fields */
    color: #000; /* Dark text color for input fields for readability */
    box-sizing: border-box;
}

button {
    width: 120px; /* Adjust width to maintain the ratio */
    height: 60px; /* Adjust height to maintain the ratio */
    background-color: #4CAF50;
    color: white;
    padding: 0; /* Remove padding to keep the size consistent */
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 16px; /* Font size to ensure text fits */
    transition: background-color 0.3s ease;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-sizing: border-box;
}

button:hover {
    background-color: #45a049;
}
EOF

# Create the requirements.txt file
cat <<EOF > $PROJECT_DIR/requirements.txt
Flask==2.3.2
Flask-SQLAlchemy==3.0.0
EOF

# Create the Dockerfile
cat <<EOF > $PROJECT_DIR/Dockerfile
# Use the official Python image from the Docker Hub
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose port 5000
EXPOSE 5000

# Run the Flask application
CMD ["flask", "run"]
EOF

# Provide instructions
echo "Project structure created successfully!"
echo "To build and run your Docker container, navigate to the project directory and run:"
echo "docker build -t flask_app ."
echo "docker run -p 5000:5000 flask_app"
echo "To start your Flask application without Docker, navigate to the project directory and run:"
echo "python app.py"
