<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Thêm mới sản phẩm</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
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
                                            <h3>Create a product</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/product/create"
                                                modelAttribute="newProduct" enctype="multipart/form-data">
                                                <div class="row g-3">
                                                    <div class="col">
                                                        <c:set var="errorName">
                                                            <form:errors path="name" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label for="name" class="form-label">Name:</label>
                                                        <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="name" />
                                                        ${errorName}
                                                    </div>
                                                    <div class="col">
                                                        <c:set var="errorPrice">
                                                            <form:errors path="price" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label for="price" class="form-label">Price:</label>
                                                        <form:input type="number" class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" path="price" placeholder="0.0"/>
                                                        ${errorPrice}
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <c:set var="errorDetailDesc">
                                                            <form:errors path="detailDesc" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                    <label for="detaildesc" class="form-label">Detail description:</label>
                                                    <form:textarea class="form-control" path="detailDesc"></form:textarea>
                                                    ${errorDetailDesc}
                                                </div>
                                                <div class="row g-3">
                                                    <div class="col">
                                                        <c:set var="errorShortDesc">
                                                            <form:errors path="shortDesc" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label for="shortdesc" class="form-label">Short description:</label>
                                                        <form:input type="text" class="form-control" path="shortDesc" />
                                                        ${errorShortDesc}
                                                    </div>
                                                    <div class="col">
                                                        <c:set var="errorQuantity">
                                                            <form:errors path="quantity" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label for="quantity" class="form-label">Quantity:</label>
                                                        <form:input type="number" class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" path="quantity" placeholder="0"/>
                                                        ${errorQuantity}
                                                    </div>
                                                </div>
                                                <div class="row g-3">
                                                    <div class="col">
                                                        <label class="form-label">Factory:</label>
                                                        <form:select class="form-select"
                                                            aria-label="Default select example" path="factory">
                                                            <form:option value="APPLE">Apple (Macbook)</form:option>
                                                            <form:option value="ACER">Acer</form:option>
                                                            <form:option value="LENOVO">Lenovo</form:option>
                                                            <form:option value="LG">LG</form:option>
                                                            <form:option value="DELL">Dell</form:option>
                                                            <form:option value="ASUS">Asus</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <label class="form-label">Target:</label>
                                                        <form:select class="form-select"
                                                            aria-label="Default select example" path="target">
                                                            <form:option value="GAMING">Gaming</form:option>
                                                            <form:option value="VAN-PHONG">Văn phòng</form:option>
                                                            <form:option value="DO-HOA">Đồ hoạ</form:option>
                                                            <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                        </form:select>
                                                    </div>
                                                </div>
                                                <div class="row g-3">
                                                    <div class="col">
                                                        <label for="avatarFile" class="form-label">Avatar</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg" name="imageProduct" />
                                                    </div>
                                                    <div class="col-12 mb-3 d-flex justify-content-center">
                                                        <img style="max-height: 250px; display: none;"
                                                            alt="avatar preview" id="avatarPreview">
                                                    </div>
                                                </div>
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Create</button>
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
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>