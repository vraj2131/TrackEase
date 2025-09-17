<!-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Train</title>
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

        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            position: fixed;
            top: 0;
        }
        input[type="text"], input[type="date"], input[type="number"], select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
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
        }
        button:hover {
            background-color: #0056b3;
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
         .footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }
        .total-cost {
            font-size: 18px;
            color: #333;
            margin-top: 20px;
        }
        .cancel-reservation, .view-reservations {
            margin-top: 40px;
        }
        /* Hide the return journey section by default */
        #returnJourneySection {
            display: none;
        }
        
           .checkbox-container {
            text-align: left;
            width: 100%;
            margin-bottom: 20px;
        }

        .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
            vertical-align: middle;
        }
    </style>
    <script>
 // Define ticket price
    const ticketPrice = 50; // Price per normal ticket in USD

    function calculateCost() {
        // Get user inputs
        const numAdults = parseInt(document.getElementById("numAdults").value) || 0;
        const numChildren = parseInt(document.getElementById("numChildren").value) || 0;
        const numSeniors = parseInt(document.getElementById("numSeniors").value) || 0;
        const numDisabled = parseInt(document.getElementById("numDisabled").value) || 0;

        // Calculate total cost
        const totalCost =
            numAdults * ticketPrice +
            numChildren * ticketPrice * 0.5 +
            numSeniors * ticketPrice * 0.5 +
            numDisabled * ticketPrice * 0.5;
        

        // Update total cost in UI
        const totalCostElement = document.getElementById("totalCost");
        if (totalCostElement) {
            totalCostElement.textContent = `Total Cost: $${totalCost.toFixed(2)}`;
        } else {
            console.error("Total cost element (#totalCost) not found in the DOM.");
        }
    }

        function toggleReturnJourney() {
            const returnJourneySection = document.getElementById('returnJourneySection');
            if (document.getElementById('returnJourney').checked) {
                returnJourneySection.style.display = 'block';
            } else {
                returnJourneySection.style.display = 'none';
            }
        }

        function validateForm() {
            const travelDate = document.getElementById("travelDate").value;
            const returnDate = document.getElementById("returnDate").value;

            // If return date is selected, validate it
            if (returnDate) {
                // Convert to Date objects for comparison
                const travelDateObj = new Date(travelDate);
                const returnDateObj = new Date(returnDate);

                // If return date is earlier than travel date
                if (returnDateObj < travelDateObj) {
                    alert("Return Date cannot be earlier than Travel Date.");
                    return false; // Prevent form submission
                }
            }

            return true; // Form is valid
        }
    </script>
</head>
<body>

    Header
    <header>
        Train Navigation System
    </header>

    Book Train Form
    <div class="container">
        <h2>Book Your Train</h2>
        <p>Fill in the details below to book your train.</p>

        <form method="post" action="printtickets.jsp" onsubmit="return validateForm()">
            
            Departure Station
            <label for="departure">Departure Station:</label>
            <input type="text" id="departure" name="departure" placeholder="Enter departure station" required>

            Arrival Station
            <label for="arrival">Arrival Station:</label>
            <input type="text" id="arrival" name="arrival" placeholder="Enter arrival station" required>
            
            Travel Date
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required>

            Return Journey Checkbox
            <div class="checkbox-container">
                <label for="returnJourney">
                    <input type="checkbox" id="returnJourney" name="returnJourney" onclick="toggleReturnJourney()"> Return Journey
                </label>
            </div>

            Return Journey Section
            <div id="returnJourneySection">
                <label for="returnDate">Return Date:</label>
                <input type="date" id="returnDate" name="returnDate">
            </div>

            Number of Passengers
<label for="numAdults">Number of Adults:</label>
<input
    type="number"
    id="numAdults"
    name="numAdults"
    min="0"
    placeholder="Enter number of adults"
    required
    oninput="calculateCost()"
/>

<label for="numChildren">Number of Children:</label>
<input
    type="number"
    id="numChildren"
    name="numChildren"
    min="0"
    placeholder="Enter number of children"
    required
    oninput="calculateCost()"
/>

<label for="numSeniors">Number of Senior Citizens:</label>
<input
    type="number"
    id="numSeniors"
    name="numSeniors"
    min="0"
    placeholder="Enter number of senior citizens"
    required
    oninput="calculateCost()"
/>

<label for="numDisabled">Number of Disabled People:</label>
<input
    type="number"
    id="numDisabled"
    name="numDisabled"
    min="0"
    placeholder="Enter number of disabled people"
    required
    oninput="calculateCost()"
/>

Total Cost


            Submit Button
            <button type="submit">Book Train</button>
        </form>
        
        <div class="back">
       <p><a href="customerdash.jsp">Back to Dashboard</a></p>
    </div>
    </div>
    
    

    Cancel Reservation Section
    <div class="container cancel-reservation">
        <h2>Cancel Reservation</h2>
        <form method="post" action="cancelreservation.jsp">
            <label for="reservationId">Reservation ID:</label>
            <input type="text" id="reservationId" name="reservationId" placeholder="Enter reservation ID" required>
            <button type="submit">Cancel Reservation</button>
        </form>
    </div>

    View Reservations Section
    <div class="container view-reservations">
        <h2>View Reservations</h2>
        <button onclick="location.href='currentreservations.jsp'">View Current Reservations</button>
        <button onclick="location.href='pastreservations.jsp'">View Past Reservations</button>
    </div>
