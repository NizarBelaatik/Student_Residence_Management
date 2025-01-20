<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>

<html>
<head>
    <title>Maintenance Details</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerTech.jsp" %>


    <div class="container mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card_1">
                    <div class="card_1-body">
                        <div class="card_1-header">
                            <h5>Edit Maintenance Request | ${M_data.getId()}</h5>
                        </div>

                        <form id="editMaintenanceRequestForm" method="post" action="${pageContext.request.contextPath}/admin/maintenance/maintenanceDetails">
                            <input type="hidden" class="form-control" name="inputRequestId" value="${M_data.getId()}">

                            <div class="row mb-3">
                                <label for="inputResidentEmail" class="col-sm-2 col-form-label">Resident Email</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control" name="inputResidentEmail" value="${M_data.getResidentEmail()}" required readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="inputRoomId" class="col-sm-2 col-form-label">Room ID</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputRoomId" value="${M_data.getRoomId()}" required readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="inputIssueType" class="col-sm-2 col-form-label">Issue Type</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputIssueType" value="${M_data.getIssueType()}" required readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="inputIssueDescription" class="col-sm-2 col-form-label">Issue Description</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="inputIssueDescription" required readonly>${M_data.getIssueDescription()}</textarea>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="inputTechnician" class="col-sm-2 col-form-label">Technician</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputTechnician" value="${M_data.getTechnicianName()}" required readonly>


                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="inputStatus" class="col-sm-2 col-form-label">Status</label>
                                <div class="col-sm-5">
                                    <select name="inputStatus" class="form-select" required>
                                        <option value="pending" ${M_data.getStatus().equals("pending") ? 'selected' : ''}>Pending</option>
                                        <option value="in_progress" ${M_data.getStatus().equals("in_progress") ? 'selected' : ''}>In Progress</option>
                                        <option value="resolved" ${M_data.getStatus().equals("resolved") ? 'selected' : ''}>Resolved</option>
                                    </select>
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn1 submit_btn">Submit</button>
                                <button type="reset" class="btn1 cancel_btn">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
