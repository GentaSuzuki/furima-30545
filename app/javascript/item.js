// 販売価格が入力されたら、販売手数料と販売利益を計算してくれます
function postage(){
const submit = document.getElementById("item-price");
submit.addEventListener("keyup",(e) =>{ 
    // 販売価格の入力欄に入力すると動きます
    const input_price = document.getElementById("item-price").value;
    
    // 販売価格の入力欄に入力された値を変数「amount」に代入
    const Tax = document.getElementById("add-tax-price");
    const tax = Math.ceil(input_price * 0.1);
    Tax.innerHTML = tax
    // 販売手数料は10%としています。またMath.ceilメソッドで1円単位に切り上げています。
    // 計算結果を変数「tax」に代入
    const Profit = document.getElementById("profit");
    const profit = Math.floor(input_price * 0.9);
    Profit.innerHTML = profit
  })
 };

window.addEventListener("load", postage);
