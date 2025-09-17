<%@ page import="java.sql.*" %>
<%
    String action = request.getParameter("empAction");
    String firstName = request.getParameter("empFirstName");
    String lastName = request.getParameter("empLastName");
    String ssn = request.getParameter("empSSN");
    String username = request.getParameter("empUsername");
    String password = request.getParameter("empPassword");
    int adminId = 1; // Replace with session-based admin ID for real implementation.

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/train_reservation", "john", "password123");

        if ("add".equals(action)) {
            String query = "INSERT INTO Employees (first_name, last_name, social_security_number, username, password, created_by_admin_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, ssn);
            ps.setString(4, username);
            ps.setString(5, password);
            ps.setInt(6, adminId);
            ps.executeUpdate();
            out.println("<p>Employee added successfully.</p>");
        } else if ("edit".equals(action)) {
            String query = "UPDATE Employees SET first_name = ?, last_name = ?, social_security_number = ?, username = ?, password = ? WHERE social_security_number = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, ssn);
            ps.setString(4, username);
            ps.setString(5, password);
            ps.setString(6, ssn);
            ps.executeUpdate();
            out.println("<p>Employee updated successfully.</p>");
        } else if ("delete".equals(action)) {
            String query = "DELETE FROM Employees WHERE social_security_number = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, ssn);
            ps.executeUpdate();
            out.println("<p>Employee deleted successfully.</p>");
        }
        conn.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
