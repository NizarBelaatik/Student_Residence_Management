



        
$(document).ready(function() {
    // Handle form submission
    $('#registrationForm').submit(function(e) {
        e.preventDefault(); // Prevent default form submission
        // Get password and confirm password values
        var password = $('#password').val();
        var confirmPassword = $('#confirm-password').val();
      
        var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d.,\s-]{8,}$/;
        
        // Check if the password meets the criteria
        if (!passwordRegex.test(password)) {
            alert("Password must be at least 8 characters long, contain both uppercase and lowercase letters, and include at least one number.");
            return; // Stop the form submission if the password is invalid
        }

        // Validate that password and confirm password match
        if (password !== confirmPassword) {
            alert("Passwords do not match! Please check your passwords.");
            return; // Stop the form submission if passwords don't match
        }
        
        $('body').append('<div class="fullpageloader_container" id="fullpageLoader"><div class="fullpageloader"></div></div>');
        
        // Perform AJAX request
        $.ajax({
            url: contextPath+'/register', // The servlet URL
            method: 'POST',
            data: $(this).serialize(), // Serialize the form data
            dataType: 'json', // Expect a JSON response
            success: function(response) {
                if (response.messageType === "success") {
                    $('#Registration').hide();
                    $('#Verification').show();
                    $('#fullpageLoader').remove();
                } else if (response.messageType === "error") {
                    $('#fullpageLoader').remove();
                }
            },
            error: function() {
                $('#fullpageLoader').remove();
                
            }
        });
    });
});



        
$(document).ready(function() {
    // Handle form submission
    $('#validationForm').submit(function(e) {
        e.preventDefault(); // Prevent default form submission
        $('body').append('<div class="fullpageloader_container" id="fullpageLoader"><div class="fullpageloader"></div></div>');
        
        
        var formData1 = $('#registrationForm').serialize();  // Serialize first form
        var formData2 = $('#validationForm').serialize();  // Serialize second form
        
        var combinedData = formData1 + '&' + formData2;
        // Perform AJAX request
        $.ajax({
            url: contextPath+'/regiserV', // The servlet URL
            method: 'POST',
            data: combinedData, // Serialize the form data
            dataType: 'json', // Expect a JSON response
            success: function(response) {
                if (response.messageType === "success") {
                    $('#Verification').hide();
                    $('#RegistrationSu').show();
                    $('#fullpageLoader').remove();
                    console.log('good');
                } else if (response.messageType === "error") {
                    $('#fullpageLoader').remove();
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: response.message,
                        confirmButtonText: 'Try Again'
                    });
                    
                }
            },
            error: function() {
                $('#fullpageLoader').remove();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'An error occurred while processing your request. Please try again later.',
                    confirmButtonText: 'OK'
                });
            }
        });
    });
});