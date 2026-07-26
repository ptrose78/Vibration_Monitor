import socket
import json
import struct
import numpy as np
import traceback

HOST = '127.0.0.1'
PORT = 12345

print(f"Starting Diagnostic Coprocessor Server on {HOST}:{PORT}...")
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((HOST, PORT))
server_socket.listen(1)

print("Awaiting connection from LabVIEW Simulation Engine...")
conn, addr = server_socket.accept()
print(f"Connected to LabVIEW at {addr}")

iteration = 1

try:
    while True:
        # 1. Read the 4-byte big-endian header length from LabVIEW
        header = conn.recv(4)
        print(f"\n[DEBUG] Raw 4-byte header received from LabVIEW: {header}")
        
        if not header:
            print("[SIGNAL] LabVIEW sent exactly 0 bytes. The remote socket closed cleanly via 'if not header'.")
            break
            
        if len(header) < 4:
            print(f"[SIGNAL] Truncated header size: {len(header)} bytes. Closing link.")
            break
            
        payload_length = struct.unpack('!I', header)[0]
        print(f"[DEBUG] Header Unpacked -> Python is now expecting exactly {payload_length} bytes of JSON data.")
        
        # 2. Retrieve the full JSON string payload
        data_bytes = b""
        while len(data_bytes) < payload_length:
            packet = conn.recv(payload_length - len(data_bytes))
            if not packet:
                print("[SIGNAL] Socket stream cut off abruptly mid-transmission.")
                break
            data_bytes += packet
            
        if len(data_bytes) < payload_length:
            print(f"[ERROR] Expected {payload_length} bytes, but only managed to harvest {len(data_bytes)} bytes before stream failure.")
            break
            
        print(f"[DEBUG] Success. Received {len(data_bytes)} bytes. Passing to JSON parser.")

        # 3. Parse the unified payload object from LabVIEW
        decoded_string = data_bytes.decode('utf-8')
        
        # === ADD THESE TWO LINES FOR EXACT VISIBILITY ===
        print(f"[DIAGNOSTIC] Total String Length: {len(decoded_string)} characters")
        print(f"[DIAGNOSTIC] String Tail End looks exactly like: '{decoded_string[-25:]}'")
        # ===============================================

        raw_payload = json.loads(decoded_string)

        raw_payload = json.loads(data_bytes.decode('utf-8'))
        
        # Dynamically extract the sample rate (fallback to 2000.0 if key is missing)
        sample_rate = float(raw_payload.get('sample_rate', 2000.0))
        print(f"[DEBUG] Operational Scale -> Active Sample Rate: {sample_rate} Hz")
        
        # Extract the raw matrix data from its key
        raw_matrix = raw_payload.get('matrix', [])
        
        # Convert to NumPy array
        matrix = np.array(raw_matrix)

        # === ADD AN ENGINEERING SAFETY NET ===
        if matrix.size == 0:
            print(f"[WARNING] Frame {iteration} arrived with an empty Matrix array! Skipping math analysis.")
            iteration += 1
            continue
        # ======================================

        # Standardize matrix for multi-channel vs single-channel shapes
        if matrix.ndim == 1:
            matrix = np.expand_dims(matrix, axis=0)
            
        # 4. Perform live engineering math across ALL available channels
        channels_telemetry = []
        
        for idx, channel_data in enumerate(matrix):
            # Calculate True RMS Acceleration
            rms_accel = float(np.sqrt(np.mean(np.square(channel_data))))
            
            # Calculate Dominant Peak Frequency via Fast Fourier Transform (FFT)
            fft_values = np.abs(np.fft.rfft(channel_data))
            fft_freqs = np.fft.rfftfreq(len(channel_data), d=1.0/sample_rate)
            peak_freq = float(fft_freqs[np.argmax(fft_values)])
            
            # Calculate an asset health score based on operational safety thresholds
            if rms_accel > 2.0:
                health_score = max(0.0, 100.0 - (rms_accel * 12.0)) # Critical degradation path
            else:
                health_score = 100.0 - (rms_accel * 2.0) # Nominal wear path
                
            # Append this specific channel's metrics to our collection
            channels_telemetry.append({
                "channel_id": idx + 1,  # 1-indexed for clear engineering alignment
                "peak_frequency": round(peak_freq, 2),
                "rms_acceleration": round(rms_accel, 2),
                "health_score": round(health_score, 1)
            })
            
            # Define a fixed, static identifier for the actual machinery asset under test
            TARGET_ASSET_ID = 1  

        # 5. Build the strict nested response payload cluster
        response_payload = {
            "asset_id": TARGET_ASSET_ID,    # Remains constant (e.g., 1)
            "frame_id": iteration,          # Tracks the dynamic sequence count
            "channels": channels_telemetry
        }
        
        # 6. Serialize and transmit back to LabVIEW with a 4-byte Big-Endian prefix
        response_json = json.dumps(response_payload).encode('utf-8')
        response_header = struct.pack('!I', len(response_json))
        full_packet = response_header + response_json
        
        import datetime
        timestamp_str = datetime.datetime.now().strftime("%H:%M:%S.%f")[:-3]
        
        print(f"[{timestamp_str}] [TX DIAGNOSTIC] Preparing response packet:")
        print(f"    -> Header Bytes (Hex): {response_header.hex()}")
        print(f"    -> Payload Size:       {len(response_json)} bytes")
        print(f"    -> Total Packet Size:  {len(full_packet)} bytes")
        print(f"    -> Raw JSON Segment:   {response_json[:180].decode('utf-8')}...")

        try:
            # Attempt execution down the network stack
            conn.sendall(full_packet)
            
            post_tx_time = datetime.datetime.now().strftime("%H:%M:%S.%f")[:-3]
            print(f"[{post_tx_time}] [TX SUCCESS] Operating system accepted all {len(full_packet)} bytes.")
            
        except socket.error as sock_err:
            error_time = datetime.datetime.now().strftime("%H:%M:%S.%f")[:-3]
            print(f"[{error_time}] !!! TRANSMISSION FAILURE AT OS LAYER !!!")
            print(f"    -> Socket Error Details: {sock_err}")
            raise sock_err
            
        print(f"[SUCCESS] Processed Frame {iteration} -> Total Channels Handled: {len(channels_telemetry)}")
        
        iteration += 1

except Exception as e:
    print("\n!!! CRITICAL PYTHON SERVER RUNTIME CRASH !!!")
    traceback.print_exc()  # Prints the file name, line number, and error type
finally:
    conn.close()
    server_socket.close()
    print("\nSocket links cleanly torn down. Listening loop killed.")