<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4a6fdc;
            --primary-light: #6a8be0;
            --dark: #343a40;
            --light: #f8f9fa;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dark);
        }

        .splash-container {
            text-align: center;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
        }

        h1 {
            color: var(--primary);
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            color: #6c757d;
        }

        .cta-button {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 12px 24px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 1.1rem;
            transition: background-color 0.3s;
        }

        .cta-button:hover {
            background-color: var(--primary-light);
        }

        .icon {
            font-size: 4rem;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .company-name {
            font-size: 1.2rem;
            margin-top: 30px;
            color: #6c757d;
        }
    </style>

</head>
<body>
    <div class="splash-container">
        <div class="icon">
            <i class="fas fa-tasks"></i>
        </div>
        <h1>Task Management System</h1>
        <p>Streamline your workflow, increase productivity, and never miss a deadline again.</p>
        <a href="tasks" class="cta-button">Get Started <i class="fas fa-arrow-right"></i></a>
        <div class="company-name">
            <p>NovaTech Solutions</p>
        </div>
    </div>
</body>
</html>