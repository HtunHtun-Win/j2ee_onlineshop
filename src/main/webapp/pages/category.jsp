<%@page import="com.mub.models.CategoryModel"%>
<%@page import="java.util.List"%>
<%@ include file="adminHeader.jsp"%>
<!-- Main Content -->
<%
List<CategoryModel> categories = (List<CategoryModel>) session.getAttribute("categories");
%>
<main>

	<button type="button" class="add-btn" onclick="openAddModal()">
		Add New Category
	</button>
	<!-- Category Table -->
	<table border="1" cellpadding="10" cellspacing="0">
		<thead>
			<tr>
				<th>Category Name</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (categories != null) {
				for (CategoryModel cat : categories) {
			%>
			<tr>
				<td><%=cat.name%></td>
				<td>
					<button type="button" class="edit-btn"
						onclick="openEditModal(<%=cat.id%>, '<%=cat.name%>')">
						Edit
					</button>

					<button type="button" class="delete-btn"
						onclick="openDeleteModal(<%=cat.id%>)">
						Delete
					</button>
				</td>
			</tr>
			<%
			}
			}
			%>
		</tbody>
	</table>
</main>
<div id="addModal" class="modal">
	<div class="modal-content">
		<h3>Add Category</h3>
		<form action="/PopWare/CategoryController" method="post">
			<input type="text" name="name" required />
			<div class="modal-buttons">
				<button type="submit" class="confirm-btn">Save</button>
				<button type="button" class="cancel-btn" onclick="closeAddModal()">Cancel</button>
			</div>
		</form>
	</div>
</div>
<div id="editModal" class="modal">
	<div class="modal-content">
		<h3>Edit Category</h3>
		<form action="/PopWare/CategoryController" method="post">
			<input type="hidden" name="id" id="editId" /> <input type="hidden"
				name="action" value="edit" /> <input type="text" name="name"
				id="editName" required />
			<div class="modal-buttons">
				<button type="submit" class="confirm-btn">Save</button>
				<button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
			</div>
		</form>
	</div>
</div>
<div id="deleteModal" class="modal">
	<div class="modal-content">
		<h3>Confirm Delete</h3>
		<p>Are you sure you want to delete this category?</p>
		<form action="/PopWare/CategoryController?action=delete" method="post">
			<input type="hidden" name="id" id="deleteId" /> <input type="hidden"
				name="action" value="delete" />
			<div class="modal-buttons">
				<button type="submit" class="confirm-btn">Yes, Delete</button>
				<button type="button" class="cancel-btn"
					onclick="closeDeleteModal()">Cancel</button>
			</div>
		</form>
	</div>
</div>
<script>

function openAddModal() {
	document.getElementById('addModal').style.display = 'block';
}

function closeAddModal() {
	document.getElementById('addModal').style.display = 'none';
}

function openEditModal(id, name) {
  document.getElementById('editId').value = id;
  document.getElementById('editName').value = name;
  document.getElementById('editModal').style.display = 'block';
}

function closeEditModal() {
  document.getElementById('editModal').style.display = 'none';
}

function openDeleteModal(id) {
  document.getElementById('deleteId').value = id;
  document.getElementById('deleteModal').style.display = 'block';
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

<%@ include file="footer.jsp"%>
