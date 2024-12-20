function submit(url, content, type = "get", callback = () => {}, callbackNeedSelfAsParam = false){
    let xhr = new XMLHttpRequest();
    xhr.open(type, url);
    xhr.onreadystatechange = () => {
        if (xhr.readyState == 4)
            if(callbackNeedSelfAsParam) callback(xhr);
            else callback();
    }
    xhr.send(content);
}

const presetFormulae = (type) => {
    switch (type) {
        case "Employee":
            return {
                empId: 0,
                name: "",
                contact: "",
                dateJoin: new Date(),
                type: 0
            };

        case "Trader":
            return {
                traderID: 0,
                name: "",
                contact: "",
                dateJoin: new Date(),
                type
            };

        default:
            return null;
    }
}

class ResponseObject{
    type;
    certificated;
    token;
    content;

    constructor(type, certificated, token){
        this.type = type;
        this.certificated = certificated;
        this.token = token;


    }
}