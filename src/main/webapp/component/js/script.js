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
        
        
        

document.getElementById('filterInput').addEventListener('keyup', function() {
    // Get the value of the search input
    var filter = this.value.toLowerCase();
    // Find the closest parent div containing the input and the table (no need for '.table-wrap')
    var tableWrap = this.closest('.card_1-body'); // Assuming .card_1-body is the container for each card

    // Get the table inside this div (if there are multiple tables in the same card)
    var table = tableWrap.querySelector('table');

    // Get all rows in the table (tbody tr)
    var rows = table.querySelectorAll('tbody tr');

    // Loop through all rows and hide those that don't match the search
    rows.forEach(function(row) {
        var cells = row.querySelectorAll('td, th'); // Get all cells (including header cells)
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

