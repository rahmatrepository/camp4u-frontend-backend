import sqlite3
from typing import List, Optional
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import mysql.connector

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:8080",
    "http://localhost:3000",
    "http://127.0.0.1:8000",
    "http://127.0.0.1:5500",
    "*"  # Allowing all origins for development
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
    expose_headers=["*"]
)

@app.middleware("http")
async def add_cors_headers(request, call_next):
    response = await call_next(request)
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization"
    return response

def get_db_connection():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="camp4u_db"
    )
    return conn

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/home")
def home():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)  # agar hasil berupa dict
        cursor.execute("SELECT * FROM categories")  # <-- execute via cursor
        categories = cursor.fetchall()
        cursor.close()
        conn.close()
        return {"categories": categories}
    except Exception as e:
        print("ERROR:", str(e))
        return {"error": str(e)}



@app.post("/product")
def create_product(name: str, category_id: int, price_per_day: float):
    conn = get_db_connection()
    conn.execute(
        "INSERT INTO products (name, category_id, price_per_day) VALUES (?, ?, ?)",
        (name, category_id, price_per_day),
    )
    conn.commit()
    conn.close()
    return {"message": "Product added to the database"}

@app.post("/product-detail")
def create_product_detail(product_id: int, description: str):
    conn = get_db_connection()
    conn.execute(
        "UPDATE products SET description = ? WHERE id = ?",
        (description, product_id),
    )
    conn.commit()
    conn.close()
    return {"message": "Product detail added to the database"}

@app.get("/ulasan")
def get_ulasan():
    conn = get_db_connection()
    reviews = conn.execute("SELECT * FROM reviews").fetchall()
    conn.close()
    return {"reviews": [dict(review) for review in reviews]}

@app.post("/registration")
def register_user(username: str, email: str, password_hash: str):
    conn = get_db_connection()
    conn.execute(
        "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)",
        (username, email, password_hash),
    )
    conn.commit()
    conn.close()
    return {"message": "User registered successfully"}

@app.get("/login")
def login(username: str):
    conn = get_db_connection()
    user = conn.execute("SELECT * FROM users WHERE username = ?", (username,)).fetchone()
    conn.close()
    if user:
        return {"user_data": dict(user)}
    return {"error": "User not found"}

@app.post("/cart")
def add_to_cart(user_id: int, product_id: int, quantity: int):
    conn = get_db_connection()
    conn.execute(
        "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)",
        (user_id, product_id, quantity),
    )
    conn.commit()
    conn.close()
    return {"message": "Item added to cart"}

@app.put("/cart")
def update_cart(cart_id: int, quantity: int):
    conn = get_db_connection()
    conn.execute(
        "UPDATE cart SET quantity = ? WHERE id = ?",
        (quantity, cart_id),
    )
    conn.commit()
    conn.close()
    return {"message": "Cart updated"}

@app.patch("/cart")
def modify_cart(cart_id: int, quantity: Optional[int] = None):
    conn = get_db_connection()
    if quantity is not None:
        conn.execute(
            "UPDATE cart SET quantity = ? WHERE id = ?",
            (quantity, cart_id),
        )
    conn.commit()
    conn.close()
    return {"message": "Cart modified"}

@app.post("/booking")
def create_booking():
    return {"message": "Booking created successfully"}

@app.get("/transfer")
def get_transfer():
    return {"transfer_details": "Transfer details fetched from the database"}

@app.patch("/transfer")
def update_transfer():
    return {"message": "Transfer details updated"}

@app.post("/bukti-transfer")
def upload_bukti_transfer():
    return {"message": "Transfer proof uploaded successfully"}

@app.get("/cod")
def get_cod():
    return {"cod_details": "COD details fetched from the database"}

@app.post("/qris")
def create_qris():
    return {"message": "QRIS payment created successfully"}

@app.get("/pembayaran-berhasil")
def get_payment_success():
    return {"payment_details": "Payment success details fetched from the database"}

@app.patch("/profil")
def update_profile():
    return {"message": "Profile updated successfully"}

@app.get("/profil")
def get_profile():
    return {"profile": "User profile and rental history fetched from the database"}

@app.post("/tulis-ulasan")
def write_review():
    return {"message": "Review submitted successfully"}

@app.get("/panduan")
def get_guide():
    return {"guides": "Guides and FAQs fetched from the database"}

@app.post("/chat")
def send_chat():
    return {"message": "Chat message sent successfully"}

@app.post("/notifikasi")
def create_notification():
    return {"message": "Notification created successfully"}

@app.get("/notifikasi")
def get_notification():
    return {"notifications": "Notifications fetched from the database"}
@app.get("/cek-koneksi")
def cek_koneksi():
    try:
        conn = get_db_connection()
        conn.execute("SELECT 1")  # Query ringan untuk memastikan terkoneksi
        conn.close()
        return {"status": "Berhasil terhubung ke database"}
    except Exception as e:
        return {"status": "Gagal terhubung ke database", "error": str(e)}
