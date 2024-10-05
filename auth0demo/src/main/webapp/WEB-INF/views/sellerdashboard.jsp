<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8; 
        }

        /* Navbar styling */
        .navbar {
            background-color: #343a40;
            padding: 15px 20px;
        }

        .navbar-brand {
            color: white;
            font-size: 24px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #00bfff; /* Light blue hover effect */
        }

        /* Dashboard container */
        .dashboard-container {
            margin: 40px auto;
            max-width: 1200px;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .dashboard-container h1 {
            color: #343a40;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Dashboard card layout */
        .dashboard-cards {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .card {
            flex: 1;
            min-width: 250px;
            margin: 15px;
            padding: 20px;
            text-align: center;
            background-color: #007bff;
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        .card i {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .card a {
            color: white;
            font-size: 20px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card a:hover {
            color: #e6e6e6;
        }

        /* Footer */
        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        footer a {
            color: white;
            margin: 0 10px;
            font-size: 20px;
            transition: color 0.3s;
        }

        footer a:hover {
            color: #00bfff;
        }

        .logout-section {
            text-align: center;
            margin-top: 30px;
        }

        .logout-btn {
            padding: 12px 30px;
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #e60000;
            transform: translateY(-5px);
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">Flippy Seller Dashboard</a>
        <div class="navbar-nav ml-auto">
            <a href="/jsp/home2" class="nav-item nav-link">Home</a>
            <a href="/jsp/profile" class="nav-item nav-link">Profile</a>
            <a href="/jsp/help" class="nav-item nav-link">Help</a>
        </div>
    </nav>

    <!-- Dashboard content -->
    <div class="dashboard-container">
        <h1>Welcome to Your Seller Dashboard</h1>
        <div class="dashboard-cards">
            <div class="card">
                <i class="fas fa-box-open"></i>
                <a href="/jsp/createProduct">Add Products</a>
            </div>
            <div class="card">
                <i class="fas fa-list"></i>
                <a href="/jsp/ProductManager">Manage Products</a>
            </div>
            <div class="card">
                <i class="fas fa-shopping-cart"></i>
                <a href="/jsp/viewOrders">Check Orders</a>
            </div>
            <div class="card">
                <i class="fas fa-user"></i>
                <a href="/jsp/profile">View Profile</a>
            </div>
        </div>

        <div class="logout-section">
            <button class="logout-btn" onclick="window.location.href='/jsp/home2'">Logout</button>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Flippy. All rights reserved.</p>
        <div>
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-linkedin"></i></a>
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>