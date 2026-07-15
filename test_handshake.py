import socket
import json
import struct
import time
import random  # Added to simulate live changing variables

HOST = '127.0.0.1'
PORT = 12345

print(f"Connecting to LabVIEW on {HOST}:{PORT}...")
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
    print("Connected! Streaming live data... Press Ctrl+C to stop.")
    
    # Simple loop counter for the asset ID or iteration tracker
    iteration = 1
    
    while True:
        # Generate dynamic, changing data so you can see the LabVIEW gauges/indicators move
        payload = {
            "asset_id": iteration,
            "peak_frequency": round(random.uniform(100.0, 200.0), 2),
            "rms_acceleration": round(random.uniform(0.5, 4.5), 2),
            "health_score": round(random.uniform(75.0, 100.0), 1)
        }
        
        # Package and serialize the JSON payload
        json_bytes = json.dumps(payload).encode('utf-8')
        header = struct.pack('!I', len(json_bytes))
        
        # Transmit across the open socket link
        s.sendall(header + json_bytes)
        print(f"Sent packet {iteration}: {payload}")
        
        iteration += 1
        time.sleep(0.5)  # Wait half a second between updates (2 Hz stream)

except KeyboardInterrupt:
    print("\nStreaming stopped by user.")
except Exception as e:
    print(f"Failed: {e}")
finally:
    try:
        s.close()
        print("Socket connection cleanly closed.")
    except:
        pass