</body>
</html>
 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Reservation System</title>
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
        input[type="text"], input[type="date"], input[type="number"], select {
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
        .total-cost {
            font-size: 18px;
            color: #333;
        }
    </style>
    <script>
        const ticketPrice = 50;
        function calculateCost() {
            const numAdults = parseInt(document.getElementById("numAdults").value) || 0;
            const numChildren = parseInt(document.getElementById("numChildren").value) || 0;
            const numSeniors = parseInt(document.getElementById("numSeniors").value) || 0;
            const numDisabled = parseInt(document.getElementById("numDisabled").value) || 0;

            const totalCost = numAdults * ticketPrice + numChildren * ticketPrice * 0.5 + numSeniors * ticketPrice * 0.5 + numDisabled * ticketPrice * 0.5;

            document.getElementById("totalCost").textContent = `Total Cost: $${totalCost.toFixed(2)}`;
        }
    </script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/your_database_name";
    String dbUser = "your_username";
    String dbPass = "your_password";

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if (action.equals("book")) {
                String departure = request.getParameter("departure");
                String arrival = request.getParameter("arrival");
                String travelDate = request.getParameter("travelDate");
                String returnDate = request.getParameter("returnDate");
                int numAdults = Integer.parseInt(request.getParameter("numAdults"));
                int numChildren = Integer.parseInt(request.getParameter("numChildren"));
                int numSeniors = Integer.parseInt(request.getParameter("numSeniors"));
                int numDisabled = Integer.parseInt(request.getParameter("numDisabled"));
                double totalFare = numAdults * 50 + numChildren * 25 + numSeniors * 25 + numDisabled * 25;

                String scheduleQuery = "SELECT schedule_id FROM TrainSchedule WHERE departure_station_id = (SELECT station_id FROM Stations WHERE station_name = ?) AND arrival_station_id = (SELECT station_id FROM Stations WHERE station_name = ?)";
                PreparedStatement psSchedule = conn.prepareStatement(scheduleQuery);
                psSchedule.setString(1, departure);
                psSchedule.setString(2, arrival);
                ResultSet rsSchedule = psSchedule.executeQuery();
                int scheduleId = rsSchedule.next() ? rsSchedule.getInt("schedule_id") : 0;

                int customerId = (int) session.getAttribute("customer_id");

                String insertQuery = "INSERT INTO Reservations (schedule_id, customer_id, reservation_date, total_fare) VALUES (?, ?, ?, ?)";
                PreparedStatement psInsert = conn.prepareStatement(insertQuery);
                psInsert.setInt(1, scheduleId);
                psInsert.setInt(2, customerId);
                psInsert.setDate(3, java.sql.Date.valueOf(travelDate));
                psInsert.setDouble(4, totalFare);
                psInsert.executeUpdate();

                out.println("<p>Reservation successful! Total Fare: $" + totalFare + "</p>");
            } else if (action.equals("cancel")) {
                String reservationId = request.getParameter("reservationId");
                String deleteQuery = "DELETE FROM Reservations WHERE reservation_id = ?";
                PreparedStatement psDelete = conn.prepareStatement(deleteQuery);
                psDelete.setInt(1, Integer.parseInt(reservationId));
                int rowsAffected = psDelete.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Reservation cancelled successfully!</p>");
                } else {
                    out.println("<p>No reservation found with ID: " + reservationId + "</p>");
                }
            } else if (action.equals("view")) {
                String viewType = request.getParameter("viewType");
                int customerId = (int) session.getAttribute("customer_id");
                String query = viewType.equals("current") ? "SELECT * FROM Reservations WHERE reservation_date >= CURDATE() AND customer_id = ?" : "SELECT * FROM Reservations WHERE reservation_date < CURDATE() AND customer_id = ?";
                PreparedStatement psView = conn.prepareStatement(query);
                psView.setInt(1, customerId);
                ResultSet rs = psView.executeQuery();

                out.println("<h2>" + (viewType.equals("current") ? "Current" : "Past") + " Reservations</h2>");
                while (rs.next()) {
                    out.println("<p>Reservation ID: " + rs.getInt("reservation_id") + "</p>");
                    out.println("<p>Total Fare: $" + rs.getDouble("total_fare") + "</p>");
                }
            }
        }
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
    <div class="container">
        <h2>Book Your Train</h2>
        <form method="post">
            <input type="hidden" name="action" value="book">
            <label for="departure">Departure Station:</label>
            <input type="text" id="departure" name="departure" required>
            <label for="arrival">Arrival Station:</label>
            <input type="text" id="arrival" name="arrival" required>
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required>
            <label for="numAdults">Number of Adults:</label>
            <input type="number" id="numAdults" name="numAdults" oninput="calculateCost()" required>
            <label for="numChildren">Number of Children:</label>
            <input type="number" id="numChildren" name="numChildren" oninput="calculateCost()" required>
            <label for="numSeniors">Number of Seniors:</label>
            <input type="number" id="numSeniors" name="numSeniors" oninput="calculateCost()" required>
            <label for="numDisabled">Number of Disabled:</label>
            <input type="number" id="numDisabled" name="numDisabled" oninput="calculateCost()" required>
            <div id="totalCost" class="total-cost">Total Cost: $0.00</div>
            <button type="submit">Book Train</button>
        </form>
    </div>
    <div class="container">
        <h2>Cancel Reservation</h2>
        <form method="post">
            <input type="hidden" name="action" value="cancel">
            <label for="reservationId">Reservation ID:</label>
            <input type="text" id="reservationId" name="reservationId" required>
            <button type="submit">Cancel Reservation</button>
        </form>
    </div>
    <div class="container">
        <h2>View Reservations</h2>
        <form method="post">
            <input type="hidden" name="action" value="view">
            <button type="submit" name="viewType" value="current">View Current Reservations</button>
            <button type="submit" name="viewType" value="past">View Past Reservations</button>
        </form>
    </div>
</body>
</html>
 