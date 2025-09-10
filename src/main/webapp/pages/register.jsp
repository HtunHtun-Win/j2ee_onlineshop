<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop</title>
    <link rel="stylesheet" href="../assets/css/register.css">
</head>
<body>
    <div class="register-container">
        <h2 class="shopname">Shop</h2>
        <form action="/PopWare/UserController" method="post" onsubmit="return validateForm()">
        	<input type="hidden" name="action" value="register">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{11}" required>

            <label for="address">Address:</label>
            <textarea id="address" name="address" required></textarea>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirm_password">Confirm Password:</label>
            <input type="password" id="confirm_password" name="confirm_password" required>

            <button type="submit">Register</button>
        </form>
        <a href="login.jsp">
            <button class="back-btn">Back</button>
        </a>
    </div>
</body>
</html>
