<%

%>

<form id="submitForm" class="grid grid-cols-3 gap-3 p-3 text-lg h-full? relative">
    <label class="text-right translate-y-1">Name</label>
    <input class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="text" required />

    <label class="text-right translate-y-1">Contact</label>
    <input class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="text" required />

    <label class="text-right translate-y-1">Date of Join</label>
    <input class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="date" required />

    <label class="text-right translate-y-1">Type</label>
    <select class="block col-span-2 rounded-lg p-1.5 shadow focus:shadow-lg transition" id="type">
        <option value="1" >Admin</option>
        <option value="2" selected >Worker</option>
        <option value="3">Driver</option>
        <option value="4">Supervisor</option>
        <option value="5">Manager</option>
    </select>
    <div class="placeholder col-span-full h-24"></div>
    <input type="submit" class="absolute bottom-3 right-3.5 block bg-slate-400/70 hover:bg-slate-400/100 active:bg-slate-500/90 cursor-pointer rounded-lg p-2 px-3.5 shadow-md hover:shadow-lg text-slate-50 transition" value="Confirm" />
</form>

<script>
    let filled = presetFormulae("Employee"),
        form = document.getElementById("submitForm");

    form.addEventListener("submit", (e) => {
        e.preventDefault();
        let inputs = document.getElementsByTagName("input");
        filled.name = inputs[0].value;
        filled.contact = inputs[1].value;
        filled.dateJoin = dateToTimestamp(inputs[2].value);
        filled.empId = -1;
        filled.type = document.getElementById("type").value;
        let submission = new ResponseObject("Employee", true, "-");
        submission.content = filled;
        submit("submit/employee/update", JSON.stringify(submission), "post", (xhr) => {if(xhr.status == 200) {alert("SuCCessful"); window.location.reload();}}, true);
    });


</script>