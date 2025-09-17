<%-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Navigation System - Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #007bff;
            background-color: #ffffff;
        }
        button {
            width: 100%;
            padding: 14px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }
        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Login Form Container -->
    <div class="container">
        <h2>Login</h2>

        <form method="post" action="login.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" name="loginType" value="customer">Login as Customer</button>
            <button type="submit" name="loginType" value="employee">Login as Employee</button>
            <button type="submit" name="loginType" value="admin">Login as Admin</button>
        </form>

        <!-- Sign Up Button -->
        <div class="footer">
            <p>New customer? <a href="signup.jsp">Sign Up here</a></p>
        </div>

        <% 
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String loginType = request.getParameter("loginType");

            if (username != null && password != null && loginType != null) {
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    java.sql.Connection conn = java.sql.DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/train_reservation", "john", "password123");

                    String table = "";
                    String redirectPage = "";

                    // Set table and redirection based on login type
                    if (loginType.equals("customer")) {
                        table = "customers";
                        redirectPage = "customerdash.jsp";
                    } else if (loginType.equals("employee")) {
                        table = "employee";
                        redirectPage = "employeedash.jsp";
                    } else if (loginType.equals("admin")) {
                        table = "employee";
                        redirectPage = "admindash.jsp";
                    }

                    String query = "SELECT * FROM " + table + " WHERE Username = ? AND pass = ?";

                    java.sql.PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, username);
                    stmt.setString(2, password);

                    java.sql.ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("username", username);
                        response.sendRedirect(redirectPage);
                    } else {
                        out.println("<p class='error-message'>Invalid username or password.</p>");
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Error connecting to the database.</p>");
                }
            }
        %>
    </div>

</body>
</html> --%>

<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Navigation System - Login</title>
    <style>
         body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: absolute;
            top: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #007bff;
            background-color: #ffffff;
        }
        button {
            width: 100%;
            padding: 14px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }
        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Login Form Container -->
    <div class="container">
        <h2>Login</h2>

        <form method="post" action="login.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" name="loginType" value="customer">Login as Customer</button>
            <button type="submit" name="loginType" value="employee">Login as Employee</button>
            <button type="submit" name="loginType" value="admin">Login as Admin</button>
        </form>

        <!-- Sign Up Button -->
        <div class="footer">
            <p>New customer? <a href="signup.jsp">Sign Up here</a></p>
        </div>

        <% 
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String loginType = request.getParameter("loginType");

            if (username != null && password != null && loginType != null) {
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/train_reservation", "john", "password123");

                    String table = "";
                    String redirectPage = "";

                    // Set table and redirection based on login type
                    if (loginType.equals("customer")) {
                        table = "customers";
                        redirectPage = "customerdash.jsp";
                    } else if (loginType.equals("employee")) {
                        table = "employees";
                        redirectPage = "employeedash.jsp";
                    } else if (loginType.equals("admin")) {
                        table = "admins";
                        redirectPage = "admindash.jsp";
                    }

                    String query = "SELECT * FROM " + table + " WHERE Username = ? AND password = ?";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, username);
                    stmt.setString(2, password);

                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("username", username);
                        response.sendRedirect(redirectPage);
                    } else {
                        out.println("<p class='error-message'>Invalid username or password.</p>");
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (ClassNotFoundException e) {
                    out.println("<p class='error-message'>Database Driver not found.</p>");
                } catch (SQLException e) {
                    out.println("<p class='error-message'>Error connecting to the database: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

</body>
</html>
