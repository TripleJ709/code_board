from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os
import pymysql

# 환경변수 로드
load_dotenv()

# Flask 앱 생성
app = Flask(__name__)
CORS(app)  # 모든 요청 허용

# MySQL 연결 설정
conn = pymysql.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD"),
    db=os.getenv("MYSQL_DB"),
    cursorclass=pymysql.cursors.DictCursor
)

# 사용자 목록 조회
@app.route("/users", methods=["GET"])
def get_users():
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM users")
        users = cursor.fetchall()
    return jsonify(users)

# 사용자 추가
@app.route("/users", methods=["POST"])
def add_user():
    data = request.get_json()
    with conn.cursor() as cursor:
        cursor.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (data["name"], data["email"]))
    conn.commit()
    return jsonify({"status": "ok"}), 201

# 서버 실행
if __name__ == "__main__":
    app.run(debug=True)
