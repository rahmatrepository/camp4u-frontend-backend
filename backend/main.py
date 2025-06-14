from binascii import Error
import sqlite3
from typing import List, Optional
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import mysql.connector
from mysql.connector.cursor import MySQLCursor
from decimal import Decimal
from pydantic import BaseModel
from datetime import date, datetime, timedelta
import jwt
from passlib.context import CryptContext
from pydantic import BaseModel, EmailStr

# Password hashing configuration
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# JWT configuration
SECRET_KEY = "your-secret-key-here"  # Change this to a secure secret key
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str  # ini akan di-hash, bukan langsung disimpan
    full_name: Optional[str] = None
    phone_number: Optional[str] = None
    profile_picture: Optional[str] = None
    address: Optional[str] = None
    city: Optional[str] = None
    province: Optional[str] = None
    postal_code: Optional[str] = None
    date_of_birth: Optional[date] = None # date dari datetime
    gender: Optional[str] = None  # validasi enum bisa ditambahkan

class UserLogin(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

app = FastAPI()

# Configure CORS
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

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=401,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except jwt.JWTError:
        raise credentials_exception

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if user is None:
        raise credentials_exception
    return user

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
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM categories")
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

@app.get("/category/{category_id}/products")
def get_products_by_category(category_id: int):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Get basic product info for category listing
        cursor.execute("""
            SELECT 
                p.id, p.category_id, p.name, p.brand,
                p.condition_rating, p.price_per_day, p.deposit_amount,
                p.stock_quantity
            FROM products p
            WHERE p.category_id = %s
            ORDER BY p.name
        """, (category_id,))
        
        products = cursor.fetchall()
        
        for product in products:
            # Get only primary image for listing
            cursor.execute("""
                SELECT image_url 
                FROM product_images 
                WHERE product_id = %s AND is_primary = 1
                LIMIT 1
            """, (product['id'],))
            
            primary_image = cursor.fetchone()
            if primary_image:
                product['imageUrl'] = 'assets/images/products/' + primary_image['image_url']
            else:
                product['imageUrl'] = 'assets/images/products/default.png'
            
            # Convert decimal values
            if 'price_per_day' in product:
                product['price_per_day'] = float(product['price_per_day'])
            if 'deposit_amount' in product:
                product['deposit_amount'] = float(product['deposit_amount']) if product['deposit_amount'] else None
            if 'condition_rating' in product:
                product['condition_rating'] = float(product['condition_rating']) if product['condition_rating'] else None
        
        cursor.close()
        conn.close()
        return {"products": products}
    except Exception as e:
        print("ERROR:", str(e))
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/products/{product_id}")
def get_product_detail(product_id: int):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Get detailed product info
        cursor.execute("""
            SELECT 
                p.id, p.category_id, p.name, p.description, p.brand,
                p.condition_rating, p.price_per_day, p.deposit_amount,
                p.stock_quantity, p.specifications, p.weight,
                p.dimensions, p.rental_terms
            FROM products p
            WHERE p.id = %s
        """, (product_id,))
        
        product = cursor.fetchone()
        if not product:
            raise HTTPException(status_code=404, detail="Product not found")
            
        # Get all product images
        cursor.execute("""
            SELECT image_url, is_primary
            FROM product_images 
            WHERE product_id = %s 
            ORDER BY is_primary DESC
        """, (product_id,))
        
        images = cursor.fetchall()
        if images:
            product['images'] = ['assets/images/products/' + img['image_url'] for img in images]
            primary_image = next((img['image_url'] for img in images if img['is_primary'] == 1), images[0]['image_url'])
            product['imageUrl'] = 'assets/images/products/' + primary_image
        else:
            product['images'] = ['assets/images/products/default.png']
            product['imageUrl'] = 'assets/images/products/default.png'
        
        # Convert decimal values
        if 'price_per_day' in product:
            product['price_per_day'] = float(product['price_per_day'])
        if 'deposit_amount' in product:
            product['deposit_amount'] = float(product['deposit_amount']) if product['deposit_amount'] else None
        if 'condition_rating' in product:
            product['condition_rating'] = float(product['condition_rating']) if product['condition_rating'] else None
        if 'weight' in product:
            product['weight'] = float(product['weight']) if product['weight'] else None
        
        cursor.close()
        conn.close()
        return {"product": product}
    except HTTPException as he:
        raise he
    except Exception as e:
        print("ERROR:", str(e))
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/register", response_model=Token)
async def register(user: UserCreate):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Check if username exists
    cursor.execute("SELECT username FROM users WHERE username = %s", (user.username,))
    if cursor.fetchone():
        raise HTTPException(status_code=400, detail="Username already registered")
    
    # Check if email exists
    cursor.execute("SELECT email FROM users WHERE email = %s", (user.email,))
    if cursor.fetchone():
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Hash the password
    hashed_password = get_password_hash(user.password)
    
    # Insert new user
    cursor.execute(
        """INSERT INTO users (username, email, password_hash, full_name, phone_number) 
           VALUES (%s, %s, %s, %s, %s)""",
        (user.username, user.email, hashed_password, user.full_name, user.phone_number)
    )
    conn.commit()
    
    # Create access token
    access_token = create_access_token(data={"sub": user.username})
    
    cursor.close()
    conn.close()
    
    return {"access_token": access_token, "token_type": "bearer"}

@app.post("/token", response_model=Token)
async def login(form_data: UserLogin):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute(
        "SELECT * FROM users WHERE username = %s",
        (form_data.username,)
    )
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if not user or not verify_password(form_data.password, user["password_hash"]):
        raise HTTPException(
            status_code=401,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    access_token = create_access_token(data={"sub": user["username"]})
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/me")
async def read_users_me(current_user = Depends(get_current_user)):
    return current_user

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str):
    return pwd_context.hash(password)

@app.post("/auth/register", status_code=201)
def register_user(user: UserCreate):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Cek apakah email atau username sudah terdaftar
        cursor.execute("SELECT id FROM users WHERE email = %s OR username = %s", (user.email, user.username))
        existing_user = cursor.fetchone()
        if existing_user:
            raise HTTPException(status_code=400, detail="Email atau username sudah terdaftar.")

        # Hash password
        hashed_password = hash_password(user.password)

        # Simpan user ke database
        insert_query = """
            INSERT INTO users (
                username, email, password_hash, full_name, phone_number, 
                profile_picture, address, city, province, postal_code, 
                date_of_birth, gender, created_at, updated_at
            ) VALUES (
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s
            )
        """
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        cursor.execute(insert_query, (
            user.username, user.email, hashed_password, user.full_name, user.phone_number,
            user.profile_picture, user.address, user.city, user.province, user.postal_code,
            user.date_of_birth, user.gender, now, now
        ))

        conn.commit()
        user_id = cursor.lastrowid
        cursor.close()
        conn.close()

        return {"message": "User registered successfully", "user_id": user_id}

    except Error as e:
        raise HTTPException(status_code=500, detail=str(e))
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
# Asumsi ini ada di file Anda
# from .auth_utils import authenticate_user, create_access_token
# from .config import ACCESS_TOKEN_EXPIRE_MINUTES

router = APIRouter() # Jika Anda menggunakan APIRouter

# Jika Anda tidak menggunakan router, langsung gunakan @app.post
@app.post("/auth/login") # Atau @app.post("/auth/login")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer", "username": user.username, "full_name": user.full_name, "email": user.email, "phone_number": user.phone_number, "id": user.id, "created_at": user.created_at, "updated_at": user.updated_at, "profile_picture": user.profile_picture, "address": user.address, "city": user.city, "province": user.province, "postal_code": user.postal_code, "date_of_birth": user.date_of_birth, "gender": user.gender} # Sertakan semua data pengguna yang diperlukan