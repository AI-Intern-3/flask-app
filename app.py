from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Process form data here
        name = request.form['name']
        age = request.form['age']
        college_name = request.form['college_name']
        gender = request.form['gender']
        source = request.form['source']
        purpose = request.form['purpose']
        subject = request.form['subject']
        # You can return the data, store it in a database, etc.
        return f"Hello, {name}. Your form is submitted successfully!"

    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
