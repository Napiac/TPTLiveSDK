var dataSource = [];

window.onload = function () {
  if ("WebSocket" in window) {
    var host = window.location.host;
    var ws = new WebSocket("ws://" + host);
    ws.onopen = function () {
      var stateEle = document.getElementById("connection_state");
      stateEle.innerHTML = "WebSocket: CONNECTED";
    };
    ws.onmessage = function (evt) {
      console.log(evt.data);
      dataSource.push(evt.data);
      var table = document.getElementById("logs-table");
      var row = table.insertRow(0);
      var cell = row.insertCell(0);
      cell.innerHTML = evt.data;
    };
    ws.onclose = function () {
      var stateEle = document.getElementById("connection_state");
      stateEle.innerHTML = "WebSocket: DISCONNECTED";
    };
    ws.onerror = function () {
      alert("WebSocket链接失败");
    };
  } else {
    alert("浏览器不支持WebSocket!");
  }
};
