/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function () {
    console.log('JavaScript is loaded from assets!');
});


const toggleBtn = document.getElementById('toggleBtn');
    const sidebar = document.getElementById('sidebar');
    const main = document.getElementById('main');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        main.classList.toggle('sidebar-open');
});
        
        
        
// Add event listener for all filter inputs
document.querySelectorAll('.card_1-body #filterInput').forEach(function(inputElement) {
    inputElement.addEventListener('keyup', function() {
        // Get the value of the search input
        var filter = this.value.toLowerCase();

        // Find the closest .card_1-body container that contains the input field
        var tableWrap = this.closest('.card_1-body');

        // Get the table inside this .card_1-body container
        var table = tableWrap.querySelector('table');

        // Get all rows in the table (tbody tr)
        var rows = table.querySelectorAll('tbody tr');

        // Loop through all rows and hide those that don't match the search
        rows.forEach(function(row) {
            var cells = row.querySelectorAll('td , th'); // Only look at td cells (data cells)
            var rowText = '';

            // Combine text content of all cells in the row into one string for searching
            cells.forEach(function(cell) {
                rowText += cell.textContent.toLowerCase() + ' ';
            });

            // If the row text contains the search filter, show the row, otherwise hide it
            if (rowText.indexOf(filter) > -1) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});
