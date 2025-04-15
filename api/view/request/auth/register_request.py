from pydantic import Field, BaseModel, EmailStr, field_validator
import re


class RegisterRequest(BaseModel):
    full_name:str=Field(
        ...,
        title='User Full Name',
        description='User full name to be registered in the system. It will be used to represent user in the client side.',
        examples=['John Doe'],
        strict=True
    )
    email:EmailStr=Field(
        ...,
        title="User Email",
        description="User's valid email address for registration and communication.",
        examples=["user@example.com"],
        strict=True,
    )
    password:str=Field(
        ...,
        title='User Password',
        description='Secret phrase used by user to access his account later on the system.',
        examples=['Secr3t_Pa$sw0rD'],
        strict=True
    )

    @field_validator('password', mode='before')
    def password_validator(cls, value:str)->str:
        # validate password strength
        if len(value) < 8:
            raise ValueError('Password is too short.')
        # validate contains alphabet
        alpha_pattern:str=r'[a-zA-Z]'
        if not re.search(alpha_pattern, value):
            raise ValueError('Password must contain alphabet')
        # validate at least contains one Capital letter
        capital_pattern:str=r'[A-Z]'
        if not re.search(capital_pattern, value):
            raise ValueError('Password must contain \'Upper Case Letter\'')
        # validate contains numbers
        num_pattern:str=r'[0-9]'
        if not re.search(num_pattern, value):
            raise ValueError('Password must contain numbers')
        # validate contains at least 2 digits
        dig_pattern:str=r'(?:.*\d.*\d)'
        if not re.search(dig_pattern, value):
            raise ValueError('Password must contain at least 2 numbers')
        # validate contains special
        special_pattern:str=r'[!@#$%^&*()_+\-=\[\]{};\'":\\|,.<>\/?`~]'
        if not re.search(special_pattern, value):
            raise ValueError('Password must contain a valid special characters.')
        return value