import base64
import hashlib

from cryptography.fernet import Fernet

# User Key
user_key = input("~~~ >_ Insert key to encrypt...    >  ")
user_key_encoded = user_key.encode('utf-8')

hash_object = hashlib.sha256(user_key_encoded)
hex_dig = hash_object.hexdigest()
base64_bytes = base64.urlsafe_b64encode(bytes.fromhex(hex_dig))
user_key_b64_encoded = base64_bytes[:32].decode('utf-8')

key = base64.urlsafe_b64encode(user_key_b64_encoded.encode('utf-8'))
cipher_suite = Fernet(key)

msg = input("~~~ >_ Insert the message to encrypt...    >  ")

encrypted_msg = cipher_suite.encrypt(msg.encode())
print(encrypted_msg)
