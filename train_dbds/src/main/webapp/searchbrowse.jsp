<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
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
            max-width: 800px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        p {
            text-align: center;
            margin-top: 20px;
        }
        button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Search Results</h2>

        <%
            // Get parameters from the search form
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");
            String travelDate = request.getParameter("travelDate");
            String sortCriteria = request.getParameter("sortCriteria");

            if (origin != null && destination != null && travelDate != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/YourDBName", "your_username", "your_password");

                    // Prepare SQL query with sorting
                    String query = "SELECT train_name, origin, destination, departure_time, arrival_time, fare, stops " +
                                   "FROM TrainSchedules " +
                                   "WHERE origin = ? AND destination = ? AND travel_date = ? " +
                                   "ORDER BY " + sortCriteria;
                    ps = conn.prepareStatement(query);
                    ps.setString(1, origin);
                    ps.setString(2, destination);
                    ps.setString(3, travelDate);
                    rs = ps.executeQuery();

                    // Display results
                    if (rs.isBeforeFirst()) {
                        out.println("<table>");
                        out.println("<tr><th>Train Name</th><th>Origin</th><th>Destination</th><th>Departure Time</th><th>Arrival Time</th><th>Fare</th><th>Stops</th></tr>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("train_name") + "</td>");
                            out.println("<td>" + rs.getString("origin") + "</td>");
                            out.println("<td>" + rs.getString("destination") + "</td>");
                            out.println("<td>" + rs.getTime("departure_time") + "</td>");
                            out.println("<td>" + rs.getTime("arrival_time") + "</td>");
                            out.println("<td>$" + rs.getDouble("fare") + "</td>");
                            out.println("<td>" + rs.getString("stops") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else {
                        out.println("<p>No train schedules found for the selected criteria.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error retrieving train schedules. Please try again later.</p>");
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            } else {
                out.println("<p>Invalid search criteria. Please go back and try again.</p>");
            }
        %>

        <!-- Back Button -->
        <button onclick="window.history.back()">Go Back</button>
    </div>

</body>
</html>
 --%>
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
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
            max-width: 800px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        p {
            text-align: center;
            margin-top: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Search Results</h2>

        <%
            // Get parameters from the search form
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");
            String travelDate = request.getParameter("travelDate");
            String sortCriteria = request.getParameter("sortCriteria");

            if (origin != null && destination != null && travelDate != null) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");

                    // Prepare SQL query with sorting
                    String query = "SELECT train_name, origin, destination, departure_time, arrival_time, fare, stops " +
                                   "FROM TrainSchedules " +
                                   "WHERE origin = ? AND destination = ? AND travel_date = ? " +
                                   "ORDER BY " + sortCriteria;
                    ps = conn.prepareStatement(query);
                    ps.setString(1, origin);
                    ps.setString(2, destination);
                    ps.setString(3, travelDate);
                    rs = ps.executeQuery();

                    // Display results
                    if (rs.isBeforeFirst()) {
                        out.println("<table>");
                        out.println("<tr><th>Train Name</th><th>Origin</th><th>Destination</th><th>Departure Time</th><th>Arrival Time</th><th>Fare</th><th>Stops</th></tr>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("train_name") + "</td>");
                            out.println("<td>" + rs.getString("origin") + "</td>");
                            out.println("<td>" + rs.getString("destination") + "</td>");
                            out.println("<td>" + rs.getTime("departure_time") + "</td>");
                            out.println("<td>" + rs.getTime("arrival_time") + "</td>");
                            out.println("<td>$" + rs.getDouble("fare") + "</td>");
                            out.println("<td>" + rs.getString("stops") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else {
                        out.println("<p>No train schedules found for the selected criteria.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error retrieving train schedules. Please try again later.</p>");
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            } else {
                out.println("<p>Invalid search criteria. Please go back and try again.</p>");
            }
        %>

        <!-- Center-aligned Back Button -->
        <div class="button-container">
            <button onclick="window.history.back()">Go Back</button>
        </div>
    </div>

</body>
</html>
 