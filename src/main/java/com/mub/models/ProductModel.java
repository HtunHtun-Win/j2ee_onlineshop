package com.mub.models;

public class ProductModel {
	public int id;
	public String name;
	public String sku;
	public String image;
	public String description;
	public int price;
	public int quantity;
	public int cat_id;

	public ProductModel(int id, String name, String sku, String image, String description, int price, int quantity,
			int cat_id) {
		this.id = id;
		this.name = name;
		this.sku = sku;
		this.image = image;
		this.description = description==null ? "-" : description;
		this.price = price;
		this.quantity = quantity;
		this.cat_id = cat_id;
	}
}
