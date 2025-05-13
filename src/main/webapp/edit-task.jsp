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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4a6fdc;
            --primary-light: #6a8be0;
            --secondary: #e9ecef;
            --dark: #343a40;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --light: #f8f9fa;
            --shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            color: var(--dark);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: var(--primary);
            color: white;
            padding: 20px 0;
            box-shadow: var(--shadow);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        h1 {
            font-size: 1.8rem;
            font-weight: 600;
            margin: 0;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-bottom: 20px;
            padding: 20px;
        }

        .form-section {
            margin-top: 30px;
        }

        .form-title {
            color: var(--dark);
            font-size: 1.5rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--secondary);
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: var(--dark);
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        input:focus, select:focus, textarea:focus {
            border-color: var(--primary);
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(74, 111, 220, 0.25);
        }

        .button-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .submit-btn {
            background-color: var(--primary);
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .submit-btn:hover {
            background-color: var(--primary-light);
        }

        .cancel-btn {
            background-color: #6c757d;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            text-decoration: none;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .cancel-btn:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1><i class="fas fa-tasks"></i> Task Management System</h1>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="card form-section">
            <h2 class="form-title">Edit Task</h2>
            <form action="tasks" method="post">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="<%= task.getId() %>"/>

                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" value="<%= task.getTitle() %>" required/>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="3" required><%= task.getDescription() %></textarea>
                </div>

                <div class="form-group">
                    <label for="dueDate">Due Date:</label>
                    <input type="date" id="dueDate" name="dueDate" value="<%= task.getDueDate() %>" required/>
                </div>

                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <%
                            for (Status status : Status.values()) {
                                String selected = task.getStatus() == status ? "selected" : "";
                        %>
                            <option value="<%= status.name() %>" <%= selected %>><%= status.name().replace('_', ' ') %></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="button-container">
                    <a href="tasks" class="cancel-btn">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> Update Task
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>