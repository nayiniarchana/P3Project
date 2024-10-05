package com.example.demo.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.example.demo.dto.CartItemDto;
import com.example.demo.dto.CartResponse;

@Service
public class CartService {

    private final WebClient webClient;

    @Autowired
    public CartService(WebClient webClient) {
        this.webClient = webClient;
    }

    // Get the cart for a specific user
    public CartResponse getCartByUserId(String userId) {
        System.out.println("Fetching cart for user: " + userId);
        return webClient.get()
            .uri("/api/cart/{userId}", userId)
            .retrieve()
            .bodyToMono(CartResponse.class)
            .block();
    }

    // Add item to the cart or update the cart
    public CartResponse addItemToCart(String userId, CartItemDto itemDto) {
        System.out.println("Adding item to cart for user: " + userId + ", item: " + itemDto);
        return webClient.post()
            .uri("/api/cart/{userId}/add", userId)
            .bodyValue(itemDto)
            .retrieve()
            .bodyToMono(CartResponse.class)
            .block();
    }

    // Remove item from the cart
    public CartResponse removeItemFromCart(String userId, String skuCode) {
        System.out.println("Removing item from cart for user: " + userId + ", SKU Code: " + skuCode);
        return webClient.delete()
            .uri("/api/cart/{userId}/remove?skuCode={skuCode}", userId, skuCode)
            .retrieve()
            .bodyToMono(CartResponse.class)
            .block();
    }

    // Update item quantity in the cart
    public CartResponse updateCartItemQuantity(String userId, String skuCode, int quantity) {
        System.out.println("Updating quantity for user: " + userId + ", SKU Code: " + skuCode + ", New Quantity: " + quantity);
        return webClient.put()
            .uri("/api/cart/{userId}/update/{skuCode}", userId, skuCode)
            .bodyValue(Map.of("quantity", quantity))
            .retrieve()
            .bodyToMono(CartResponse.class)
            .block();
    }

    // Clear the cart for a specific user
    public void clearCart(String userId) {
        System.out.println("Clearing cart for user: " + userId);
        webClient.delete()
            .uri("/api/cart/{userId}/clear", userId)
            .retrieve()
            .bodyToMono(Void.class)
            .block();
    }
}