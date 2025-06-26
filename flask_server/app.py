from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os
import pymysql
import bcrypt

load_dotenv()

app = Flask(__name__)
CORS(app)

conn = pymysql.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD"),
    db=os.getenv("MYSQL_DB"),
    cursorclass=pymysql.cursors.DictCursor
)

# 이메일 중복 확인 API
@app.route("/check_email", methods=["POST"])
def check_email():
    data = request.get_json()
    email = data.get("email")

    if not email:
        return jsonify({"error": "이메일을 입력하세요"}), 400

    with conn.cursor() as cursor:
        cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
        result = cursor.fetchone()

    if result:
        return jsonify({"exists": True, "message": "이미 존재하는 이메일입니다"}), 200
    else:
        return jsonify({"exists": False, "message": "사용 가능한 이메일입니다"}), 200
        
# 회원가입 API
@app.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")

    if not name or not email or not password:
        return jsonify({"error": "모든 필드를 입력하세요"}), 400

    hashed_pw = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())

    try:
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO users (name, email, password) VALUES (%s, %s, %s)",
                           (name, email, hashed_pw.decode("utf-8")))
        conn.commit()
        return jsonify({"message": "회원가입 성공"}), 201
    except pymysql.err.IntegrityError:
        return jsonify({"error": "이미 존재하는 이메일입니다"}), 409


# 로그인 API
@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "이메일과 비밀번호를 입력하세요"}), 400

    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password.encode("utf-8"), user["password"].encode("utf-8")):
            return jsonify({"message": "로그인 성공", "user": {
                "id": user["id"],
                "name": user["name"],
                "email": user["email"]
            }}), 200
        else:
            return jsonify({"error": "이메일 또는 비밀번호가 올바르지 않습니다"}), 401


# 전체 사용자 조회 (비번 제외)
@app.route("/users", methods=["GET"])
def get_users():
    with conn.cursor() as cursor:
        cursor.execute("SELECT id, name, email, created_at FROM users")
        users = cursor.fetchall()
    return jsonify(users)
    
# 전체 게시글 조회(가져오기)
@app.route("/posts", methods=["GET"])
def get_posts():
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT 
                posts.id,
                posts.title,
                posts.content,
                posts.user_id,
                users.name,
                posts.created_at,
                posts.is_deleted
            FROM posts
            JOIN users ON posts.user_id = users.id
            ORDER BY posts.created_at DESC
        """)
        posts = cursor.fetchall()
    return jsonify(posts), 200


# 서버 실행
if __name__ == "__main__":
    app.run(debug=True)
