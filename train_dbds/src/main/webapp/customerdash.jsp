<%-- <%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
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

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
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
            margin-bottom: 15px; /* Adds space between buttons */
        }

        button:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
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
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Customer Dashboard Container -->
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
        <p>This is your Customer Dashboard.</p>

        <!-- Book Train Button -->
        <form method="get" action="booktrains.jsp">
            <button type="submit">Book Trains</button>
        </form>

        <!-- Logout Form -->
        <form method="post" action="logout.jsp">
            <button type="submit">Logout</button>
        </form>
    </div>

</body>
</html> --%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
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

        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
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
            margin-bottom: 15px; /* Adds space between buttons */
        }

        button:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
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
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        Train Navigation System
    </header>

    <!-- Customer Dashboard Container -->
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
        <p>This is your Customer Dashboard.</p>

        <!-- Book Train Button -->
        <form method="get" action="booktrains.jsp">
            <button type="submit">Book Trains</button>
        </form>

        <!-- Questions Button -->
        <form method="get" action="customer_questions.jsp">
            <button type="submit">Questions</button>
        </form>

        <!-- Search Train Schedules Button -->
        <form method="get" action="searchtrain.jsp">
            <button type="submit">Details</button>
        </form>

        <!-- Logout Form -->
        <form method="post" action="logout.jsp">
            <button type="submit">Logout</button>
        </form>
    </div>

</body>
</html>

