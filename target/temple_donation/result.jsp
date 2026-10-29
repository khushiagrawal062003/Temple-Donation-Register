<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Donation Records</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f5f9;
            text-align: center;
            padding: 30px;
        }

        .box {
            background: white;
            padding: 25px;
            margin: 20px auto;
            width: 85%;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            color: #234b70;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: #234b70;
            color: white;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
        }

        tr:nth-child(even) {
            background: #f2f5f9;
        }

        h3 {
            color: green;
        }

        a {
            display: inline-block;
            background: #234b70;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }

        a:hover {
            background: #16334f;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Temple Donation Records</h2>

<%
String url = "jdbc:mysql://localhost:3306/templedb";
String user = "root";
String pass = "root";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, user, pass);

    String sql = "INSERT INTO donation (donor_name, amount, purpose, donated_on) VALUES (?, ?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, request.getParameter("name"));
    ps.setInt(2, Integer.parseInt(request.getParameter("amount")));
    ps.setString(3, request.getParameter("purpose"));
    ps.setDate(4, Date.valueOf(request.getParameter("date")));
    ps.executeUpdate();

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM donation");
    int total = 0;
%>

    <table>
        <tr>
            <th>ID</th>
            <th>Donor Name</th>
            <th>Amount (Rs.)</th>
            <th>Purpose</th>
            <th>Date</th>
        </tr>

        <% while (rs.next()) {
            total += rs.getInt("amount");
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("donor_name") %></td>
            <td><%= rs.getInt("amount") %></td>
            <td><%= rs.getString("purpose") %></td>
            <td><%= rs.getDate("donated_on") %></td>
        </tr>
        <% } %>
    </table>

    <h3>Total Donation: Rs. <%= total %></h3>

<%
    rs.close();
    st.close();
    ps.close();
    con.close();

} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>

    <br><br>
    <a href="index.html">Back to Donation Form</a>
</div>

</body>
</html>