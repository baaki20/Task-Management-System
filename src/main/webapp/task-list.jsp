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
    String sort = (String) request.getAttribute("sort");
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
                padding-top: 20px;
                font-weight: 500;
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
                background-color: var(--light);
                border-radius: 8px;
                box-shadow: var(--shadow);
                margin-bottom: 20px;
                padding: 20px;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .btn-add-task {
                background-color: var(--primary);
                color: white;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 4px;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .btn-add-task:hover {
                background-color: var(--primary-light);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: var(--light);
                border-radius: 8px;
                overflow: hidden;
                box-shadow: var(--shadow);
            }

            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid var(--secondary);
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
                background-color: var(--secondary);
            }

            .status {
                display: inline-block;
                padding: 5px 20px;
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

            .actions a {
                display: inline-block;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 4px;
                text-decoration: none;
                color: white;
                transition: background-color 0.3s;
            }

            .btn-edit {
                background-color: var(--warning);
                color: #333;
            }

            .btn-delete {
                background-color: var(--danger);
                color: white;
            }

            .btn-edit:hover {
                background-color: #e0a800;
            }

            .btn-delete:hover {
                background-color: #c82333;
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

            .sort-link {
                text-decoration: none;
                font-size: 12px;
                color: white;
                font-weight: bold;
            }

            .sort-link:hover {
                color: green;
            }

            .filter-form {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .filter-form label {
                font-weight: bold;
                color: var(--dark);
            }

            .filter-form select {
                padding: 8px 12px;
                border: 1px solid var(--secondary);
                border-radius: 4px;
                font-size: 14px;
                background-color: var(--light);
                color: var(--dark);
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .filter-form select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 5px rgba(74, 111, 220, 0.5);
                outline: none;
            }

            .filter-form select:hover {
                border-color: var(--primary-light);
            }

            .dark-mode-toggle {
                background-color: var(--primary-light);
                color: white;
                padding: 8px 16px;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                border: none;
                transition: background-color 0.3s, transform 0.2s;
            }

            .dark-mode-toggle:hover {
                background-color: var(--primary);
                transform: scale(1.05);
            }

            .dark-mode-toggle:active {
                transform: scale(0.95);
            }

            body.dark-mode {
                background-color: #121212;
                color: #e0e0e0;
            }

            body.dark-mode header {
                background-color: #1f1f1f;
            }

            body.dark-mode .card {
                background-color: #1e1e1e;
                color: #e0e0e0;
            }

            body.dark-mode table {
                background-color: #1e1e1e;
                color: #e0e0e0;
            }

            body.dark-mode th {
                background-color: #333333;
            }

            body.dark-mode .btn-add-task {
                background-color: #333333;
                color: #e0e0e0;
            }

            body.dark-mode .btn-add-task:hover {
                background-color: #444444;
            }

            body.dark-mode .dark-mode-toggle {
                background-color: #333333;
                color: #e0e0e0;
            }

            body.dark-mode .dark-mode-toggle:hover {
                background-color: #444444;
            }

            body.dark-mode .pagination a {
                color: #e0e0e0;
                border-color: #444444;
            }

            body.dark-mode .pagination a.active {
                background-color: #444444;
            }

            body.dark-mode .filter-form select {
                background-color: #333333;
                color: #e0e0e0;
                border-color: #444444;
            }

            body.dark-mode .filter-form select:focus {
                border-color: #555555;
                box-shadow: 0 0 5px rgba(85, 85, 85, 0.5);
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
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
                    <button class="dark-mode-toggle" onclick="toggleDarkMode()">Toggle Dark Mode</button>                </div>
            </div>
        </header>

        <div class="container">
            <div class="card">
                <div class="table-header">
                    <h2>All Tasks</h2>
                    <a href="add-task.jsp" class="btn-add-task">
                        <i class="fas fa-plus"></i> Add Task
                    </a>
                </div>
                <form method="get" action="tasks" class="filter-form">
                    <label for="status">Filter by Status:</label>
                    <select name="status" id="status" onchange="this.form.submit()">
                        <option value="ALL" <%= "ALL".equals(selectedStatus) ? "selected" : "" %>>All</option>
                        <option value="PENDING" <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
                        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(selectedStatus) ? "selected" : "" %>>In Progress</option>
                        <option value="COMPLETED" <%= "COMPLETED".equals(selectedStatus) ? "selected" : "" %>>Completed</option>
                    </select>
                </form>

                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Description</th>
                                <th>
                                    Due Date
                                    <a href="tasks?sort=asc&status=<%= selectedStatus %>" class="sort-link">▲</a>
                                    <a href="tasks?sort=desc&status=<%= selectedStatus %>" class="sort-link">▼</a>
                                </th>
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
            function toggleDarkMode() {
                const body = document.body;
                body.classList.toggle('dark-mode');
                localStorage.setItem('darkMode', body.classList.contains('dark-mode'));
            }

            window.onload = function () {
                if (localStorage.getItem('darkMode') === 'true') {
                    document.body.classList.add('dark-mode');
                }
            };
            function confirmDelete(id) {
                if (confirm('Are    you sure you want to delete this task?')) {
                    window.location.href = 'tasks?action=delete&id=' + id;
                }
            }
        </script>
    </body>
</html>
