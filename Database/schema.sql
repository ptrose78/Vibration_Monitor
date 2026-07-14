-- Database schema for Vibration_Monitor

-- 1. Table for tracked industrial assets
CREATE TABLE IF NOT EXISTS assets (
    asset_id INTEGER PRIMARY KEY AUTOINCREMENT,
    asset_name TEXT NOT NULL UNIQUE,
    model_number TEXT,
    location TEXT
);

-- 2. Table for continuous health metrics (Continuous telemetry)
CREATE TABLE IF NOT EXISTS telemetry (
    entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
    asset_id INTEGER NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    peak_frequency REAL NOT NULL,
    rms_acceleration REAL NOT NULL,
    health_score REAL NOT NULL,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id) ON DELETE CASCADE
);

-- Seed database with a default machine asset
INSERT OR IGNORE INTO assets (asset_id, asset_name, model_number, location)
VALUES (1, 'Main Compressor Shaft', 'AC-9000-X', 'Production Floor Bay 3');