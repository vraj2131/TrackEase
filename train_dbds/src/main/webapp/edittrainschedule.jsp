<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        form, table {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Train Schedules Management</h2>

        <!-- Form for updating train schedules -->
        <form method="post">
            <label for="scheduleId">Schedule ID:</label>
            <input type="text" id="scheduleId" name="scheduleId" placeholder="Enter Schedule ID" required>

            <label for="trainId">Train ID:</label>
            <input type="text" id="trainId" name="trainId" placeholder="Enter Train ID">

            <label for="departureStationId">Departure Station ID:</label>
            <input type="text" id="departureStationId" name="departureStationId" placeholder="Enter Departure Station ID">

            <label for="arrivalStationId">Arrival Station ID:</label>
            <input type="text" id="arrivalStationId" name="arrivalStationId" placeholder="Enter Arrival Station ID">

            <label for="transitLine">Transit Line:</label>
            <input type="text" id="transitLine" name="transitLine" placeholder="Enter Transit Line">

            <label for="departureDatetime">New Departure Datetime:</label>
            <input type="datetime-local" id="departureDatetime" name="departureDatetime">

            <label for="arrivalDatetime">New Arrival Datetime:</label>
            <input type="datetime-local" id="arrivalDatetime" name="arrivalDatetime">

            <label for="totalFare">Total Fare:</label>
            <input type="number" id="totalFare" name="totalFare" step="0.01" placeholder="Enter Total Fare">

            <button type="submit">Update Schedule</button>
        </form>

        <!-- Display schedules -->
        <h3>Existing Schedules</h3>
        <table>
            <thead>
                <tr>
                    <th>Schedule ID</th>
                    <th>Train ID</th>
                    <th>Departure Station ID</th>
                    <th>Arrival Station ID</th>
                    <th>Transit Line</th>
                    <th>Departure Datetime</th>
                    <th>Arrival Datetime</th>
                    <th>Total Fare</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                        stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM trainschedule");

                        while (rs.next()) {
                            int scheduleId = rs.getInt("schedule_id");
                            int trainId = rs.getInt("train_id");
                            int departureStationId = rs.getInt("departure_station_id");
                            int arrivalStationId = rs.getInt("arrival_station_id");
                            String transitLine = rs.getString("transit_line");
                            String departureDatetime = rs.getString("departure_datetime");
                            String arrivalDatetime = rs.getString("arrival_datetime");
                            double totalFare = rs.getDouble("total_fare");
                %>
                <tr>
                    <td><%= scheduleId %></td>
                    <td><%= trainId %></td>
                    <td><%= departureStationId %></td>
                    <td><%= arrivalStationId %></td>
                    <td><%= transitLine %></td>
                    <td><%= departureDatetime %></td>
                    <td><%= arrivalDatetime %></td>
                    <td>$<%= totalFare %></td>
                    <td>
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="deleteScheduleId" value="<%= scheduleId %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>

        <!-- Backend logic for editing and deleting -->
        <%
            String scheduleId = request.getParameter("scheduleId");
            String trainId = request.getParameter("trainId");
            String departureStationId = request.getParameter("departureStationId");
            String arrivalStationId = request.getParameter("arrivalStationId");
            String transitLine = request.getParameter("transitLine");
            String departureDatetime = request.getParameter("departureDatetime");
            String arrivalDatetime = request.getParameter("arrivalDatetime");
            String totalFare = request.getParameter("totalFare");
            String deleteScheduleId = request.getParameter("deleteScheduleId");

            if (scheduleId != null) {
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                    String updateQuery = "UPDATE trainschedule SET train_id = ?, departure_station_id = ?, arrival_station_id = ?, transit_line = ?, departure_datetime = ?, arrival_datetime = ?, total_fare = ? WHERE schedule_id = ?";
                    PreparedStatement ps = conn.prepareStatement(updateQuery);

                    if (trainId != null && !trainId.isEmpty()) {
                        ps.setInt(1, Integer.parseInt(trainId));
                    } else {
                        ps.setNull(1, java.sql.Types.INTEGER);
                    }

                    if (departureStationId != null && !departureStationId.isEmpty()) {
                        ps.setInt(2, Integer.parseInt(departureStationId));
                    } else {
                        ps.setNull(2, java.sql.Types.INTEGER);
                    }

                    if (arrivalStationId != null && !arrivalStationId.isEmpty()) {
                        ps.setInt(3, Integer.parseInt(arrivalStationId));
                    } else {
                        ps.setNull(3, java.sql.Types.INTEGER);
                    }

                    ps.setString(4, transitLine != null && !transitLine.isEmpty() ? transitLine : null);
                    ps.setString(5, departureDatetime != null && !departureDatetime.isEmpty() ? departureDatetime : null);
                    ps.setString(6, arrivalDatetime != null && !arrivalDatetime.isEmpty() ? arrivalDatetime : null);

                    if (totalFare != null && !totalFare.isEmpty()) {
                        ps.setDouble(7, Double.parseDouble(totalFare));
                    } else {
                        ps.setNull(7, java.sql.Types.DOUBLE);
                    }

                    ps.setInt(8, Integer.parseInt(scheduleId));
                    ps.executeUpdate();
                    out.println("<p>Schedule updated successfully!</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) conn.close();
                }
            }


            if (deleteScheduleId != null) {
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                    String deleteQuery = "DELETE FROM trainschedule WHERE schedule_id = ?";
                    PreparedStatement ps = conn.prepareStatement(deleteQuery);
                    ps.setInt(1, Integer.parseInt(deleteScheduleId));
                    ps.executeUpdate();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>
</body>
</html>
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        form, table {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Train Schedules Management</h2>

        <!-- Form for updating train schedules -->
        <form method="post">
            <label for="scheduleId">Schedule ID:</label>
            <input type="text" id="scheduleId" name="scheduleId" placeholder="Enter Schedule ID" required>

            <label for="trainId">Train ID:</label>
            <input type="text" id="trainId" name="trainId" placeholder="Enter Train ID">

            <label for="departureStationId">Departure Station ID:</label>
            <input type="text" id="departureStationId" name="departureStationId" placeholder="Enter Departure Station ID">

            <label for="arrivalStationId">Arrival Station ID:</label>
            <input type="text" id="arrivalStationId" name="arrivalStationId" placeholder="Enter Arrival Station ID">

            <label for="transitLine">Transit Line:</label>
            <input type="text" id="transitLine" name="transitLine" placeholder="Enter Transit Line">

            <label for="departureDatetime">New Departure Datetime:</label>
            <input type="datetime-local" id="departureDatetime" name="departureDatetime">

            <label for="arrivalDatetime">New Arrival Datetime:</label>
            <input type="datetime-local" id="arrivalDatetime" name="arrivalDatetime">

            <label for="totalFare">Total Fare:</label>
            <input type="number" id="totalFare" name="totalFare" step="0.01" placeholder="Enter Total Fare">

            <button type="submit">Update Schedule</button>
        </form>

        <!-- Display schedules -->
        <h3>Existing Schedules</h3>
        <table>
            <thead>
                <tr>
                    <th>Schedule ID</th>
                    <th>Train ID</th>
                    <th>Departure Station ID</th>
                    <th>Arrival Station ID</th>
                    <th>Transit Line</th>
                    <th>Departure Datetime</th>
                    <th>Arrival Datetime</th>
                    <th>Total Fare</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                        stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM trainschedule");

                        while (rs.next()) {
                            int scheduleId = rs.getInt("schedule_id");
                            int trainId = rs.getInt("train_id");
                            int departureStationId = rs.getInt("departure_station_id");
                            int arrivalStationId = rs.getInt("arrival_station_id");
                            String transitLine = rs.getString("transit_line");
                            String departureDatetime = rs.getString("departure_datetime");
                            String arrivalDatetime = rs.getString("arrival_datetime");
                            double totalFare = rs.getDouble("total_fare");
                %>
                <tr>
                    <td><%= scheduleId %></td>
                    <td><%= trainId %></td>
                    <td><%= departureStationId %></td>
                    <td><%= arrivalStationId %></td>
                    <td><%= transitLine %></td>
                    <td><%= departureDatetime %></td>
                    <td><%= arrivalDatetime %></td>
                    <td>$<%= totalFare %></td>
                    <td>
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="deleteScheduleId" value="<%= scheduleId %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>

        <!-- Backend logic for editing and deleting -->
        <%
            String scheduleId = request.getParameter("scheduleId");
            String trainId = request.getParameter("trainId");
            String departureStationId = request.getParameter("departureStationId");
            String arrivalStationId = request.getParameter("arrivalStationId");
            String transitLine = request.getParameter("transitLine");
            String departureDatetime = request.getParameter("departureDatetime");
            String arrivalDatetime = request.getParameter("arrivalDatetime");
            String totalFare = request.getParameter("totalFare");
            String deleteScheduleId = request.getParameter("deleteScheduleId");

            if (scheduleId != null) {
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                    String updateQuery = "UPDATE trainschedule SET train_id = ?, departure_station_id = ?, arrival_station_id = ?, transit_line = ?, departure_datetime = ?, arrival_datetime = ?, total_fare = ? WHERE schedule_id = ?";
                    PreparedStatement ps = conn.prepareStatement(updateQuery);

                    ps.setInt(1, trainId != null && !trainId.isEmpty() ? Integer.parseInt(trainId) : null);
                    ps.setInt(2, departureStationId != null && !departureStationId.isEmpty() ? Integer.parseInt(departureStationId) : null);
                    ps.setInt(3, arrivalStationId != null && !arrivalStationId.isEmpty() ? Integer.parseInt(arrivalStationId) : null);
                    ps.setString(4, transitLine != null ? transitLine : null);
                    ps.setString(5, departureDatetime != null ? departureDatetime : null);
                    ps.setString(6, arrivalDatetime != null ? arrivalDatetime : null);
                    ps.setDouble(7, totalFare != null ? Double.parseDouble(totalFare) : 0.0);
                    ps.setInt(8, Integer.parseInt(scheduleId));

                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
                        response.sendRedirect("edittrainschedule.jsp?update=success"); // Redirect to avoid continuous submission
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) conn.close();
                }
            }

            if (deleteScheduleId != null) {
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");
                    String deleteQuery = "DELETE FROM trainschedule WHERE schedule_id = ?";
                    PreparedStatement ps = conn.prepareStatement(deleteQuery);
                    ps.setInt(1, Integer.parseInt(deleteScheduleId));
                    int rowsDeleted = ps.executeUpdate();
                    if (rowsDeleted > 0) {
                        response.sendRedirect("edittrainschedule.jsp?delete=success"); // Redirect to avoid continuous submission
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>
</body>
</html>
 