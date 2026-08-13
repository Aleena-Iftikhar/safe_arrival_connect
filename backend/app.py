from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import json

app = Flask(__name__)
CORS(app)

# ✅ MySQL connection settings — apne credentials daalein
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'safearrive',
}

def get_connection():
    return mysql.connector.connect(**db_config)


# ── Save a new journey ──
@app.route('/journey', methods=['POST'])
def save_journey():
    data = request.get_json()

    destination_name = data.get('destinationName', '').strip()
    destination_address = data.get('destinationAddress', '').strip()
    message = data.get('message', '').strip()
    contacts = data.get('contacts', [])

    if not destination_name or not destination_address:
        return jsonify({'success': False, 'message': 'Destination name and address are required'}), 400

    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """INSERT INTO journeys (destination_name, destination_address, message, contacts)
               VALUES (%s, %s, %s, %s)""",
            (destination_name, destination_address, message, json.dumps(contacts))
        )
        conn.commit()
        new_id = cursor.lastrowid
        cursor.close()
        conn.close()

        return jsonify({'success': True, 'id': new_id}), 200

    except mysql.connector.Error as err:
        print(f"DB Error: {err}")
        return jsonify({'success': False, 'message': 'Server error'}), 500


# ── Get latest journey (for HomeScreen) ──
@app.route('/journey/latest', methods=['GET'])
def get_latest_journey():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM journeys ORDER BY created_at DESC LIMIT 1"
        )
        journey = cursor.fetchone()
        cursor.close()
        conn.close()

        if journey is None:
            return jsonify({'success': False, 'message': 'No journey found'}), 404

        return jsonify({
            'success': True,
            'data': {
                'id': journey['id'],
                'destinationName': journey['destination_name'],
                'destinationAddress': journey['destination_address'],
                'message': journey['message'],
                'contacts': journey['contacts'],  # already JSON
                'status': journey['status'],
                'createdAt': journey['created_at'].isoformat(),
            }
        }), 200

    except mysql.connector.Error as err:
        print(f"DB Error: {err}")
        return jsonify({'success': False, 'message': 'Server error'}), 500


# ── Get all journeys (for "Recent journeys" section) ──
@app.route('/journey/all', methods=['GET'])
def get_all_journeys():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM journeys ORDER BY created_at DESC LIMIT 20"
        )
        journeys = cursor.fetchall()
        cursor.close()
        conn.close()

        # datetime ko string mein convert karo taake JSON serialize ho sake
        for j in journeys:
            j['created_at'] = j['created_at'].isoformat()

        return jsonify({'success': True, 'data': journeys}), 200

    except mysql.connector.Error as err:
        print(f"DB Error: {err}")
        return jsonify({'success': False, 'message': 'Server error'}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000, debug=True)