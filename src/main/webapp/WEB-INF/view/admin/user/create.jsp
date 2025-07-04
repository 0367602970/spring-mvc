<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm mới người dùng</title>
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
                $("#avatarPreview").css({ "display" : "block" });
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
                                    <h3>Create a user</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/user/create" modelAttribute="newUser" enctype="multipart/form-data">
                                        <div class="row g-3">
                                            <div class="col">
                                                <c:set var="errorEmail">
                                                    <form:errors path="email" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <label for="email" class="form-label">Email:</label>
                                                <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" path="email"/>
                                                ${errorEmail}
                                            </div>
                                            <div class="col">
                                                <c:set var="errorPassword">
                                                    <form:errors path="password" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <label for="password" class="form-label">Password:</label>
                                                <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" path="password"/>
                                                ${errorPassword}
                                            </div>
                                        </div>
                                        <div class="row g-3">
                                            <div class="col">
                                                <label for="phonenumber" class="form-label">Phone number:</label>
                                                <form:input type="text" class="form-control" path="phone"/>
                                            </div>
                                            <div class="col">
                                                <c:set var="errorFullname">
                                                    <form:errors path="fullName" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <label for="fullname" class="form-label">Fullname:</label>
                                                <form:input type="text" class="form-control ${not empty errorFullname ? 'is-invalid' : ''}" path="fullName"/>
                                                ${errorFullname}
                                        </div>
                                        <div class="mb-3">
                                        <label for="address" class="form-label">Address:</label>
                                        <form:input type="text" class="form-control" path="address"/>
                                        </div>
                                        <div class="row g-3">
                                            <div class="col">
                                                <label class="form-label">Role:</label>
                                                <form:select class="form-select" aria-label="Default select example" path="role.name">
                                                    <form:option value="ADMIN">ADMIN</form:option>
                                                    <form:option value="USER">USER</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col">
                                                <label for="avatarFile" class="form-label">Avatar</label>
                                                <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="toanFile" />
                                            </div>
                                            <div class="col-12 mb-3 d-flex justify-content-center">
                                                <img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview">
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
</body>
</html>