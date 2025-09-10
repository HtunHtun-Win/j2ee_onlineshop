package com.mub.models;

public class UserModel {
	public int id;
	public String name;
	public String phone;
	public String address;
	public String email;
	public String role;
	
	
	public UserModel(int id,String name,String phone,String address,String email,String role) {
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.role = role;
	}
}
