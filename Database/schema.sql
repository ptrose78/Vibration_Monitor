BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "telemetry" (
	"entry_id"	INTEGER,
	"asset_id"	INTEGER NOT NULL,
	"timestamp"	DATETIME DEFAULT CURRENT_TIMESTAMP,
	"peak_frequency"	REAL NOT NULL,
	"rms_acceleration"	REAL NOT NULL,
	"health_score"	REAL NOT NULL,
	"channel_id"	INTEGER,
	"frame_id"	INTEGER,
	PRIMARY KEY("entry_id" AUTOINCREMENT),
	FOREIGN KEY("asset_id") REFERENCES "assets"("asset_id") ON DELETE CASCADE
);
COMMIT;
