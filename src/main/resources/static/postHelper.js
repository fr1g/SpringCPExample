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
                type: 0
            };

        default:
            return null;
    }
}

class ResponseObject{
    type;
    certificated;
    token;
    content; // type: from presetFormulae

    constructor(type, certificated, token){
        this.type = type;
        this.certificated = certificated;
        this.token = token;


    }
}

function dateToTimestamp(dateString) {
    // 确保日期格式正确
    if (!/^\d{4}-\d{2}-\d{2}$/.test(dateString)) {
        throw new Error('日期格式必须是 yyyy-mm-DD. claimed: ' + dateString);
    }

    // 将日期字符串分割成年、月、日
    const parts = dateString.split('-');
    const year = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1; // 月份是从0开始的
    const day = parseInt(parts[2], 10);

    // 创建一个新的Date对象
    const date = new Date(year, month, day);

    // 转换为时间戳（秒）
    const timestamp = Math.floor(date.getTime() / 1000);

    return timestamp;
}
