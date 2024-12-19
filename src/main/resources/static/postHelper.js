function submit(json, responseElementId = "response"){
    let response = document.getElementById(responseElementId);

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