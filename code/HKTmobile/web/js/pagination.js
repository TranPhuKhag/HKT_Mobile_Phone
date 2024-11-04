var currentPage = parseInt(CurrentPageO, 10);  // Trang hiện tại
var totalPages = parseInt(TotalPagesO, 10);
var totalProducts = parseInt(TotalProductsO, 10);
var PageSize = parseInt(PageSizeO, 10);
var form = document.getElementById('myForm');
var keyword = form.elements['keyword'].value.trim();
var BrandName = form.elements['BrandName'].value.trim();
var Ram = form.elements['Ram'].value.trim();
var Storage = form.elements['Storage'].value.trim();

var sortBy = form.elements['sortBy'].value.trim();
var SortType = form.elements['SortType'].value.trim();


function submitFormWithPage(pageNumber) {
    currentPage = pageNumber;
    var form = document.getElementById('myForm');
    var keyword = form.elements['keyword'].value.trim();
    var BrandName = form.elements['BrandName'].value.trim();
    var Ram = form.elements['Ram'].value.trim();
    var Storage = form.elements['Storage'].value.trim();

    var sortBy = form.elements['sortBy'].value.trim();
    var SortType = form.elements['SortType'].value.trim();
    // Lấy các tham số hiện tại


    // Tạo chuỗi query parameters
    var queryParams = [];
    if (keyword !== '')
        queryParams.push('keyword=' + encodeURIComponent(keyword));
    if (BrandName !== '')
        queryParams.push('BrandName=' + encodeURIComponent(BrandName));
    if (Ram !== '')
        queryParams.push('Ram=' + encodeURIComponent(Ram));
    if (Storage !== '')
        queryParams.push('Storage=' + encodeURIComponent(Storage));


    if (sortBy !== '')
        queryParams.push('sortBy=' + encodeURIComponent(sortBy));
    if (SortType !== '')
        queryParams.push('SortType=' + encodeURIComponent(SortType));
    // Luôn thêm action=search

    // Nếu có tham số, thêm vào actionUrl
    if (queryParams.length > 0) {
        var queryString = queryParams.join('&');
        form.action = './Store?' + queryString + '&page=' + encodeURIComponent(pageNumber);
    } else {
        // Nếu không có tham số, actionUrl vẫn là './Store'
        form.action = './Store?page=' + encodeURIComponent(pageNumber);
    }

    // Submit form
    form.submit();
}

//function submitFormToSearch() {
//    var form = document.getElementById('myForm');
//    form.action = './Store';
//    form.submit();
//}
function submitFormToSearch() {
    var form = document.getElementById('myForm');
    var keyword = form.elements['keyword'].value.trim();
    var BrandName = form.elements['BrandName'].value.trim();
    var Ram = form.elements['Ram'].value.trim();
    var Storage = form.elements['Storage'].value.trim();

    var sortBy = form.elements['sortBy'].value.trim();
    var SortType = form.elements['SortType'].value.trim();

    // Tạo chuỗi query parameters
    var queryParams = [];
    if (keyword !== '')
        queryParams.push('keyword=' + encodeURIComponent(keyword));
    if (BrandName !== '')
        queryParams.push('BrandName=' + encodeURIComponent(BrandName));
    if (Ram !== '')
        queryParams.push('Ram=' + encodeURIComponent(Ram));
    if (Storage !== '')
        queryParams.push('Storage=' + encodeURIComponent(Storage));



    if (sortBy !== '')
        queryParams.push('sortBy=' + encodeURIComponent(sortBy));
    if (SortType !== '')
        queryParams.push('SortType=' + encodeURIComponent(SortType));



    // Nếu có tham số, thêm vào actionUrl
    if (queryParams.length > 0) {
        var queryString = queryParams.join('&');
        form.action = './Store?' + queryString;
    } else {
        // Nếu không có tham số, actionUrl vẫn là './Store'
        form.action = './Store';
    }

    // Submit form
    form.submit();
}


function updatePaginationButtons() {
    // Vô hiệu hóa các nút Previous và Next nếu cần thiết
    document.getElementById('prevButton').disabled = (currentPage <= 1);
    document.getElementById('nextButton').disabled = (currentPage >= totalPages);

    // Xóa các nút trang hiện tại
    var pageButtonsDiv = document.getElementById('pageButtons');
    pageButtonsDiv.innerHTML = '';

    // Tạo các nút trang
    function createPageButton(pageNumber) {
        var button = document.createElement('button');
        button.type = 'button';
        button.textContent = pageNumber;
        button.classList.add('page-button');
        button.onclick = function () {
            submitFormWithPage(pageNumber);
        };
        if (pageNumber === currentPage) {
            button.classList.add('active'); // Thêm lớp 'active' cho trang hiện tại
        }
        pageButtonsDiv.appendChild(button);
    }


    // Tạo dấu "..."
    function createEllipsis() {
        var ellipsis = document.createElement('span');
        ellipsis.textContent = '...';
        pageButtonsDiv.appendChild(ellipsis);
    }

    let count = Math.ceil(totalProducts / PageSize);
    if (count <= 3) {
        for (i = 1; i <= count; i++) {

            createPageButton(i);
        }

    } else {
        if (currentPage >= 3) {
            createPageButton(1);
            createEllipsis()
        }
        if (currentPage === count) {
            createPageButton(count - 2);
        }
        for (i = currentPage - 1; i <= currentPage + 1; i++) {
            if (i !== 0) {
                createPageButton(i);
            }
            if (i === count) {
                break;
            }
        }
        if (currentPage === 1 && count > 2) {
            createPageButton(3);
        }
        if (currentPage < count - 1 && count !== 3) {
            createEllipsis()
            createPageButton(count);
        }
    }


}



function goToPreviousPage() {
    if (currentPage > 1) {
        submitFormWithPage(currentPage - 1);
    }
}

function goToNextPage() {
    if (currentPage < totalPages) {
        submitFormWithPage(currentPage + 1);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    updatePaginationButtons();




}

);