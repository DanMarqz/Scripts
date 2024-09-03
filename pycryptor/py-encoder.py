import base64
import hashlib

msg = input("~~~>_ Insert your text to encrypt... ")
msg_encoded = msg.encode('utf-8')

hash_object = hashlib.sha256(msg_encoded)
hex_dig = hash_object.hexdigest()

base64_bytes = base64.urlsafe_b64encode(bytes.fromhex(hex_dig))

msg_b64_encoded = base64_bytes[:32].decode('utf-8')

print(f"~~~>_ This is your text encrypted: {msg_b64_encoded.encode('utf-8')}")
#return msg_b64_encoded

