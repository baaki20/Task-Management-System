<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.novatech.model.Task" %>
<%@ page import="com.novatech.model.Status" %>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        form { margin-bottom: 20px; }
        input, select, textarea { margin: 5px 0; width: 100%; padding: 8px; }
        .form-container { max-width: 500px; }
    </style>
</head>
<body>
    <h1>Task Management System</h1>

    <div class="form-container">
        <form action="tasks" method="post">
            <label>Title:</label>
            <input type="text" name="title" required />

            <label>Description:</label>
            <textarea name="description" rows="3" required></textarea>

            <label>Due Date:</label>
            <input type="date" name="dueDate" required />

            <label>Status:</label>
            <select name="status">
                <%
                    for (Status status : Status.values()) {
                %>
                    <option value="<%= status.name() %>"><%= status.name().replace('_', ' ') %></option>
                <%
                    }
                %>
            </select>

            <input type="submit" value="Add Task" />
        </form>
    </div>

    <h2>All Tasks</h2>
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Created</th>
                <th>Updated</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (tasks != null && !tasks.isEmpty()) {
                    for (Task task : tasks) {
            %>
                <tr>
                    <td><%= task.getTitle() %></td>
                    <td><%= task.getDescription() %></td>
                    <td><%= task.getDueDate() %></td>
                    <td><%= task.getStatus().name().replace('_', ' ') %></td>
                    <td><%= task.getCreatedAt() %></td>
                    <td><%= task.getUpdatedAt() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="6">No tasks found.</td></tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
