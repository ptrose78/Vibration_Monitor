import socket
import json
import struct
import time

HOST = '127.0.0.1'
PORT = 12345

payload = {
    "asset_id": 1,
    "peak_frequency": 142.8,
    "rms_acceleration": 2.15,
    "health_score": 88.3
}

print(f"Connecting to LabVIEW on {HOST}:{PORT}...")
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
    print("Connected!")
    
    json_bytes = json.dumps(payload).encode('utf-8')
    header = struct.pack('!I', len(json_bytes))
    s.sendall(header + json_bytes)
    print("Data sent.")
    
    time.sleep(1)
    s.close()
except Exception as e:
    print(f"Failed: {e}")
