<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .cart-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .cart-item {
            display: flex;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            align-items: center;
        }
        .item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        button {
            margin: 5px;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .update-btn {
            background-color: #4CAF50;
            color: white;
        }
        .remove-btn {
            background-color: #f44336;
            color: white;
        }
        .wishlist-btn {
            background-color: #2196F3;
            color: white;
        }
        button:hover {
            opacity: 0.8;
        }
        #checkout-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #FF9800;
            color: white;
            font-size: 18px;
            margin-top: 20px;
        }
        input[type="number"] {
            width: 50px;
            padding: 5px;
        }
        #total-price {
            text-align: right;
            font-size: 1.2em;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="cart-container">
    <h1>Your Cart</h1>
    <div id="cart-items"></div>
    <div id="total-price"></div>
    <form id="checkout-form" action="/api/order" method="post">
        <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
        <label>Enter Billing Address</label>
        <input type="text" name="billingAddress" placeholder="Enter Billing Address" required>
        <label>Enter Shipping Address</label>
        <input type="text" name="shippingAddress" placeholder="Enter Shipping Address" required>
        <input type="hidden" name="orderLineItems" id="orderLineItems">
        <button type="button" id="checkout-button">Proceed to Checkout</button>
    </form>
</div>

<script>
    const userId = '<%= session.getAttribute("userId") %>';

    document.addEventListener('DOMContentLoaded', function () {
        fetchCartItems();

        document.getElementById('checkout-button').addEventListener('click', function() {
            prepareCheckout();
        });
    });

    function fetchCartItems() {
        fetch(`http://localhost:8086/api/cart/\${userId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                displayCartItems(data);
            })
            .catch(error => {
                console.error('Error fetching cart items:', error);
                document.getElementById('cart-items').innerHTML = '<p>Error loading cart. Please try again later.</p>';
            });
    }

    function displayCartItems(cart) {
        const cartItemsDiv = document.getElementById('cart-items');
        const totalPriceDiv = document.getElementById('total-price');

        if (cart && cart.cartItems && cart.cartItems.length > 0) {
            let totalPrice = 0;
            cartItemsDiv.innerHTML = '';
            cart.cartItems.forEach(item => {
                const price = item.price || 0;
                const quantity = item.quantity || 0;
                totalPrice += price * quantity;

                const itemDiv = document.createElement('div');
                itemDiv.classList.add('cart-item');
                itemDiv.innerHTML = `
                    <img src="/api/placeholder/100/100" alt="\${item.name}" class="item-image">
                    <div class="item-details">
                        <h3>\${item.name || 'Unknown Item'} \${item.skuCode ? `(\${item.skuCode})` : ''}</h3>
                        <p>Price: ₹\${price.toFixed(2)}</p>
                        <p>
                            Quantity: 
                            <input type="number" value="\${quantity}" min="1" id="quantity-\${item.skuCode}">
                            <button class="update-btn" onclick="updateQuantity('\${item.skuCode}')">Update</button>
                        </p>
                        <p>Subtotal: ₹\${(price * quantity).toFixed(2)}</p>
                    </div>
                    <div class="item-actions">
                        <button class="remove-btn" onclick="removeItem('\${userId}', '\${item.skuCode}')">Remove</button>
                        <button class="wishlist-btn" onclick="addToWishlist('\${item.skuCode}')">Add to Wishlist</button>
                    </div>
                `;
                cartItemsDiv.appendChild(itemDiv);
            });
            totalPriceDiv.innerHTML = `<h2>Total Price: ₹\${totalPrice.toFixed(2)}</h2>`;
        } else {
            cartItemsDiv.innerHTML = '<p>Your cart is empty.</p>';
            totalPriceDiv.innerHTML = '';
        }
    }

    function prepareCheckout() {
        // Get the billing and shipping address input values
        const billingAddress = document.querySelector('input[name="billingAddress"]').value.trim();
        const shippingAddress = document.querySelector('input[name="shippingAddress"]').value.trim();

        // Check if either field is empty
        if (!billingAddress || !shippingAddress) {
            alert('Please enter both billing and shipping addresses before proceeding to checkout.');
            return; // Stop further execution
        }

        const cartItems = [];
        const cartItemElements = document.querySelectorAll('.cart-item');

        cartItemElements.forEach(item => {
            const id = 1; // Placeholder for item ID
            const name = item.querySelector('.item-details h3').textContent.split(' ')[0]; // Extracting the item name
            const skuCode = item.querySelector('.item-details h3').textContent.match(/\((.*?)\)/)[1]; // Extracting the SKU code
            const price = parseFloat(item.querySelector('.item-details p:nth-of-type(1)').textContent.replace('Price: ₹', '')); // Extracting the price
            const quantity = parseInt(document.getElementById(`quantity-\${skuCode}`).value); // Extracting the quantity

            // Push the item details into the orderLineItems array
            cartItems.push({
                id: id,
                name: name,
                skuCode: skuCode,
                price: price,
                quantity: quantity
            });
        });

        // Prepare the order data including the updated structure of orderLineItems
        const orderData = {
            orderStatus: 'PENDING', // Setting order status to PENDING
            userId: userId,  // Assuming userId is fetched from session
            billingAddress: billingAddress, // Use actual value from the input field
            shippingAddress: shippingAddress, // Use actual value from the input field
            orderLineItems: cartItems
        };

        // Log the orderData for debugging
        console.log("Order data being sent to OrderController:", JSON.stringify(orderData));

        // Send the order data to the order service (API endpoint)
        fetch('http://localhost:9000/api/order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData)
        })
        .then(response => {
            if (response.ok) {
                alert('Order placed successfully!');
                window.location.href = '/';  // Redirect to a confirmation page
            } else {
                alert('Failed to place order. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error placing order:', error);
            alert('An error occurred while placing the order.');
        });
    }

    function removeItem(userId, skuCode) {
        fetch(`http://localhost:8086/api/cart/\${userId}/remove?skuCode=\${skuCode}`, { method: 'DELETE' })
            .then(response => {
                if (response.ok) {
                    fetchCartItems(); // Refresh cart items
                } else {
                    alert('Failed to remove item from cart. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error removing item:', error);
                alert('An error occurred while removing the item.');
            });
    }

    function updateQuantity(skuCode) {
    	const quantityInput = document.getElementById(`quantity-\${skuCode}`);
        const quantity = parseInt(quantityInput.value);        
        if (isNaN(quantity) || quantity <= 0) {
            alert('Please enter a valid quantity.');
            return;
        }
        
        fetch(`http://localhost:8086/api/cart/\${userId}/update/\${skuCode}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ quantity }) // Only send quantity in the body
        })
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                return response.text().then(text => { throw new Error(text); });
            }
        })
        .then(updatedCart => {
            console.log('Quantity updated successfully:', updatedCart);
            fetchCartItems(); // Refresh cart items
        })
        .catch(error => {
            console.error('Error updating quantity:', error);
        });
    }
    
    function addToWishlist(skuCode) {
        fetch(`http://localhost:8086/api/wishlist/\${userId}/add`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ skuCode })
        })
        .then(response => {
            if (response.ok) {
                alert('Item added to wishlist successfully!');
            } else {
                alert('Failed to add item to wishlist. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error adding to wishlist:', error);
            alert('An error occurred while adding to wishlist.');
        });
    }
</script>
</body>
</html>
