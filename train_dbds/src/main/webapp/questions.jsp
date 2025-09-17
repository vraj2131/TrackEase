<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Questions</title>
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
        input[type="text"], textarea, select {
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
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        .questions {
            margin-top: 40px;
        }
        .question {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .answer {
            color: #007bff;
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
        <h2>Customer Questions</h2>

        <%-- Submit a New Question --%>
        <form method="post">
            <input type="hidden" name="action" value="ask">
            <label for="question">Your Question:</label>
            <textarea id="question" name="question_text" rows="4" placeholder="Enter your question" required></textarea>
            <button type="submit">Submit Question</button>
        </form>

        <%-- Search Questions --%>
        <form method="post">
            <input type="hidden" name="action" value="search">
            <label for="search">Search Questions:</label>
            <input type="text" id="search" name="search_query" placeholder="Enter keywords to search">
            <button type="submit">Search</button>
        </form>

        <%-- Display Questions and Answers --%>
        <div class="questions">
            <h2>Questions and Answers</h2>
            <% 
                if (request.getParameter("action") != null) {
                    String action = request.getParameter("action");

                    if (action.equals("ask")) {
                        String questionText = request.getParameter("question_text");
                        int customerId = (int) session.getAttribute("customer_id");
                        String insertQuery = "INSERT INTO Questions (customer_id, question_text) VALUES (?, ?)";
                        PreparedStatement psInsert = conn.prepareStatement(insertQuery);
                        psInsert.setInt(1, customerId);
                        psInsert.setString(2, questionText);
                        psInsert.executeUpdate();
                        out.println("<p>Question submitted successfully!</p>");
                    } else if (action.equals("search")) {
                        String searchQuery = request.getParameter("search_query");
                        String searchSQL = "SELECT * FROM Questions WHERE question_text LIKE ?";
                        PreparedStatement psSearch = conn.prepareStatement(searchSQL);
                        psSearch.setString(1, "%" + searchQuery + "%");
                        ResultSet rs = psSearch.executeQuery();

                        while (rs.next()) {
                            out.println("<div class='question'>");
                            out.println("<p><strong>Q:</strong> " + rs.getString("question_text") + "</p>");
                            String answer = rs.getString("answer_text");
                            if (answer != null) {
                                out.println("<p class='answer'><strong>A:</strong> " + answer + "</p>");
                            } else {
                                out.println("<p class='answer'><strong>A:</strong> Not answered yet.</p>");
                            }
                            out.println("</div>");
                        }
                    }
                } else {
                    String fetchQuery = "SELECT * FROM Questions ORDER BY created_at DESC";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(fetchQuery);

                    while (rs.next()) {
                        out.println("<div class='question'>");
                        out.println("<p><strong>Q:</strong> " + rs.getString("question_text") + "</p>");
                        String answer = rs.getString("answer_text");
                        if (answer != null) {
                            out.println("<p class='answer'><strong>A:</strong> " + answer + "</p>");
                        } else {
                            out.println("<p class='answer'><strong>A:</strong> Not answered yet.</p>");
                        }
                        out.println("</div>");
                    }
                }
            %>
        </div>
    </div>
<%
    if (conn != null) {
        conn.close();
    }
%>
</body>
</html>
