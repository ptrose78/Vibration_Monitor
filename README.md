# Vibration_Monitor
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