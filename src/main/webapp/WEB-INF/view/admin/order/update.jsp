<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Update a order</h3>
                                    <hr />
                                    <form:form method="POST" action="/admin/order/update" modelAttribute="newOrder" enctype="multipart/form-data">
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">Order id:</label>
                                                <p>${newOrder.id}</p>
                                                <form:input type="hidden" path="id" />
                                            </div>

                                            <div class="col-12">
                                                <label class="form-label">Price:</label>
                                                <p><fmt:formatNumber value="${newOrder.totalPrice}" type="number" /> đ</p>
                                                <form:input type="hidden" path="totalPrice" />
                                            </div>
                                        </div>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">User:</label>
                                                <p>${newOrder.user.fullName}</p>
                                            </div>

                                            <div class="col-12">
                                                <label class="form-label">Status:</label>
                                                <form:select class="form-select" aria-label="Default select example" path="status">
                                                    <form:option value="PENDING">PENDING</form:option>
                                                    <form:option value="SHIPPING">SHIPPING</form:option>
                                                    <form:option value="COMPLETE">COMPLETE</form:option>
                                                    <form:option value="CANCEL">CANCEL</form:option>
                                                </form:select>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-4">
                                            <button type="submit" class="btn btn-warning">Update</button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="../layout/footer.jsp" />
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
</body>
</html>