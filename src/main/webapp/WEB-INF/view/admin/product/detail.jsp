<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng</title>
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
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Product detail</h3>
                                    </div>
                                    <hr>
                                    <div class="card p-3 shadow-sm" style="width: 80%;">
                                        <div class="card-body">
                                            <div class="row">
                                                <!-- Cột User Information -->
                                                <div class="col-md-8">
                                                    <h5 class="card-title fw-bold">Product Information of ${product.name}</h5>
                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item"><strong>ID:</strong> ${product.id}</li>
                                                        <li class="list-group-item"><strong>Name:</strong> ${product.name}</li>
                                                        <li class="list-group-item"><strong>Price:</strong> ${product.price}</li>
                                                        <li class="list-group-item"><strong>Detail Desc:</strong> ${product.detailDesc}</li>
                                                        <li class="list-group-item"><strong>Short Desc:</strong> ${product.shortDesc}</li>
                                                        <li class="list-group-item"><strong>Quantity:</strong> ${product.quantity}</li>
                                                        <li class="list-group-item"><strong>Quantity:</strong> ${product.quantity}</li>
                                                        <li class="list-group-item"><strong>Factory:</strong> ${product.factory}</li>
                                                        <li class="list-group-item"><strong>Target:</strong> ${product.target}</li>
                                                    </ul>
                                                </div>
                                    
                                                <!-- Cột Avatar -->
                                                <div class="col-md-4 text-center">
                                                    <h5 class="card-title fw-bold">Avatar</h5>
                                                    <img src="/images/product/${product.image}" class="rounded-3 border border-secondary shadow-sm" 
                                                         style="height: 250px; object-fit: cover;">
                                                </div>
                                            </div>
                                        </div>
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