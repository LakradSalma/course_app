from flask import Flask, jsonify, request, make_response
from flask_cors import CORS  # Important for Flutter web

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Mock database
courses = [
    {"id": "1", "title": "Flutter Basics", "code": "FLT101", "description": "Introduction to Flutter", "ects": 5},
    {"id": "2", "title": "Dart Programming", "code": "DRT201", "description": "Dart language fundamentals", "ects": 4}
]

@app.route('/courses', methods=['GET'])
def get_courses():
    return jsonify(courses)

@app.route('/courses', methods=['POST'])
def create_course():
    if not request.json:
        return jsonify({"error": "Request must be JSON"}), 400

    required_fields = ['title', 'code', 'description', 'ects']
    if not all(field in request.json for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    new_course = request.json
    new_course["id"] = str(len(courses) + 1)  # Ensure ID is generated
    courses.append(new_course)

    # Return the full course object with ID
    return jsonify(new_course), 201  # 201 = Created

@app.route('/courses/<id>', methods=['PUT'])
def update_course(id):
    course = next((c for c in courses if c["id"] == id), None)
    if not course:
        return jsonify({"error": "Course not found"}), 404
    course.update(request.json)
    return jsonify(course)

@app.route('/courses/<id>', methods=['DELETE'])
def delete_course(id):
    global courses
    courses = [c for c in courses if c["id"] != id]
    return '', 204

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3200, debug=True)