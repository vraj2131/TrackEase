<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Train Schedules</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 700px;
            margin-top: 80px;
        }
        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }
        label {
            font-size: 16px;
            color: #555;
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
        }
        button {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            margin-bottom: 20px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/your_database_name";
    String dbUser = "your_username";
    String dbPass = "your_password";

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
    } catch (Exception e) {
        out.println("<p>Database connection error: " + e.getMessage() + "</p>");
    }
%>
<div class="container">
    <h2>Search Train Schedules</h2>

    <!-- Search for Train Schedules -->
    <form method="post">
        <input type="hidden" name="action" value="searchSchedules">
        <label for="origin">Enter Origin Station:</label>
        <input type="text" id="origin" name="origin" placeholder="Enter origin station" required>

        <label for="destination">Enter Destination Station:</label>
        <input type="text" id="destination" name="destination" placeholder="Enter destination station" required>

        <label for="travelDate">Enter Date of Travel:</label>
        <input type="date" id="travelDate" name="travelDate" required>

        <button type="submit">Search Schedules</button>
    </form>

    <!-- Sort Train Schedules -->
    <form method="post">
        <input type="hidden" name="action" value="sortSchedules">
        <label for="sortCriteria">Sort By:</label>
        <select id="sortCriteria" name="sortCriteria" required>
            <option value="arrival_time">Arrival Time</option>
            <option value="departure_time">Departure Time</option>
            <option value="fare">Fare</option>
        </select>
        <button type="submit">Sort Schedules</button>
    </form>

    <% 
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if (action.equals("searchSchedules")) {
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String travelDate = request.getParameter("travelDate");

                String query = "SELECT * FROM TrainSchedule WHERE departure_station_id = (SELECT station_id FROM Stations WHERE station_name = ?) AND arrival_station_id = (SELECT station_id FROM Stations WHERE station_name = ?) AND travel_date = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, origin);
                ps.setString(2, destination);
                ps.setDate(3, java.sql.Date.valueOf(travelDate));
                ResultSet rs = ps.executeQuery();

                out.println("<h3>Search Results</h3>");
                while (rs.next()) {
                    out.println("<p>Train ID: " + rs.getInt("train_id") + " | Departure: " + rs.getString("departure_time") + " | Arrival: " + rs.getString("arrival_time") + " | Fare: $" + rs.getDouble("fare") + "</p>");
                }
            } else if (action.equals("sortSchedules")) {
                String sortCriteria = request.getParameter("sortCriteria");

                String query = "SELECT * FROM TrainSchedule ORDER BY " + sortCriteria;
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                out.println("<h3>Sorted Train Schedules</h3>");
                while (rs.next()) {
                    out.println("<p>Train ID: " + rs.getInt("train_id") + " | Departure: " + rs.getString("departure_time") + " | Arrival: " + rs.getString("arrival_time") + " | Fare: $" + rs.getDouble("fare") + "</p>");
                }
            }
        }
    %>
</div>
<%
    if (conn != null) {
        conn.close();
    }
%>
</body>
</html>
