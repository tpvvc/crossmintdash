-- D1 schema for Crossmint NFT System
PRAGMA foreign_keys=ON;

CREATE TABLE IF NOT EXISTS vendors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  payout_address TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS creators (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  wallet_address TEXT,
  vendor_id INTEGER,
  created_at TEXT DEFAULT (datetime('now')),
  FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS collections (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  crossmint_collection_id TEXT UNIQUE,
  name TEXT NOT NULL,
  chain TEXT NOT NULL DEFAULT 'polygon',
  metadata_uri TEXT,
  created_by_creator_id INTEGER,
  created_at TEXT DEFAULT (datetime('now')),
  FOREIGN KEY (created_by_creator_id) REFERENCES creators(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS subscriptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  creator_id INTEGER NOT NULL,
  subscriber TEXT NOT NULL,
  plan TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'active',
  started_at TEXT DEFAULT (datetime('now')),
  expires_at TEXT,
  FOREIGN KEY (creator_id) REFERENCES creators(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mints (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  collection_id INTEGER,
  recipient TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  status TEXT NOT NULL DEFAULT 'queued',
  crossmint_request_id TEXT,
  created_at TEXT DEFAULT (datetime('now')),
  FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE SET NULL
);
