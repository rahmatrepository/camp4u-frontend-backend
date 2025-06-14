from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date

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
    date_of_birth: Optional[date] = None
    gender: Optional[str] = None  # validasi enum bisa ditambahkan
