<%@ page import="com.mub.models.UserModel" %>
<%@ include file="pfheader.jsp" %>

<%
    UserModel currentuser = (UserModel) session.getAttribute("token");
    if (currentuser == null) {
        response.sendRedirect("/PopWare/pages/login.jsp");
        return;
    }
%>

<main>
    <div class="profile-container">
    	<img alt="profile image" src="/PopWare/assets/pf_img/default.png" width="200" height="200">
        <p><strong>Name:</strong> <%= currentuser.name %> </p>
        <p><strong>Email:</strong> <%= currentuser.email %></p>
        <p><strong>Phone:</strong> <%= currentuser.phone %></p>
        <p><strong>Address:</strong> <%= currentuser.address %></p>
        <p><strong>Role:</strong> <%= currentuser.role %></p>
        <button class="edit-btn" onclick="openEditModal()">Edit Profile</button>
    </div>
</main>

<!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <h3>Edit Profile</h3>
        <form action="/PopWare/ProfileController" method="post">
            <input type="hidden" name="id" value="<%= currentuser.id %>" />
            <input type="text" name="name" value="<%= currentuser.name %>" required />
            <input type="text" name="phone" value="<%= currentuser.phone %>" required />
            <input type="text" name="address" value="<%= currentuser.address %>" required />
            <input type="email" name="email" value="<%= currentuser.email %>" required />
            <input type="password" name="password" placeholder="password(optional)"/>
            <div class="modal-buttons">
                <button type="submit" class="confirm-btn">Save</button>
                <button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
function openEditModal() {
    document.getElementById("editModal").style.display = "flex";
}
function closeEditModal() {
    document.getElementById("editModal").style.display = "none";
}
window.onclick = function (event) {
    if (event.target.classList.contains("modal")) {
        event.target.style.display = "none";
    }
}
</script>

<%@ include file="footer.jsp" %>
