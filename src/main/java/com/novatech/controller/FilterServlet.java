package com.novatech.controller;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Status;
import com.novatech.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/filter")
public class FilterServlet extends HttpServlet {
    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String statusFilter = req.getParameter("status");
            String sortBy = req.getParameter("sortBy");
            String sortOrder = req.getParameter("sortOrder");

            List<Task> tasks = taskDAO.getAllTasks();

            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("ALL")) {
                Status status = Status.valueOf(statusFilter);
                tasks = tasks.stream()
                        .filter(task -> task.getStatus() == status)
                        .collect(Collectors.toList());
            }

            if (sortBy != null && !sortBy.isEmpty()) {
                if ("dueDate".equals(sortBy)) {
                    if ("desc".equals(sortOrder)) {
                        tasks = tasks.stream()
                                .sorted(Comparator.comparing(Task::getDueDate).reversed())
                                .collect(Collectors.toList());
                    } else {
                        tasks = tasks.stream()
                                .sorted(Comparator.comparing(Task::getDueDate))
                                .collect(Collectors.toList());
                    }
                }
            }

            req.setAttribute("tasks", tasks);
            req.setAttribute("selectedStatus", statusFilter);
            req.setAttribute("sortBy", sortBy);
            req.setAttribute("sortOrder", sortOrder);
            req.getRequestDispatcher("/task-list.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}