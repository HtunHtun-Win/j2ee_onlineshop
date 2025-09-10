<%@ include file="header.jsp"%>
<!-- Main Content -->

<main>
	<div class="form-container">
		<form action="/PopWare/SendController" method="post">
		<input type="hidden" name="uid" value="<%= user.id %>" required />
            <input type="text" name="title" placeholder="Enter title..." required />

            <!-- 5-line textarea -->
            <textarea name="message" rows="7" placeholder="Enter your message..." required></textarea>

            <button type="submit">Send</button>
        </form>
	</div>
</main>

<%@ include file="footer.jsp"%>
