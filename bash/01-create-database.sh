#!/bin/bash
RDS_ENDPOINT="{{ rds_endpoint.value.split(':')[0] }}"
DB_NAME="serpent_surge_db"
DB_USER="admin"
DB_PASS="adminpassword"

# --- EXECUTE SQL ---
echo "Connecting to RDS and creating table..."

mysql -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
CREATE TABLE IF NOT EXISTS score (
  id INT PRIMARY KEY,
  name TEXT,
  score INT,
  difficulty INT
);

INSERT INTO score VALUES (1, 'asd', 99, 3)
  ON DUPLICATE KEY UPDATE name=VALUES(name), score=VALUES(score), difficulty=VALUES(difficulty);

SELECT * FROM score;
EOF

# --- RESULT ---
echo "✅ Table created and test row inserted."

