<%-- <%@ include file="./Components/HtmlImports.jsp" %> --%>

<link type="text/css" href="/output.css" rel="stylesheet">
<link type="text/css" href="/preset.css" rel="stylesheet">

<script>
    const title = (text) => {
        try {
            // ?
            window.onload = () => {
                document.title = document.getElementsByTagName(text)[0].innerText;
            }
        }catch (ex){
            console.log("Failed to change title.")
        }
    }
</script>
<script src="/postHelper.js"></script>