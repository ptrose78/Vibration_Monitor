import socket
import json
import struct

HOST = '127.0.0.1'  # Localhost
PORT = 12345        # Arbitrary non-privileged port

def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # Allow instant socket reuse on restart without "Address already in use" errors
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind((HOST, PORT))
    server_socket.listen(1)
    print(f"[*] Python engine listening on {HOST}:{PORT}...")

    conn, addr = server_socket.accept()
    print(f"[*] Connected to LabVIEW at {addr}")

    try:
        while True:
            # 1. Read the 4-byte length prefix (U32, Big-Endian)
            header = conn.recv(4)
            if not header:
                print("[*] Connection closed by LabVIEW.")
                break
            
            # Unpack the 4-byte header to get the exact message length
            msg_len = struct.unpack('>I', header)[0]
            
            # 2. Read the actual JSON payload based on that length
            data_bytes = bytearray()
            while len(data_bytes) < msg_len:
                packet = conn.recv(msg_len - len(data_bytes))
                if not packet:
                    raise ConnectionError("Socket connection broken while receiving payload.")
                data_bytes.extend(packet)
            
            # 3. Decode and parse the JSON
            payload = json.loads(data_bytes.decode('utf-8'))
            print(f"[Recv] Latency test payload. Type: {payload.get('Type')}")

            # 4. Create a response payload
            response = {
                "Status": "READY",
                "Received_samples": len(payload.get("Data", [])),
                "Message": "Handshake intact."
            }
            
            # 5. Serialize, calculate length, and send back to LabVIEW
            response_bytes = json.dumps(response).encode('utf-8')
            response_header = struct.pack('>I', len(response_bytes))
            
            conn.sendall(response_header + response_bytes)

    except Exception as e:
        print(f"[Error] {e}")
    finally:
        conn.close()
        server_socket.close()
        print("[*] Server shutdown.")

if __name__ == "__main__":
    start_server()