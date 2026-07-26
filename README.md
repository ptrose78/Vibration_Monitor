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