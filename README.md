# Vibration Monitor — Continuous Condition Monitoring System

An industrial-grade, multi-threaded condition monitoring system built with a **LabVIEW Queued Message Handler (QMH)** architecture, an **asynchronous Python diagnostic coprocessor**, and a **batched SQLite telemetry & error logging engine**.

Designed for high-speed vibration acquisition, real-time spectral feature extraction, automated fault detection, and resilient networked diagnostics.

---

## 📸 System Overview & Architecture

The system segregates data acquisition, digital signal processing, local user interface rendering, external network coprocessing, and persistent data logging into decoupled parallel loops to protect hardware timing from software latency.

```text
               ┌──────────────────────────────────────────────┐
               │         NI DAQmx / Hardware Acquisition       │
               └──────────────────────┬───────────────────────┘
                                      │ (25.6 kHz / Multi-Channel)
                                      ▼
               ┌──────────────────────────────────────────────┐
               │           Acquisition Message Loop           │
               └─────────┬──────────────────────────┬─────────┘
                         │                          │
   (Raw Data / Waveforms)│                          │(1 Hz FFT / Feature Extracted)
                         ▼                          ▼
   ┌──────────────────────────┐        ┌──────────────────────────┐
   │    Graph / UI Loop       │        │     TCP Message Loop     │
   │  (Decimated Rendering)   │        │   (Non-Blocking Client)  │
   └──────────────────────────┘        └────────────┬─────────────┘
                                                    │
                                                    │ (TCP / Port 12345)
                                                    ▼
                                       ┌──────────────────────────┐
                                       │ Python Diagnostics Engine│
                                       │ (JSON Health Metrics)    │
                                       └────────────┬─────────────┘
                                                    │
                                                    │ (Telemetry & Fault Payload)
                                                    ▼
                                       ┌──────────────────────────┐
                                       │   Database Message Loop  │
                                       │ (Batched SQLite Engine)  │
                                       └──────────────────────────┘
```
## 🔑 Key Features

* **High-Speed Multi-Channel Data Acquisition:** Processes multi-channel accelerometer signals at 25.6 kHz sampling rates with 1 Hz frequency resolution for real-time FFT spectrum analysis.
* **Non-Blocking Coprocessor Communication:** Asynchronous TCP client communicating via structured binary headers and JSON payloads with an external Python diagnostic server (`127.0.0.1:12345`).
* **Resilient SQLite Telemetry Engine:** Optimized database engine with parameterized string escaping and batched transaction commits to eliminate disk I/O bottlenecks during sub-second logging updates.
* **Latching Error Filtering & Network Recovery:** Edge-triggered state-latching suppresses error flooding during network disconnects while automatically purging socket queue backlogs upon reconnection.
* **Decimated UI Rendering Pipeline:** Decimated Front Panel graph loop (10:1 iteration reduction) and optimized 1-second rolling history buffers to prevent memory allocation overflows and rendering backlogs.
* **Synchronous Fault Shutdown Sequencing:** Reentrant error handler (`Check Loop Error.vi`) ensures critical hardware faults (e.g., DAQmx Error `-87`) are committed to SQLite before global shutdown commands tear down system threads.

---

## 🛠 Tech Stack & Dependencies

| Component | Technology / Library | Purpose |
| :--- | :--- | :--- |
| **Data Acquisition** | LabVIEW (NI DAQmx) | High-speed multi-channel vibration sampling |
| **Architecture** | Queued Message Handler (QMH) | Asynchronous parallel execution loops |
| **Coprocessor** | Python 3.x (`socket`, `json`) | Edge diagnostic health scoring & metric calculation |
| **Database** | SQLite 3 (`SQLite3.dll` / LV SQLite Tools) | Local telemetry & event log persistence |
| **Storage Formats** | SQLite, TDMS | Real-time logging & binary raw file archiving |

---

## 📂 Directory Structure

The repository is modularized using library-first encapsulation to prevent workspace path collisions and Git tracking errors. The physical directory structure is organized as follows:

* **`Acquisition/`:** Contains `Acquisition.lvlib`, hardware configuration TypeDefs, and the primary data collection QMH loops.
* **`Controls/`:** Stores all globally utilized custom controls and enumerations.
* **`Data Logging/`:** Manages the modules and `.lvlib` responsible for writing, formatting, and archiving raw high-speed telemetry (e.g., binary TDMS file generation).
* **`Database/`:** Houses the `.lvlib` responsible for executing SQL schemas to log telemetry and edge diagnostic scores into the local SQLite database.
* **`Documentation/`:** Contains project reference materials, architectural diagrams, and supplementary documentation outside of the main README.
* **`Python/`:** Contains the asynchronous Python scripts used for testing and diagnostics, specifically `engine_scratchpad.py` and `test_handshake.py`.
* **`Scripts/`:** Contains Python package management tools and environment executables, such as `pip.exe`, `f2py.exe`, and `numpy-config.exe`.
* **`Support/`:** Holds generalized subVIs, error handlers, and utility functions that are shared as dependencies across multiple project libraries.
* **`TCP/`:** Manages the LabVIEW-to-Python network bridge, containing `TCP.lvlib`, `TCP Message Loop.vi`, `Get Telemetry Data.vi`, and the associated `TCP State Data.ctl` typedef.

**Root-Level Application Files:**

