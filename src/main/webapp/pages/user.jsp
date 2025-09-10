<%@ page import="java.util.List" %>
<%@ page import="com.mub.models.UserModel" %>
<%@ include file="adminHeader.jsp" %>

<%
    List<UserModel> users = (List<UserModel>) session.getAttribute("users");
%>

<main>
    <h2>User Management</h2>

    <!-- Add Button -->
    <button onclick="openAddModal()" class="add-btn" style="margin-bottom: 20px;">+ Add New User</button>

    <!-- User Table -->
    <table>
        <thead>
            <tr>
                <th>No.</th><th>Name</th><th>Phone</th><th>Address</th><th>Email</th><th>Role</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if (users != null && !users.isEmpty()) {
            	int no = 1;
                for (UserModel u : users) {
            %>
            <tr>
                <td><%= no %></td>
                <td><%= u.name %></td>
                <td><%= u.phone %></td>
                <td><%= u.address %></td>
                <td><%= u.email %></td>
                <td><%= u.role %></td>
                <td>
                    <button class="edit-btn"
                        onclick="openEditModal(<%= u.id %>, '<%= u.name %>', '<%= u.phone %>', '<%= u.address %>', '<%= u.email %>', '<%= u.role %>')">
                        Edit
                    </button>
                    <button class="delete-btn"
                        onclick="openDeleteModal(<%= u.id %>)">
                        Delete
                    </button>
                </td>
            </tr>
            <% no++;}} else { %>
            <tr><td colspan="7">No users found.</td></tr>
            <% } %>
        </tbody>
    </table>
</main>

<!-- Add Modal -->
<div id="addModal" class="modal">
  <div class="modal-content">
    <h3>Add User</h3>
    <form action="/PopWare/UserController" method="post">
      <input type="hidden" name="action" value="add" />
      <input type="text" name="name" placeholder="Name" required />
      <input type="text" name="phone" placeholder="Phone" required />
      <input type="text" name="address" placeholder="Address" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
      <select name="role">
      	<option>admin</option>
      	<option>customer</option>
      </select>
      <div class="modal-buttons">
        <button type="submit" class="confirm-btn">Add</button>
        <button type="button" class="cancel-btn" onclick="closeAddModal()">Cancel</button>
      </div>
    </form>
  </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <h3>Edit User</h3>
    <form action="/PopWare/UserController" method="post">
      <input type="hidden" name="id" id="editId" />
      <input type="hidden" name="action" value="edit" />
      <input type="text" name="name" id="editName" required />
      <input type="text" name="phone" id="editPhone" required />
      <input type="text" name="address" id="editAddress" required />
      <input type="email" name="email" id="editEmail" required />
      <input type="password" name="password" placeholder="Password" />
      <input type="text" name="role" id="editRole" required />
      <div class="modal-buttons">
        <button type="submit" class="confirm-btn">Save</button>
        <button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
      </div>
    </form>
  </div>
</div>

<!-- Delete Modal -->
<div id="deleteModal" class="modal">
  <div class="modal-content">
    <h3>Confirm Delete</h3>
    <p>Are you sure you want to delete this user?</p>
    <form action="/PopWare/UserController" method="post">
      <input type="hidden" name="id" id="deleteId" />
      <input type="hidden" name="action" value="delete" />
      <div class="modal-buttons">
        <button type="submit" class="confirm-btn">Yes, Delete</button>
        <button type="button" class="cancel-btn" onclick="closeDeleteModal()">Cancel</button>
      </div>
    </form>
  </div>
</div>

<!-- JS for Modals -->
<script>
function openAddModal() {
    document.getElementById('addModal').style.display = 'flex';
}
function closeAddModal() {
    document.getElementById('addModal').style.display = 'none';
}
function openEditModal(id, name, phone, address, email, role) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editPhone').value = phone;
    document.getElementById('editAddress').value = address;
    document.getElementById('editEmail').value = email;
    document.getElementById('editRole').value = role;
    document.getElementById('editModal').style.display = 'flex';
}
function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}
function openDeleteModal(id) {
    document.getElementById('deleteId').value = id;
    document.getElementById('deleteModal').style.display = 'flex';
}
function closeDeleteModal() {
    document.getElementById('deleteModal').style.display = 'none';
}
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = 'none';
    }
}
</script>

<%@ include file="footer.jsp" %>
