<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Functions</title>
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
        input[type="text"], input[type="number"], select {
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
    <h2>Admin Functions</h2>

    <!-- Generate Sales Report -->
    <form method="post">
        <input type="hidden" name="action" value="salesReport">
        <button type="submit">Generate Sales Report</button>
    </form>

    <!-- Produce List of Reservations -->
    <form method="post">
        <input type="hidden" name="action" value="listReservations">
        <label for="listType">Select Reservation Type:</label>
        <select id="listType" name="listType">
            <option value="transit">By Transit Line</option>
            <option value="customer">By Customer Name</option>
        </select>
        <button type="submit">Produce List of Reservations</button>
    </form>

    <!-- Produce Listing of Revenue -->
    <form method="post">
        <input type="hidden" name="action" value="revenueReport">
        <label for="revenueType">Select Revenue Type:</label>
        <select id="revenueType" name="revenueType">
            <option value="transit">By Transit Line</option>
            <option value="customer">By Customer Name</option>
        </select>
        <button type="submit">Produce Revenue Report</button>
    </form>

    <!-- Best Customer -->
    <form method="post">
        <input type="hidden" name="action" value="bestCustomer">
        <button type="submit">Find Best Customer</button>
    </form>

    <!-- Best 5 Most Active Transit Lines -->
    <form method="post">
        <input type="hidden" name="action" value="mostActiveLines">
        <button type="submit">Find Best 5 Most Active Transit Lines</button>
    </form>

    <% 
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if (action.equals("salesReport")) {
                String query = "SELECT MONTH(reservation_date) AS month, SUM(total_fare) AS revenue FROM Reservations GROUP BY MONTH(reservation_date)";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                out.println("<h3>Sales Report (Monthly)</h3>");
                while (rs.next()) {
                    out.println("<p>Month: " + rs.getInt("month") + " - Revenue: $" + rs.getDouble("revenue") + "</p>");
                }
            } else if (action.equals("listReservations")) {
                String listType = request.getParameter("listType");
                String query = listType.equals("transit") ? 
                    "SELECT transit_line, COUNT(*) AS reservations FROM Reservations R JOIN TrainSchedule T ON R.schedule_id = T.schedule_id GROUP BY transit_line" : 
                    "SELECT C.first_name, C.last_name, COUNT(*) AS reservations FROM Reservations R JOIN Customers C ON R.customer_id = C.customer_id GROUP BY C.customer_id";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                out.println("<h3>List of Reservations</h3>");
                while (rs.next()) {
                    if (listType.equals("transit")) {
                        out.println("<p>Transit Line: " + rs.getString("transit_line") + " - Reservations: " + rs.getInt("reservations") + "</p>");
                    } else {
                        out.println("<p>Customer: " + rs.getString("first_name") + " " + rs.getString("last_name") + " - Reservations: " + rs.getInt("reservations") + "</p>");
                    }
                }
            } else if (action.equals("revenueReport")) {
                String revenueType = request.getParameter("revenueType");
                String query = revenueType.equals("transit") ? 
                    "SELECT transit_line, SUM(total_fare) AS revenue FROM Reservations R JOIN TrainSchedule T ON R.schedule_id = T.schedule_id GROUP BY transit_line" : 
                    "SELECT C.first_name, C.last_name, SUM(total_fare) AS revenue FROM Reservations R JOIN Customers C ON R.customer_id = C.customer_id GROUP BY C.customer_id";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                out.println("<h3>Revenue Report</h3>");
                while (rs.next()) {
                    if (revenueType.equals("transit")) {
                        out.println("<p>Transit Line: " + rs.getString("transit_line") + " - Revenue: $" + rs.getDouble("revenue") + "</p>");
                    } else {
                        out.println("<p>Customer: " + rs.getString("first_name") + " " + rs.getString("last_name") + " - Revenue: $" + rs.getDouble("revenue") + "</p>");
                    }
                }
            } else if (action.equals("bestCustomer")) {
                String query = "SELECT C.first_name, C.last_name, SUM(total_fare) AS total_spent FROM Reservations R JOIN Customers C ON R.customer_id = C.customer_id GROUP BY R.customer_id ORDER BY total_spent DESC LIMIT 1";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    out.println("<h3>Best Customer</h3>");
                    out.println("<p>Customer: " + rs.getString("first_name") + " " + rs.getString("last_name") + " - Total Spent: $" + rs.getDouble("total_spent") + "</p>");
                }
            } else if (action.equals("mostActiveLines")) {
                String query = "SELECT transit_line, COUNT(*) AS activity FROM Reservations R JOIN TrainSchedule T ON R.schedule_id = T.schedule_id GROUP BY transit_line ORDER BY activity DESC LIMIT 5";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                out.println("<h3>Top 5 Most Active Transit Lines</h3>");
                while (rs.next()) {
                    out.println("<p>Transit Line: " + rs.getString("transit_line") + " - Activity: " + rs.getInt("activity") + "</p>");
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
