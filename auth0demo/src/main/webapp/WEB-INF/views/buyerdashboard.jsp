<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyer Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesome -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f3f3f3;
        }

        .navbar {
            background-color: #232F3E;
            padding: 10px;
        }

        .navbar .navbar-brand, .navbar .navbar-nav .nav-link {
            color: white;
        }

        .navbar .navbar-brand:hover, .navbar .navbar-nav .nav-link:hover {
            color: #ff9900;
        }

        .dashboard-wrapper {
            display: flex;
        }

        .sidebar {
            width: 250px;
            background-color: #37475A;
            height: 100vh;
            position: sticky;
            top: 0;
            padding: 20px;
        }

        .sidebar a {
            color: white;
            font-size: 18px;
            text-decoration: none;
            display: block;
            padding: 10px 0;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #ff9900;
            color: white;
        }

        .content {
            flex: 1;
            padding: 20px;
        }

        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .card:hover {
            transform: scale(1.05);
            transition: all 0.3s ease;
        }

        .logout-btn {
            background-color: #FF9900;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .logout-btn:hover {
            background-color: #e68a00;
            transform: translateY(-2px);
        }

        /* Responsive for mobile */
        @media(max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .content {
                padding: 10px;
            }
        }
    </style>
</head>
<body>

    <!-- Top Navigation Bar -->
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="/jsp/home2">Flippy</a>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="/jsp/cart"><i class="fas fa-shopping-cart"></i> Cart</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/jsp/orders"><i class="fas fa-box"></i> Orders</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/jsp/profile"><i class="fas fa-user"></i> Profile</a>
            </li>
        </ul>
    </nav>

    <!-- Dashboard layout -->
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <div class="sidebar">
        
            <a href="/jsp/UserProduct"><i class="fas fa-box-open"></i> View Products</a>
              <a href="/jsp/categories"><i class="fas fa-plus"></i> View Categories</a>
            <a href="/jsp/viewOrders"><i class="fas fa-receipt"></i> Check Orders</a>
            <a href="/jsp/profile"><i class="fas fa-user"></i> View Profile</a>
            <a href="/jsp/help"><i class="fas fa-info-circle"></i> Help</a>
        </div>

        <!-- Main content -->
        <div class="content">
            <h1>Welcome to Your Dashboard</h1>

            <!-- Dashboard Cards -->
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fas fa-box fa-3x mb-3"></i>
                            <h5 class="card-title">Your Orders</h5>
                            <a href="/jsp/orders" class="btn btn-primary">View Orders</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fas fa-shopping-cart fa-3x mb-3"></i>
                            <h5 class="card-title">Your Cart</h5>
                            <a href="/jsp/cart" class="btn btn-primary">View Cart</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fas fa-user fa-3x mb-3"></i>
                            <h5 class="card-title">Your Profile</h5>
                            <a href="/jsp/profile" class="btn btn-primary">View Profile</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Logout Section -->
            <div class="mt-5 text-center">
                <button class="logout-btn" onclick="window.location.href='/jsp/home2'">Logout</button>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
