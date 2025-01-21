<%--
    Document   : index
    Created on : Dec 11, 2024, 4:46:56 PM
    Author     : night
--%>

<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
<%@ page import="model.Payment" %>
<html>
<head>
    <title>Make Payment</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerresident.jsp" %>



    <main class=" mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card-header text-center">
                    <h1>Make Payment</h1>
                </div>
                <!-- Dashboard Card -->
                <div class="card-body">
                    <div class="section-title">Payment Form</div>

                    <div class="card mx-auto" style="max-width: 400px;">
                        <div class="card-body">
                            <form id="payment-form" method="post">
                                <div class="form-group">
                                    <label for="cardholder-name">Cardholder Name</label>
                                    <input type="text" class="form-control" id="cardholder-name" required>
                                </div>
                                <div class="form-group">
                                    <label for="card-number">Card Number</label>
                                    <input type="text" class="form-control" id="card-number" required>
                                </div>
                                <div class="form-group">
                                    <label for="expiry-date">Expiry Date (MM/YY)</label>
                                    <input type="text" class="form-control" id="expiry-date" required>
                                </div>
                                <div class="form-group">
                                    <label for="cvc">CVC</label>
                                    <input type="text" class="form-control" id="cvc" required>
                                </div>
                                <button type="submit" class="btn btn_1 btn-block">Pay Now</button>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
    </main>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>




    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/tooplate-scripts.js"></script>

    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>

    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/tools/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/tools/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/tools/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/tools/tooplate-scripts.js"></script>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function() {
        var contextPath = "${pageContext.request.contextPath}"; // Get the context path
        var csrfToken = $("meta[name='csrf-token']").attr("content");
        $('#payment-form').on('submit', function(event) {
            event.preventDefault(); // Prevent the default form submission

            // Gather form data
            var formData = {
                cardholderName: $('#cardholder-name').val(),
                cardNumber: $('#card-number').val(),
                expiryDate: $('#expiry-date').val(),
                cvc: $('#cvc').val(),
                paymentId: '${paymentId}' // Pass the payment ID from JSP
            };

            // AJAX request to submit the payment
            $.ajax({
                url: contextPath + '/u/make_payment', // Your servlet URL
                method: 'POST',
                contentType: 'application/json', // Set content type to JSON
                data: JSON.stringify(formData), // Convert form data to JSON
                headers: {'X-CSRF-Token': csrfToken},
                dataType: 'json', // Expect JSON response
                success: function(response) {
                    if (response.status === "success") {
                        Swal.fire({
                            icon: 'success',
                            title: 'Payment Successful!',
                            text: 'Your payment has been processed successfully.',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Payment Failed',
                            text: 'There was an issue processing your payment. Please try again.',
                            confirmButtonText: 'Try Again'
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred. Please try again later.',
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>
    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
