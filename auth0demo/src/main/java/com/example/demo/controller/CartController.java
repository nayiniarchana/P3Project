package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.dto.CartItemDto;
import com.example.demo.dto.CartResponse;
import com.example.demo.service.CartService;

import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    
    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    // Get the cart for a specific user
    @GetMapping("/{userId}")
    public ResponseEntity<CartResponse> getCart(@PathVariable String userId) {
        CartResponse cart = cartService.getCartByUserId(userId);
        return ResponseEntity.ok(cart);
    }
    
    // Add item to cart
    @PostMapping("/{userId}/add")
    public ResponseEntity<CartResponse> addItemToCart(@PathVariable String userId, @RequestBody CartItemDto itemDto) {
        try {
            CartResponse updatedCart = cartService.addItemToCart(userId, itemDto);
            return ResponseEntity.ok(updatedCart);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Remove an item from the cart
    @DeleteMapping("/{userId}/remove")
    public ResponseEntity<CartResponse> removeItemFromCart(@PathVariable String userId, @RequestParam String skuCode) {
        CartResponse updatedCart = cartService.removeItemFromCart(userId, skuCode);
        return ResponseEntity.ok(updatedCart);
    }

    // Clear the cart
    @DeleteMapping("/{userId}/clear")
    public ResponseEntity<Void> clearCart(@PathVariable String userId) {
        cartService.clearCart(userId);
        return ResponseEntity.noContent().build();
    }

    // Update cart item quantity
    @PutMapping("/{userId}/update/{skuCode}")
    public ResponseEntity<CartResponse> updateCartItemQuantity(
            @PathVariable String userId,
            @PathVariable String skuCode,
            @RequestBody Map<String, Integer> requestBody) {

        Integer quantity = requestBody.get("quantity");
        
        if (quantity == null) {
            return ResponseEntity.badRequest().build();
        }

        CartResponse updatedCart = cartService.updateCartItemQuantity(userId, skuCode, quantity);
        return ResponseEntity.ok(updatedCart);
    }
}