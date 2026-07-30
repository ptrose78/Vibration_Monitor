# Vibration Monitor — Continuous Condition Monitoring System

An industrial-grade, multi-threaded condition monitoring system built with a **LabVIEW Queued Message Handler (QMH)** architecture, an **asynchronous Python diagnostic coprocessor**, and a **batched SQLite telemetry & error logging engine**.

Designed for high-speed vibration acquisition, real-time spectral feature extraction, automated fault detection, and resilient networked diagnostics.

## 📑 Table of Contents
* [📸 System Overview & Architecture](#-system-overview--architecture)
* [🔑 Key Features](#-key-features)
* [🛠 Tech Stack & Dependencies](#-tech-stack--dependencies)
* [📂 Directory Structure](#-directory-structure)
* [🔬 Signal Processing & Diagnostic Mechanics](#-signal-processing--diagnostic-mechanics)
  * [1. Spectral Scaling & Windowing](#1-spectral-scaling--windowing)
  * [2. Time-Domain Velocity Integration](#2-time-domain-velocity-integration)
* [📡 Network Protocol & Payload Specifications](#-network-protocol--payload-specifications)
* [⚙️ Configuration & Operational Modes](#%EF%B8%8F-configuration--operational-modes)
* [🗄️ Database Schema (SQLite)](#%EF%B8%8F-database-schema-sqlite)
* [🚀 Getting Started & Execution](#-getting-started--execution)
---

## 📸 System Overview & Architecture

The system segregates data acquisition, digital signal processing, local user interface rendering, external network coprocessing, and persistent data logging into decoupled parallel loops to protect hardware timing from software latency.

```text
                               ┌──────────────────────────────────────────────┐
                               │        NI DAQmx / Hardware Acquisition       │
                               └──────────────────────┬───────────────────────┘
                                                      │ (2000 Hz / Multi-Channel)
                                                      ▼
                               ┌──────────────────────────────────────────────┐
                               │           Acquisition Message Loop           │
                               └────┬─────────────────┬──────────────────┬────┘
                                    │                 │                  │
         (Multi-Channel Waveforms)  │                 │                  │ (Multi-Channel Waveforms)
                                    │                 │ (Multi-Channel   │
                                    ▼                 │  Waveforms)      ▼
           ┌──────────────────────────┐               │               ┌──────────────────────────┐
           │      Graph / UI Loop     │               ▼               │    Data Logging Loop     │
           │   (Decimated Rendering)  │    ┌────────────────────┐     │   (TDMS Binary Writer)   │
           └──────────────────────────┘    │  TCP Message Loop  │     └──────────────────────────┘
                                           │(Non-Block Client)  │
                                           └──────────┬─────────┘
                                                      │
                                                      │ (JSON Payload / Port 12345)
                                                      ▼
                                         ┌──────────────────────────┐
                                         │ Python Diagnostics Engine│
                                         │  (JSON Health Metrics)   │
                                         └────────────┬─────────────┘
                                                      │
                                                      │ Return Diagnostic Telemetry (JSON)
                                                      ▼
                                         ┌──────────────────────────┐
                                         │     TCP Message Loop     │
                                         │   (Fan-out Dispatcher)   │
                                         └──────┬────────────┬──────┘
                                                │            │
              Enqueue "Update Telemetry Display"│            │ Enqueue "Log Telemetry"
                                                │            │
                                                ▼            ▼
                                ┌────────────────────┐    ┌──────────────────────────┐
                                │   Graph / UI Loop  │    │   Database Message Loop  │
                                │ (Telemetry Display)│    │ (Batched SQLite Engine)  │
                                └────────────────────┘    └──────────────────────────┘
```
## 🔑 Key Features

* **Configurable Multi-Channel Data Acquisition:** Processes multi-channel accelerometer signals via DAQmx tasks configured dynamically via `config.ini` (e.g., $2000.0\text{ Hz}$ sampling baseline up to $51.2\text{ kHz}$ hardware maximums) with fine frequency resolution for real-time spectral analysis.
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

## 🗄️ Database Schema (SQLite)

Telemetry metrics and network error logs are written into `vibration_data.db` using two decoupled operational tables:

```sql
-- Telemetry Data Table
CREATE TABLE IF NOT EXISTS telemetry (
    entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
    asset_id INTEGER NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    peak_frequency REAL NOT NULL,
    rms_acceleration REAL NOT NULL,
    health_score REAL NOT NULL,
    channel_id INTEGER NOT NULL,
    frame_id INTEGER NOT NULL
);

-- System Error & Event Log Table
CREATE TABLE IF NOT EXISTS system_errors (
    error_id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    source_loop TEXT NOT NULL,
    error_code INTEGER NOT NULL,
    description TEXT NOT NULL
);
```

# 🚀 Getting Started & Execution

## 1. Prerequisites & Dependencies

Before running the Vibration Monitoring System, ensure all hardware and software dependencies are installed.

### Hardware & Software Requirements

| Component | Requirement |
| :--- | :--- |
| **LabVIEW** | National Instruments LabVIEW 2026 Q1 (32-bit) *(Back-savable to 2020+ via File → Save for Previous Version)* |
| **DAQ Driver** | NI DAQmx Driver Package |
| **Python** | Python 3.8+ |
| **Python Libraries** | `numpy` |

### Python Package Installation

Install the required Python packages using `pip`:

```bash
pip install numpy
```
## 2. Running the Coprocessor & System

The Vibration Monitoring System consists of two primary components:

| Component | Description |
|---|---|
| **Python Diagnostic Coprocessor** | Performs vibration analysis, frequency-domain processing, and generates diagnostic health metrics. |
| **LabVIEW Master Application** | Handles sensor data acquisition, visualization, TCP communication management, and system control. |

---

### Step 1 — Start the Python Diagnostic Server

Open a terminal window and navigate to the Python application directory:

```bash
cd Python
```
### Launch the Diagnostic Server

Start the Python Diagnostic Coprocessor from the terminal:

```bash
python coprocessor.py
```

A successful startup should display:
```text
Starting Diagnostic Coprocessor Server on 127.0.0.1:12345...
Awaiting connection from LabVIEW Simulation Engine...
```
The Python Diagnostic Coprocessor is now running and ready to accept TCP connections from the LabVIEW application.

### Step 2 — Launch the LabVIEW Master Application

1. **Open the Project:** Open `Vibration_Monitor.lvproj` in LabVIEW.
2. **Launch the Master VI:** Open `Main.vi` and click the **Run** arrow.
3. **Verify Connection:** Observe the blue `Comms/Python Link` status indicator illuminate, confirming active TCP communication.

The system is now ready for real-time vibration acquisition, diagnostic analysis, and telemetry monitoring.





