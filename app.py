from flask import Flask,jsonify

app = Flask(__name__)

@app.route('/hello')
def home():
    return "Hello World",200
@app.route('/error')
def error():
    app.logger.error('This is an error message')
    return jsonify({'error': 'This is an error message'}),400

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)
