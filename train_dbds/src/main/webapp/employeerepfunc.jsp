<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Representative Functions</title>
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
    <h2>Employee Representative Functions</h2>

    <!-- Produce Train Schedules for a Given Station -->
    <form method="post">
        <input type="hidden" name="action" value="trainSchedules">
        <label for="station">Enter Station Name:</label>
        <input type="text" id="station" name="station" placeholder="Enter station name (origin/destination)" required>
        <button type="submit">Get Train Schedules</button>
    </form>

    <!-- Produce List of Customers with Reservations on a Transit Line -->
    <form method="post">
        <input type="hidden" name="action" value="customerReservations">
        <label for="transitLine">Enter Transit Line:</label>
        <input type="text" id="transitLine" name="transitLine" placeholder="Enter transit line" required>

        <label for="date">Enter Reservation Date:</label>
        <input type="date" id="date" name="date" required>

        <button type="submit">Get Customer Reservations</button>
    </form>

    <% 
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if (action.equals("trainSchedules")) {
                String station = request.getParameter("station");
                String query = "SELECT * FROM TrainSchedule WHERE departure_station_id = (SELECT station_id FROM Stations WHERE station_name = ?) OR arrival_station_id = (SELECT station_id FROM Stations WHERE station_name = ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, station);
                ps.setString(2, station);
                ResultSet rs = ps.executeQuery();
                out.println("<h3>Train Schedules for Station: " + station + "</h3>");
                while (rs.next()) {
                    out.println("<p>Train ID: " + rs.getInt("train_id") + " | Departure: " + rs.getString("departure_time") + " | Arrival: " + rs.getString("arrival_time") + "</p>");
                }
            } else if (action.equals("customerReservations")) {
                String transitLine = request.getParameter("transitLine");
                String date = request.getParameter("date");
                String query = "SELECT C.first_name, C.last_name FROM Reservations R JOIN TrainSchedule T ON R.schedule_id = T.schedule_id JOIN Customers C ON R.customer_id = C.customer_id WHERE T.transit_line = ? AND R.reservation_date = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, transitLine);
                ps.setDate(2, java.sql.Date.valueOf(date));
                ResultSet rs = ps.executeQuery();
                out.println("<h3>Customers with Reservations on Transit Line: " + transitLine + " for Date: " + date + "</h3>");
                while (rs.next()) {
                    out.println("<p>Customer: " + rs.getString("first_name") + " " + rs.getString("last_name") + "</p>");
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
