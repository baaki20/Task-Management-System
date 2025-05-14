<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.novatech.model.Status" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Copy the styles from task-list.jsp here */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            color: #343a40;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding-top: 20px;
        }
        header {
            background-color: #4a6fdc;
            color: white;
            padding: 20px 0;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        h1 {
            font-size: 1.8rem;
            font-weight: 600;
            margin: 0;
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            margin-bottom: 20px;
            padding: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #343a40;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 16px;
        }
        button.submit-btn {
            background-color: #4a6fdc;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        button.submit-btn:hover {
            background-color: #6a8be0;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1><i class="fas fa-tasks"></i> Add New Task</h1>
        </div>
    </header>
    <div class="container">
        <div class="card form-section">
            <form action="tasks" method="post">
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="dueDate">Due Date:</label>
                    <input type="date" id="dueDate" name="dueDate" required>
                </div>
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <%
                            for (Status status : Status.values()) {
                        %>
                            <option value="<%= status.name() %>"><%= status.name().replace('_', ' ') %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <button type="submit" class="submit-btn">
                    <i class="fas fa-plus"></i> Add Task
                </button>
            </form>
        </div>
    </div>
</body>
</html>