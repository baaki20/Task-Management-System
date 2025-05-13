<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.novatech.model.Task" %>
<%@ page import="com.novatech.model.Status" %>
<%
    Task task = (Task) request.getAttribute("task");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
</head>
<body>
    <h2>Edit Task</h2>
    <form action="tasks" method="post">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="id" value="<%= task.getId() %>"/>

        <label>Title:</label>
        <input type="text" name="title" value="<%= task.getTitle() %>" required/><br/>

        <label>Description:</label>
        <textarea name="description" rows="3" required><%= task.getDescription() %></textarea><br/>

        <label>Due Date:</label>
        <input type="date" name="dueDate" value="<%= task.getDueDate() %>" required/><br/>

        <label>Status:</label>
        <select name="status">
            <%
                for (Status status : Status.values()) {
                    String selected = task.getStatus() == status ? "selected" : "";
            %>
                <option value="<%= status.name() %>" <%= selected %>><%= status.name().replace('_', ' ') %></option>
            <%
                }
            %>
        </select><br/>

        <input type="submit" value="Update Task"/>
    </form>
</body>
</html>
