package com.mub.models;

public class CartItem {
	public int productId;
	public String name;
	public String image;
	public int quantity;
	public double price;

	public CartItem(int productId, String name, String image, int quantity, double price) {
		this.productId = productId;
		this.name = name;
		this.image = image;
		this.quantity = quantity;
		this.price = price;
	}

	public double getTotal() {
		return price * quantity;
	}
}
