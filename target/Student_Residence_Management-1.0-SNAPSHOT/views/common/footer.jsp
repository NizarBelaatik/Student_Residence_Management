<style>
/* Ensure the body takes up the full height */
html, body {
    height: 100%; /* Make sure the body and html take up the full viewport height */
    margin: 0;
    display: flex;
    flex-direction: column;
}

/* Main content styling */
.main {
    flex: 1; /* This makes the content area grow to fill the space */
}
.u_main{
    flex: 1;
    margin-top:3rem!important;
    margin-bottom:3rem!important;

    }

.u_main {
    width: 100%; /* Ensure the main content spans the full width */
    margin: 0 auto; /* Center the content horizontally */
    padding: 20px; /* Add padding for spacing inside */
    color: #333; /* Text color */
    line-height: 1.6; /* Improved line spacing for readability */

}

/* For larger screens, give some space between header and main */
@media (min-width: 768px) {
    .u_main {
        max-width: 1200px; /* Limit the width on larger screens */
        margin-top: 30px; /* Add space from the header */
    }
}
/* Responsive design for smaller screens (mobile first) */
@media (max-width: 480px) {
    .u_main {
        padding: 5px; /* Reduce padding even further */
    }

    .u_main > section,
    .u_main > article {
        padding: 10px; /* Less padding for mobile screens */
    }
}

/* Footer Styling */
.footer {
    background-color: var(--clr1);
    color: var(--clr3);
    padding: 30px 0;
    width: 100%;
    position: relative;
    box-shadow:0 -3px 5px 0 rgba(69, 92, 113, 0.59);
}



/* Footer Styling */
.footer {
background-color: var(--clr1);
    color: var(--clr3);
    padding: 30px 0;
    /* position: absolute; */
position: relative;
    bottom: 0;
    width: 100%;
}

.footer .container {
    max-width: 1200px;
    margin: 0 auto;
}

.footer-text {
    font-size: 1rem;
    margin-bottom: 15px;
}

.footer-links {
    margin-top: 10px;
}

.footer-link {
    color: var(--clr3); /* White color for links */
    text-decoration: none;
    margin: 0 15px;
    font-size: 0.9rem;
    transition: color 0.3s ease;
}

.footer-link:hover {
    color: var(--clr-info); /* Light blue color when hovered */
}

/* Responsive design for smaller screens */
@media (max-width: 768px) {
    .footer {
        padding: 20px 0;
    }

    .footer .container {
        padding: 0 15px;
    }

    .footer-links {
        display: block;
        margin-top: 10px;
    }

    .footer-link {
        display: block;
        margin: 5px 0;
    }
}
</style>

<!-- Footer -->
<footer class="footer">
    <div class="container text-center">
        <p class="footer-text">&copy; 2025 Student Residence Management. All Rights Reserved.</p>
        <div class="footer-links">
            <a href="#" class="footer-link">Privacy Policy</a>
            <a href="#" class="footer-link">Terms of Service</a>
            <a href="#" class="footer-link">Contact Us</a>
        </div>
    </div>
</footer>