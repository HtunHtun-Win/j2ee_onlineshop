<%@ page import="java.util.List" %>
<%@ page import="com.mub.models.MessageModel" %>
<%@ include file="adminHeader.jsp" %>

<%
    List<MessageModel> messages = (List<MessageModel>) session.getAttribute("messages");
    String selectedDate = (String) session.getAttribute("selectedDate");
%>

<main>
    <form method="post" action="/PopWare/FeedbackController" class="filter-form">
        <label>Filter by Date:</label>
        <input type="date" name="filterDate" value="<%= selectedDate != null ? selectedDate : "" %>" />
        <button type="submit">Filter</button>
        <a href="/PopWare/FeedbackController"><button type="button">Reset</button></a>
    </form>

    <table class="feedback-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>User</th>
                <th>Title</th>
                <th>Message</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <% if (messages != null && !messages.isEmpty()) {
            	int num = 1;
                for (MessageModel msg : messages) {
            %>
            <tr>
                <td><%= num %></td>
                <td><%= msg.userName != null ? msg.userName : "Anonymous" %></td>
                <td><%= msg.title %></td>
                <td><%= msg.message %></td>
                <td><%= msg.createdAt.toString() %></td>
            </tr>
            <% num++;}} else { %>
            <tr><td colspan="5">No feedback found.</td></tr>
            <% } %>
        </tbody>
    </table>
</main>

<%@ include file="footer.jsp" %>
