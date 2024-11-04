
let thisPage = 1;
let limit = 3;
let list = document.querySelectorAll('.paging-item');

function loadItem() {
    let beginGet = limit * (thisPage - 1);
    let endGet = limit * thisPage - 1;
    list.forEach((item, key) => {
        if (key >= beginGet && key <= endGet) {
            item.style.display = 'table-row';
        } else {
            item.style.display = 'none';
        }
    });
    listPage();
}
loadItem();

function listPage() {
    let count = Math.ceil(list.length / limit);
    document.querySelector('.table-pagination').innerHTML = '';
    if (thisPage !== 1) {
        let prev = document.createElement('li');
        prev.innerText = 'prev';
        prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
        document.querySelector('.table-pagination').appendChild(prev);
    }

    for (var i = thisPage - 1; i <= thisPage + 1; i++) {
        if (i !== 0 && i <= count) {
            let newPage = document.createElement('li');
            newPage.innerText = i;
            if (i === thisPage) {
                newPage.classList.add('active');
            }
            newPage.setAttribute('onclick', "changePage(" + i + ")");
            document.querySelector('.table-pagination').appendChild(newPage);
        }
    }

    if (thisPage !== count) {
        let next = document.createElement('li');
        next.innerText = 'next';
        next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
        document.querySelector('.table-pagination').appendChild(next);
    }
}

function changePage(i) {
    thisPage = i;
    loadItem();
}/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


