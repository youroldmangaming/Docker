import bcrypt

password = input("Enter password: ").encode('utf-8')
hashed = bcrypt.hashpw(password, bcrypt.gensalt())
print("Generated bcrypt hash: ", hashed.decode('utf-8'))
