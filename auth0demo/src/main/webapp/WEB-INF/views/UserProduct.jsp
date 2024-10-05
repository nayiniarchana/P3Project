<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .product-card {
            margin: 10px;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .product-image {
            width: 100%;
            height: auto;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="my-4">View Products</h2>

    <div class="mb-4 input-group">
        <input type="text" id="searchInput" class="form-control" placeholder="Search for products...">
        <div class="input-group-append">
            <button class="btn btn-primary" onclick="searchProducts()">Search</button>
        </div>
    </div>

    <div id="productsList" class="row">
        <!-- Dynamic product cards will be added here -->
    </div>
</div>

<script>
    // Get userId from session and store it in a variable
    const userId = '<%= session.getAttribute("userId") %>'; // Retrieve userId from session
    const cart = []; // Initialize an empty cart array

    // Fetch products automatically on page load
    window.onload = function() {
        fetchProducts();
    };

    function fetchProducts() {
        fetch('http://localhost:9000/api/product')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                return response.json();
            })
            .then(products => {
                renderProducts(products);
            })
            .catch(error => console.error('Error fetching products:', error));
    }

    function renderProducts(products) {
        const productsContainer = document.querySelector('#productsList');
        productsContainer.innerHTML = ''; // Clear previous products

        // Log userId to the console
        console.log("User ID:", userId); // Log userId to the console

        products.forEach(product => {
            const productCard = document.createElement('div');
            productCard.classList.add('col-md-3', 'product-card');
            productCard.innerHTML = `
                <img src="\${product.imageurl}" alt="\${product.name}" class="product-image" onerror="this.onerror=null; this.src='path/to/placeholder-image.jpg';">
                <h5>\${product.name}</h5>
                <div class="product-price">₹\${product.price.toFixed(2)}</div>
                <div class="product-description">\${product.description}</div>
                <div>SKU: \${product.skuCode}</div>
                <button class="btn btn-success mt-2" onclick="addToCart('\${product.id}')">Add to Cart</button>
            `;
            productsContainer.appendChild(productCard);
        });
    }

    function addToCart(productId, name, skuCode, price, imageurl = '') {
        console.log('Adding to cart - Product ID:', productId);
        const itemDto = {
            productId: productId,
            name: name,
            skuCode: skuCode,
            price: price,
            imageurl: imageurl || 'default-image-url.jpg', // Add imageurl here
            quantity: 1
        };
        const cart = {
        		userId: `${userId}`,
        		cartItems : [itemDto]
        		
        }
        
        console.log(cart);

        if (!userId) {
            alert('User is not logged in. Please log in to add items to the cart.');
            return;
        }

        fetch(`http://localhost:8086/api/cart/\${userId}/add`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(cart)
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => { throw new Error(text); });
            }
            return response.json();
        })
        .then(updatedCart => {
            console.log('Item added to cart:', updatedCart);
            alert('Item added to cart!');
        })
        .catch(error => {
            console.error('Error adding item to cart:', error);
            alert('Successfully added.');
        });
    }

    function buyNow(productId) {
        window.location.href = `http://localhost/jsp/BuyNow.jsp?productId=\${productId}`;
    }
</script>

</body>
</html>