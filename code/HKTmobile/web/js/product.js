/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function sendRamStorage(button) {
    var ram = button.getAttribute("data-ram");
    var storage = button.getAttribute("data-storage");
    var groupid = button.getAttribute("groupid");
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "./Product"; // Thay thế bằng URL của servlet của bạn

    var ramInput = document.createElement("input");
    ramInput.type = "hidden";
    ramInput.name = "ram";
    ramInput.value = ram;
    form.appendChild(ramInput);

    var storageInput = document.createElement("input");
    storageInput.type = "hidden";
    storageInput.name = "storage";
    storageInput.value = storage;
    form.appendChild(storageInput);

    var action = document.createElement("input");
    action.type = "hidden";
    action.name = "action";
    action.value = "other";
    form.appendChild(action);

    var id = document.createElement("input");
    id.type = "hidden";
    id.name = "gid";
    id.value = groupid;
    form.appendChild(id);

    document.body.appendChild(form);
    form.submit();
}

