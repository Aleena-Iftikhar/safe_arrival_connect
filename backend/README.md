# Backend

This is a simple **Flask (Python)** server that connects to a **MySQL** database. Its job is to save and return a user's "journey" (destination + emergency contacts) so the Flutter app can use it.

---

### 1. Setup
```python
app = Flask(__name__)
CORS(app)
```
- Creates the Flask app.
- `CORS(app)` allows the Flutter app (sending requests from a browser or mobile device) to talk to this backend without being blocked.

### 2. Database Connection
```python
db_config = { 'host': 'localhost', 'user': 'root', 'password': ..., 'database': 'safearrive' }
def get_connection():
    return mysql.connector.connect(**db_config)
```
- Holds the MySQL connection settings.
- `get_connection()` opens a fresh connection every time the app needs to talk to the database.

### 3. Route: `POST /journey` — Save a new journey
- When the Flutter app sends a trip's details (destination name, address, message, contacts), this route inserts them into the `journeys` table.
- If destination name or address is missing, it returns an error (`400`).
- On success, it returns the newly created record's `id`.

### 4. Route: `GET /journey/latest` — Get the most recent journey
- Returns only the **single latest** journey — used to show the "current trip" on the Home screen.
- If no journey exists, it returns `404`.

### 5. Route: `GET /journey/all` — Get all journeys (last 20)
- Returns the 20 most recent journeys — used to populate the app's "Recent Journeys" list.

### 6. Running the server
```python
app.run(host='0.0.0.0', port=3000, debug=True)
```
- The server runs on **port 3000**. `host='0.0.0.0'` means it's reachable from any device on the local network (like a phone testing the app).

---

## Summary
This backend takes journey data from the Flutter app, saves it to MySQL, and sends it back whenever the app needs it — that's the whole job.