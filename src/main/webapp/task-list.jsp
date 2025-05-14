<%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <%@ page import="java.util.List" %>
            <%@ page import="com.novatech.model.Task" %>
            <%@ page import="com.novatech.model.Status" %>
            <%
                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                String selectedStatus = (String) request.getAttribute("selectedStatus");
                if (selectedStatus == null) {
                    selectedStatus = "ALL";
                }
                int currentPage = (int) request.getAttribute("currentPage");
                int totalPages = (int) request.getAttribute("totalPages");
            %>
            <!DOCTYPE html>
            <html>
            <head>
                <title>Task Manager</title>
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
                        max-width: 1200px;
                        margin: 0 auto;
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

                    button, .btn {
                        display: inline-block;
                        font-weight: 400;
                        text-align: center;
                        white-space: nowrap;
                        vertical-align: middle;
                        user-select: none;
                        border: 1px solid transparent;
                        padding: 0.375rem 0.75rem;
                        font-size: 1rem;
                        line-height: 1.5;
                        border-radius: 0.25rem;
                        transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                        cursor: pointer;
                        text-decoration: none;
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
                        width: 100%;
                    }

                    .submit-btn:hover {
                        background-color: var(--primary-light);
                    }

                    .filter-section {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                        flex-wrap: wrap;
                    }

                    .filter-form {
                        display: flex;
                        align-items: center;
                        margin-bottom: 10px;
                    }

                    .filter-form label {
                        margin-right: 10px;
                        margin-bottom: 0;
                    }

                    .filter-form select {
                        width: auto;
                        margin-right: 10px;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                        background-color: white;
                        border-radius: 8px;
                        overflow: hidden;
                        box-shadow: var(--shadow);
                    }

                    th, td {
                        padding: 12px;
                        text-align: left;
                        border-bottom: 1px solid #e9ecef;
                    }

                    th {
                        background-color: var(--primary);
                        color: white;
                        font-weight: 600;
                    }

                    table th, table td {
                        font-size: 14px;
                        white-space: nowrap;
                     }

                    tr:hover {
                        background-color: #f8f9fa;
                    }

                    .status {
                        display: inline-block;
                        padding: 5px 10px;
                        border-radius: 20px;
                        font-size: 14px;
                        font-weight: 500;
                        text-align: center;
                    }

                    .status-PENDING {
                        background-color: var(--warning);
                        color: #333;
                    }

                    .status-IN_PROGRESS {
                        background-color: #17a2b8;
                        color: white;
                    }

                    .status-COMPLETED {
                        background-color: var(--success);
                        color: white;
                    }

                    .actions {
                        display: flex;
                        gap: 10px;
                    }

                    .btn-edit {
                        background-color: var(--warning);
                        color: #333;
                    }

                    .btn-delete {
                        background-color: var(--danger);
                        color: white;
                    }

                    .btn-edit:hover, .btn-delete:hover {
                        opacity: 0.9;
                    }

                    .empty-message {
                        text-align: center;
                        padding: 20px;
                        font-style: italic;
                        color: #6c757d;
                    }

                    .pagination {
                        display: flex;
                        justify-content: center;
                        margin-top: 20px;
                    }

                    .pagination a {
                        margin: 0 5px;
                        padding: 8px 12px;
                        text-decoration: none;
                        color: var(--primary);
                        border: 1px solid var(--primary);
                        border-radius: 4px;
                    }

                    .pagination a.active {
                        background-color: var(--primary);
                        color: white;
                    }

                    /* Responsive design */
                    @media (max-width: 768px) {
                        .container {
                            padding: 10px;
                        }

                        .filter-section {
                            flex-direction: column;
                            align-items: flex-start;
                        }

                        .filter-form {
                            margin-bottom: 10px;
                            width: 100%;
                        }

                        table {
                            display: block;
                            overflow-x: auto;
                            white-space: nowrap;
                        }
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
                        <h2 class="form-title">Add New Task</h2>
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

                    <div class="card">
                        <h2 class="form-title">All Tasks</h2>

                        <div class="filter-section">
                            <form action="filter" method="get" class="filter-form">
                                <label for="status-filter">Filter by Status:</label>
                                <select id="status-filter" name="status" onchange="this.form.submit()">
                                    <option value="ALL" <%= "ALL".equals(selectedStatus) ? "selected" : "" %>>All</option>
                                    <%
                                        for (Status status : Status.values()) {
                                            String selected = status.name().equals(selectedStatus) ? "selected" : "";
                                    %>
                                        <option value="<%= status.name() %>" <%= selected %>><%= status.name().replace('_', ' ') %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </form>
                        </div>

                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Due Date</th>
                                        <th>Status</th>
                                        <th>Created</th>
                                        <th>Actions</th>
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
                                            <td>
                                                <span class="status status-<%= task.getStatus().name() %>">
                                                    <%= task.getStatus().name().replace('_', ' ') %>
                                                </span>
                                            </td>
                                            <td><%= task.getCreatedAt().toLocalDate() %></td>
                                            <td class="actions">
                                                <a href="tasks?action=edit&id=<%= task.getId() %>" class="btn btn-edit">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="#" onclick="confirmDelete(<%= task.getId() %>)" class="btn btn-delete">
                                                    <i class="fas fa-trash"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                        <tr>
                                            <td colspan="6" class="empty-message">No tasks found.</td>
                                        </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>

                        <div class="pagination">
                            <%
                                for (int i = 1; i <= totalPages; i++) {
                            %>
                                <a href="tasks?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>">
                                    <%= i %>
                                </a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

                <script>
                    function confirmDelete(id) {
                        if (confirm('Are you sure you want to delete this task?')) {
                            window.location.href = 'tasks?action=delete&id=' + id;
                        }
                    }

                    document.addEventListener('DOMContentLoaded', function() {
                        const today = new Date().toISOString().split('T')[0];
                        document.getElementById('dueDate').setAttribute('min', today);
                    });
                </script>
            </body>
            </html>