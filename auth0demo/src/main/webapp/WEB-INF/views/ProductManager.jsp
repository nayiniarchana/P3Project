<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        .dashboard-item {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 20px;
        }

        .product-card {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            margin: 10px;
            padding: 10px;
            text-align: center;
            width: 200px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }

        .product-price {
            font-size: 18px;
            color: #28a745;
            margin: 10px 0;
        }

        .product-description {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
        }

        .action-button {
            margin: 5px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .action-button:hover {
            background-color: #0056b3;
        }

        .search-box {
            display: flex;
            justify-content: flex-start;
            gap: 10px;
        }

        .search-input {
            width: 200px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .search-button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
        }

        .search-button:hover {
            background-color: #218838;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 5px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <div class="dashboard-item">
        <h2>View Products</h2>

        <!-- Search form -->
        <div class="search-box">
            <input type="text" id="searchInput" class="search-input" placeholder="Search products..." />
            <button class="search-button" onclick="searchProducts()">Search</button>
        </div>
    </div>

    <div id="productsList" class="product-container">
        <!-- Dynamic product cards will be added here -->
    </div>

    <!-- Modal for Adding Stock -->
    <div id="addStockModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="document.getElementById('addStockModal').style.display='none'">&times;</span>
            <h2>Add to Stock</h2>
            <form id="addStockForm">
                <label for="productId">Product ID:</label><br>
                <input type="text" id="modalProductId" required ><br>

                <label for="productName">Product Name:</label><br>
                <input type="text" id="modalProductName" required><br>

                <label for="skuCode">SKU Code:</label><br>
                <input type="text" id="modalSkuCode" required><br>

                <label for="userId">User ID:</label><br>
                <input type="text" id="modalUserId" required><br>

                <label for="quantity">Quantity:</label><br>
                <input type="number" id="modalQuantity" required min="1"><br>

                <button type="submit">Submit</button>
            </form>
        </div>
    </div>

    <script>
        // Fetch products automatically on page load
        window.onload = function() {
            fetchProducts();
        };

        function fetchProducts() {
            fetch('http://localhost:9000/api/product')
                .then(response => response.json())
                .then(products => {
                    window.productsData = products; // Store products data for search functionality
                    displayProducts(products);
                })
                .catch(error => console.error('Error fetching products:', error));
        }

        function displayProducts(products) {
            const productsContainer = document.querySelector('#productsList');
            productsContainer.innerHTML = ''; // Clear previous products
            products.forEach(product => {
                const productCard = document.createElement('div');
                productCard.classList.add('product-card');
                productCard.innerHTML = `
                    <img src="\${product.imageurl}" alt="\${product.name}" class="product-image" onerror="this.onerror=null; this.src='path/to/placeholder-image.jpg';">
                    <h3>\${product.name}</h3>
                    <div class="product-price">&#8377;\${product.price.toFixed(2)}</div>
                    <div class="product-description">\${product.description}</div>
                    <div>SKU: \${product.skuCode}</div>
                    <button class="action-button" onclick="updateProduct(${product.id})">Edit</button>
                    <button class="action-button" onclick="deleteProduct(${product.id})">Delete</button>
                    <button class="action-button" onclick="openAddStockModal(${product.id})">Add to Stock</button>
                `;
                productsContainer.appendChild(productCard);
            });
        }

        function searchProducts() {
            const searchInput = document.getElementById('searchInput').value.toLowerCase();

            const filteredProducts = window.productsData.filter(product =>
                product.name.toLowerCase().includes(searchInput)
            );

            displayProducts(filteredProducts);
        }

        function openAddStockModal(productId) {
            document.getElementById('modalProductId').value = productId; // Set the product ID in the modal
            document.getElementById('addStockModal').style.display = 'block'; // Show the modal
        }

        document.getElementById('addStockForm').onsubmit = async function(event) {
            event.preventDefault(); // Prevent the default form submission

            const productId = document.getElementById('modalProductId').value;
            const quantity = document.getElementById('modalQuantity').value;

            try {
                const response = await fetch("http://localhost:8083/api/inventory", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ productId, quantity }),
                });

                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }

                alert('Stock added successfully!');
                document.getElementById('addStockModal').style.display = 'none'; // Close the modal
                document.getElementById('addStockForm').reset(); // Reset form
            } catch (error) {
                console.error('Error adding stock:', error);
                alert('Failed to add stock. Please try again later.');
            }
        };

        function updateProduct(productId) {
            window.location.href = `/editProduct?id=${productId}`;
        }

        function deleteProduct(productId) {
            // Call delete product API
        }
    </script>

</body>
</html>