* **`config.ini`:** The initialization file for establishing static system configurations (e.g., network ports, file paths) at runtime.
* **`Main.vi`:** The top-level application executable that launches and orchestrates all decoupled parallel loops.
* **`Vibration_Monitor.lvproj`:** The master LabVIEW project environment file that maps and tracks all physical dependencies.
* **`.gitignore` / `.Vibration_Monitor.UserState`:** Git and LabVIEW environment tracking files ensuring local IDE states and compiled object caches remain untracked.

---

## 🔬 Signal Processing & Diagnostic Mechanics

### 1. Spectral Scaling & Windowing

To convert raw discrete time-domain signals $x[n]$ into physical spectral units, the system applies the following processing steps:

**Windowing:** A Hanning window is applied in the time domain to suppress spectral leakage caused by non-integer period truncation:

$$
w[n] = 0.5 - 0.5 \cos\left(\frac{2\pi n}{N-1}\right)
$$

**Auto Power Spectrum:** `Auto Power Spectrum.vi` converts time-domain arrays into single-sided power-spectrum magnitude arrays in $\text{V}^2\text{ RMS}$ or $g^2\text{ RMS}$.

**Linear Peak Acceleration Conversion:** Power-spectrum output arrays are converted to Peak Acceleration ($g\text{ Peak}$) so spectral harmonic heights align directly with time-domain waveform peaks:

$$
Peak Acceleration (g) = √(Power Spectrum Output) × √2
$$

### 2. Time-Domain Velocity Integration

To evaluate machine severity against standard vibration criteria, acceleration signals in $g$ are digitally integrated using trapezoidal numerical summation and converted to **RMS Velocity** $\text{(in/s)}$:

$$v_{\text{RMS}} = \sqrt{\frac{1}{N} \sum_{k=1}^{N} \left( 386.088 \times \int a(t)dt \right)^2}$$

---

## 📡 Network Protocol & Payload Specifications

Communication between the **LabVIEW TCP Message Loop** and the **Python Diagnostic Coprocessor** uses a **4-byte Big-Endian Length-Prefixed Frame Structure**:


### Frame Structure

| Component | Size | Description |
|---|---:|---|
| Header | 4 bytes | Unsigned 32-bit integer (`UInt32`) containing the payload length |
| Byte Order | Big-Endian | Most significant byte transmitted first |
| Payload | Variable | UTF-8 encoded JSON diagnostic message |
| Payload Length | `N` bytes | Number of bytes contained in the JSON payload |

### Client TX Payload (LabVIEW → Python)

The LabVIEW TCP Message Loop sends vibration waveform data to the Python Diagnostic Coprocessor for analysis.

```json
{
  "sample_rate": 2000.0,
  "matrix": [
    [0.12, 0.25, -0.18, 0.04, "..."],
    [0.05, 0.08, -0.02, 0.01, "..."]
  ]
}
```
### Payload Fields
| Field         | Type            | Description                              |
| ------------- | --------------- | ---------------------------------------- |
| `sample_rate` | Float           | Acquisition sample rate in Hz            |
| `matrix`      | Array of Arrays | Multi-channel vibration waveform samples |
| `matrix[0]`   | Array           | Channel 1 vibration data (Motor NDE)     |
| `matrix[1]`   | Array           | Channel 2 vibration data (Motor DE)      |


### Server RX Payload (Python → LabVIEW)

The Python Diagnostic Coprocessor returns processed vibration diagnostics and machine health metrics.
```json
{
  "asset_id": 1,
  "frame_id": 406,
  "channels": [
    {
      "channel_id": 1,
      "peak_frequency": 44.92,
      "rms_acceleration": 0.16,
      "health_score": 99.7
    },
    {
      "channel_id": 2,
      "peak_frequency": 44.92,
      "rms_acceleration": 0.35,
      "health_score": 58.2
    }
  ]
}
```
### Response Fields
| Field              | Type    | Description                                               |
| ------------------ | ------- | --------------------------------------------------------- |
| `asset_id`         | Integer | Unique identifier for the monitored machine or asset      |
| `frame_id`         | Integer | Sequential identifier for the analyzed data frame         |
| `channels`         | Array   | Diagnostic results for each vibration channel             |
| `channel_id`       | Integer | Channel identifier matching the transmitted waveform data |
| `peak_frequency`   | Float   | Dominant vibration frequency detected (Hz)                |
| `rms_acceleration` | Float   | RMS acceleration level from vibration analysis            |
| `health_score`     | Float   | Computed equipment health indicator (0–100 scale)         |

### Example End-to-End Transaction:
### 1. LabVIEW Sends Vibration Data
```
   [4-byte payload length]
        +
[UTF-8 JSON waveform matrix]
```

Example:
```
Header:
[00 00 01 F4]

Payload:
{
  "sample_rate": 2000.0,
  "matrix": [
    [0.12, 0.25, -0.18, 0.04],
    [0.05, 0.08, -0.02, 0.01]
  ]
}
```

### 2. Python Returns Diagnostic Results
```
   [4-byte payload length]
        +
[UTF-8 JSON diagnostic response]
```

Example:
```
{
  "asset_id": 1,
  "frame_id": 406,
  "channels": [
    {
      "channel_id": 1,
      "peak_frequency": 44.92,
      "rms_acceleration": 0.16,
      "health_score": 99.7
    }
  ]
}
```

This protocol enables deterministic, low-latency communication between the LabVIEW real-time acquisition layer and the Python-based diagnostic analysis engine while preserving channel synchronization and frame integrity.
