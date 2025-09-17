<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        .section {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
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
        <h2>Admin Dashboard</h2>

        <!-- Manage Employees -->
        <div class="section">
            <h3>Manage Employees</h3>
            <form method="post" action="manageEmployees.jsp">
                <label for="empAction">Action:</label>
                <select id="empAction" name="empAction">
                    <option value="add">Add</option>
                    <option value="edit">Edit</option>
                    <option value="delete">Delete</option>
                </select>
                <label for="empFirstName">First Name:</label>
                <input type="text" id="empFirstName" name="empFirstName" placeholder="Enter first name">
                <label for="empLastName">Last Name:</label>
                <input type="text" id="empLastName" name="empLastName" placeholder="Enter last name">
                <label for="empSSN">Social Security Number:</label>
                <input type="text" id="empSSN" name="empSSN" placeholder="Enter SSN (xxx-xx-xxxx)">
                <label for="empUsername">Username:</label>
                <input type="text" id="empUsername" name="empUsername" placeholder="Enter username">
                <label for="empPassword">Password:</label>
                <input type="password" id="empPassword" name="empPassword" placeholder="Enter password">
                <button type="submit">Submit</button>
            </form>
        </div>

        <!-- Monthly Sales Reports -->
        <div class="section">
            <h3>Monthly Sales Reports</h3>
            <form method="post" action="salesReport.jsp">
                <label for="reportMonth">Select Month:</label>
                <input type="month" id="reportMonth" name="reportMonth" required>
                <button type="submit">Generate Report</button>
            </form>
        </div>

        <!-- Reservations -->
        <div class="section">
            <h3>Reservations</h3>
            <form method="post" action="reservationsList.jsp">
                <label for="reservationType">List Reservations By:</label>
                <select id="reservationType" name="reservationType">
                    <option value="transitLine">Transit Line</option>
                    <option value="customerName">Customer Name</option>
                </select>
                <button type="submit">Generate List</button>
            </form>
        </div>

        <!-- Revenue Listing -->
        <div class="section">
            <h3>Revenue Listing</h3>
            <form method="post" action="revenueListing.jsp">
                <label for="revenueType">List Revenue By:</label>
                <select id="revenueType" name="revenueType">
                    <option value="transitLine">Transit Line</option>
                    <option value="customerName">Customer Name</option>
                </select>
                <button type="submit">Generate Listing</button>
            </form>
        </div>

        <!-- Best Customer -->
        <div class="section">
            <h3>Best Customer</h3>
            <form method="post" action="bestCustomer.jsp">
                <button type="submit">Find Best Customer</button>
            </form>
        </div>

        <!-- Most Active Transit Lines -->
        <div class="section">
            <h3>Most Active Transit Lines</h3>
            <form method="post" action="mostActiveLines.jsp">
                <button type="submit">Find Most Active Lines</button>
            </form>
        </div>
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
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        .section {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
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
        <h2>Admin Dashboard</h2>

        <!-- Manage Employees -->
        <div class="section">
            <h3>Manage Employees</h3>
            <form method="post">
                <label for="empAction">Action:</label>
                <select id="empAction" name="empAction">
                    <option value="add">Add</option>
                    <option value="edit">Edit</option>
                    <option value="delete">Delete</option>
                </select>
                <label for="empFirstName">First Name:</label>
                <input type="text" id="empFirstName" name="empFirstName" placeholder="Enter first name">
                <label for="empLastName">Last Name:</label>
                <input type="text" id="empLastName" name="empLastName" placeholder="Enter last name">
                <label for="empSSN">Social Security Number:</label>
                <input type="text" id="empSSN" name="empSSN" placeholder="Enter SSN (xxx-xx-xxxx)">
                <label for="empUsername">Username:</label>
                <input type="text" id="empUsername" name="empUsername" placeholder="Enter username">
                <label for="empPassword">Password:</label>
                <input type="password" id="empPassword" name="empPassword" placeholder="Enter password">
                <button type="submit">Submit</button>
            </form>
        </div>

        <%
            // Backend logic for managing employees
            String action = request.getParameter("empAction");
            String firstName = request.getParameter("empFirstName");
            String lastName = request.getParameter("empLastName");
            String ssn = request.getParameter("empSSN");
            String username = request.getParameter("empUsername");
            String password = request.getParameter("empPassword");

            if (action != null && ssn != null && !ssn.isEmpty()) {
                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a connection to the database
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");

                    if ("add".equals(action)) {
                        // Add a new employee
                        String query = "INSERT INTO Employees (first_name, last_name, social_security_number, username, password) VALUES (?, ?, ?, ?, ?)";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, firstName);
                        ps.setString(2, lastName);
                        ps.setString(3, ssn);
                        ps.setString(4, username);
                        ps.setString(5, password);
                        ps.executeUpdate();
                        out.println("<p>Employee added successfully.</p>");

                    } else if ("edit".equals(action)) {
                        // Edit an existing employee
                        String query = "UPDATE Employees SET first_name = ?, last_name = ?, username = ?, password = ? WHERE social_security_number = ?";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, firstName);
                        ps.setString(2, lastName);
                        ps.setString(3, username);
                        ps.setString(4, password);
                        ps.setString(5, ssn);
                        int rowsUpdated = ps.executeUpdate();
                        if (rowsUpdated > 0) {
                            out.println("<p>Employee updated successfully.</p>");
                        } else {
                            out.println("<p>Employee not found for the given SSN.</p>");
                        }

                    } else if ("delete".equals(action)) {
                        // Delete an employee
                        String query = "DELETE FROM Employees WHERE social_security_number = ?";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, ssn);
                        int rowsDeleted = ps.executeUpdate();
                        if (rowsDeleted > 0) {
                            out.println("<p>Employee deleted successfully.</p>");
                        } else {
                            out.println("<p>Employee not found for the given SSN.</p>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    // Close resources
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            }
        %>
        
          <!-- Monthly Sales Reports -->
        <div class="section">
            <h3>Monthly Sales Reports</h3>
            <form method="post" action="salesReport.jsp">
                <label for="reportMonth">Select Month:</label>
                <input type="month" id="reportMonth" name="reportMonth" required>
                <button type="submit">Generate Report</button>
            </form>
        </div>

        <!-- Reservations -->
        <div class="section">
            <h3>Reservations</h3>
            <form method="post" action="reservationsList.jsp">
                <label for="reservationType">List Reservations By:</label>
                <select id="reservationType" name="reservationType">
                    <option value="transitLine">Transit Line</option>
                    <option value="customerName">Customer Name</option>
                </select>
                <button type="submit">Generate List</button>
            </form>
        </div>

        <!-- Revenue Listing -->
        <div class="section">
            <h3>Revenue Listing</h3>
            <form method="post" action="revenueListing.jsp">
                <label for="revenueType">List Revenue By:</label>
                <select id="revenueType" name="revenueType">
                    <option value="transitLine">Transit Line</option>
                    <option value="customerName">Customer Name</option>
                </select>
                <button type="submit">Generate Listing</button>
            </form>
        </div>

        <!-- Best Customer -->
        <div class="section">
            <h3>Best Customer</h3>
            <form method="post" action="bestCustomer.jsp">
                <button type="submit">Find Best Customer</button>
            </form>
        </div>

        <!-- Most Active Transit Lines -->
        <div class="section">
            <h3>Most Active Transit Lines</h3>
            <form method="post" action="mostActiveLines.jsp">
                <button type="submit">Find Most Active Lines</button>
            </form>
        </div>
        
        
    </div>
</body>
</html>
 