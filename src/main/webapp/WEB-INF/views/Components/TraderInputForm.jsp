<%

%>

<form id="submitForm" class="grid grid-cols-3 gap-3 p-3 text-lg h-full? relative">
    <label class="text-right translate-y-1">Name</label>
<%--  <?updatingForId>#<name>@<registrarId>  --%>
    <input placeholder="format: <?updatingForId>#<name>" class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="text" required />

    <label class="text-right translate-y-1">Contact</label>
    <input class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="text" required />

    <label class="text-right translate-y-1">Registrar ID</label>
    <input class="col-span-2 block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition" type="number" required />

    <label class="text-right translate-y-1">Type</label>
    <select class="block col-span-2 rounded-lg p-1.5 shadow focus:shadow-lg transition" id="type">
        <option value="1" >Prime</option>
        <option value="0" selected >Normal</option>
        <option value="2">As Before (for updating)</option>
    </select>
    <label class="text-right? translate-y-1 mt-3">Note</label>
    <textarea class="col-span-full block px-1.5 rounded-lg p-1 shadow focus:shadow-lg transition"
              rows="6" id="noteField"
              placeholder="'~' stands for using the value before."
    ></textarea>
    <div class="placeholder col-span-full h-24"></div>
    <input type="submit" class="absolute bottom-3 right-3.5 block bg-slate-400/70 hover:bg-slate-400/100 active:bg-slate-500/90 cursor-pointer rounded-lg p-2 px-3.5 shadow-md hover:shadow-lg text-slate-50 transition" value="Confirm" />
</form>

<script>
    let filled = presetFormulae("Trader"),
        form = document.getElementById("submitForm");

    form.addEventListener("submit", (e) => {
        e.preventDefault();
        let inputs = document.getElementsByTagName("input");
        filled.name = (inputs[0].value.includes("#") ? inputs[0].value.split('#')[1] : inputs[0].value) + "@" + inputs[2].value;
        filled.contact = inputs[1].value;

        filled.traderID = inputs[0].value.includes("#") ? inputs[0].value.split('#')[0] : -1;
        filled.type = document.getElementById("type").value;
        filled.note = document.getElementById("noteField").value;
        let submission = new ResponseObject("Trader", true, "-");
        submission.content = filled;
        submit("/submit/trader/update", JSON.stringify(submission), "post", (xhr) => {if(xhr.status == 200) {alert("SuCCessful"); window.location.reload();} else alert("Error occurred.")}, true);
    });
    
</script>