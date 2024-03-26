

window.onload = function () {
  onDatabaseTableReload();

  requestDatabaseSchema();
};

function onNavBarItemClick(id) {
  const id0 = 'browse-data';
  const id1 = 'execute-sql';
  const id2 = 'db-structure';
  const selectedItem = document.getElementById(id);
  if (!selectedItem.classList.contains('active')) {
    activeNavAndTabElement(selectedItem);
    if (selectedItem.id === id0) {
      inactiveNavAndTabElement(document.getElementById(id1));
      inactiveNavAndTabElement(document.getElementById(id2));
    } else if (selectedItem.id === id1) {
      inactiveNavAndTabElement(document.getElementById(id0));
      inactiveNavAndTabElement(document.getElementById(id2));
    } else {
      inactiveNavAndTabElement(document.getElementById(id0));
      inactiveNavAndTabElement(document.getElementById(id1));
    }
  }
}

function activeNavAndTabElement(navEle) {
  navEle.classList.add('active');
  const tabEle = document.getElementById(navEle.id + '-tab');
  tabEle.classList.add('active');
}

function inactiveNavAndTabElement(navEle) {
  navEle.classList.remove('active');
  const tabEle = document.getElementById(navEle.id + '-tab');
  tabEle.classList.remove('active');
}

function createTableHTMLElement(tableData) {
  const tableHTMLEle = document.createElement('table');
  if (tableData.length > 0) {
    let i;
    let j;
    let thHTMLEle;
    let tbodyHTMLEle;
    let tdHTMLEle;
    const theadData = tableData[0];
    const theadHTMLEle = document.createElement('thead');
    tableHTMLEle.appendChild(theadHTMLEle);

    let trHTMLEle = document.createElement('tr');
    theadHTMLEle.appendChild(trHTMLEle);

    for (let i = 0; i < theadData.length; i++) {
      thHTMLEle = document.createElement('th');
      thHTMLEle.innerHTML = theadData[i];
      trHTMLEle.appendChild(thHTMLEle);
    }

    tbodyHTMLEle = document.createElement('tbody');
    tableHTMLEle.appendChild(tbodyHTMLEle);

    for (i = 1; i < tableData.length; i++) {
      var trData = tableData[i];
      trHTMLEle = document.createElement('tr');
      tbodyHTMLEle.appendChild(trHTMLEle);

      for (j = 0; j < trData.length; j++) {
        tdHTMLEle = document.createElement('td');
        tdHTMLEle.innerHTML = trData[j];
        trHTMLEle.appendChild(tdHTMLEle);
      }
    }
  }
  return tableHTMLEle;
}


function onDatabaseTableReload() {
  var reloadBtnEle = document.getElementById('browse-data-reload-button');
  reloadBtnEle.classList.remove('reload-normal');
  reloadBtnEle.classList.add('reload-loading');

  var dbPathEle = document.getElementById('db-path');
  var dbPath = dbPathEle.innerText;
  var tableNamesEle = document.getElementById('table-name-select');
  var tableName = tableNamesEle.options[tableNamesEle.selectedIndex].value;

  var resultSetXHR = new XMLHttpRequest();
  var requestURL = document.location.protocol + '//' + document.location.host
  + '/api/database_inspect?db_path=' + encodeURIComponent(dbPath) + '&table_name=' + tableName;
  resultSetXHR.open('GET', requestURL);
  resultSetXHR.onload = function () {
    if (resultSetXHR.status === 200) {
      var responseText = resultSetXHR.responseText;
      var responseJSON = JSON.parse(responseText);

      var tableHTMLEle = createTableHTMLElement(responseJSON.data);

      var tableEle = document.getElementById('browse-data-table');
      while (tableEle.firstChild) {
        tableEle.removeChild(tableEle.firstChild);
      }

      tableEle.appendChild(tableHTMLEle);
    }

    reloadBtnEle.classList.remove('reload-loading');
    reloadBtnEle.classList.add('reload-normal');
  };
  resultSetXHR.send(null);
}

function onDatabaseExecuteSQL() {
  const msgEle = document.getElementById('execute-sql-result-msg');
  while (msgEle.firstChild) {
    msgEle.removeChild(msgEle.firstChild);
  }

  const resultEle = document.createElement('p');
  resultEle.style.fontStyle = 'italic';
  msgEle.appendChild(resultEle);

  var dbPathEle = document.getElementById('db-path');
  var dbPath = dbPathEle.innerText;
  var textareaEle = document.getElementById('sql-textarea');
  var sql = textareaEle.value.trim();

  if (sql.length === 0) {
    resultEle.innerHTML = "SQL 语句为空";
    return;
  }

  var reloadBtnEle = document.getElementById('execute-sql-reload-button');
  reloadBtnEle.classList.remove('reload-normal');
  reloadBtnEle.classList.add('reload-loading');

  var resultSetXHR = new XMLHttpRequest();
  var requestURL = `${document.location.protocol}//${document.location.host}/api/database_inspect?action=execute_sql&db_path=${encodeURIComponent(dbPath)}&sql=${encodeURIComponent(sql)}`;
  resultSetXHR.open('GET', requestURL);
  resultSetXHR.onload = function () {
    if (resultSetXHR.status === 200) {
      var responseText = resultSetXHR.responseText;
      var responseJSON = JSON.parse(responseText);
      var jsonData = responseJSON.data;

      var resMsg;
      var tableHTMLEle;
      var tableEle = document.getElementById('execute-sql-table');
      var status = jsonData.status;
      var errMsg = jsonData.errMsg;
      var tableData = jsonData.resultSet;

      if (status) {
        resMsg = 'success';
      } else {
        resMsg = 'failure';
      }
      if (errMsg.length > 0) {
        resMsg += ', ' + errMsg;
      }
      resultEle.innerHTML = resMsg;

      tableHTMLEle = createTableHTMLElement(tableData);

      while (tableEle.firstChild) {
        tableEle.removeChild(tableEle.firstChild);
      }

      tableEle.appendChild(tableHTMLEle);
    }

    reloadBtnEle.classList.remove('reload-loading');
    reloadBtnEle.classList.add('reload-normal');
  };
  resultSetXHR.send(null);
}

/**
 * database schema
 */
function requestDatabaseSchema() {
  // request parameters
  var dbPathEle = document.getElementById('db-path');
  var dbPath = dbPathEle.innerText;

  // request
  var resultSetXHR = new XMLHttpRequest();
  var requestURL = document.location.protocol + '//' + document.location.host
  + '/api/database_inspect?db_path=' + encodeURIComponent(dbPath) + '&type=schema';
  resultSetXHR.open('GET', requestURL);
  resultSetXHR.onload = function () {
    if (resultSetXHR.status === 200) {
      var responseText = resultSetXHR.responseText;
      var responseJSON = JSON.parse(responseText);

      generateDatabaseSchemaHTML(responseJSON.data);
    }
  };
  resultSetXHR.send(null);
}

function generateDatabaseSchemaHTML(schemaData) {
  var tableArr = schemaData['table'];
  var indexArr = schemaData['index'];
  var viewArr = schemaData['view'];
  var triggerArr = schemaData['trigger'];
  var databaseSchemaEle = document.getElementById('database-schema');

  // Tables
  var pEle = document.createElement('p');
  pEle.innerHTML = 'Tables(' + tableArr.length + ')';
  databaseSchemaEle.appendChild(pEle);
  for (var i = tableArr.length - 1; i >= 0; i--) {
    var tableItem = tableArr[i];
    pEle = document.createElement('p');
    pEle.innerHTML = tableItem['name'] + ': ' + tableItem['sql'];
    databaseSchemaEle.appendChild(pEle);
  }

  databaseSchemaEle.appendChild(document.createElement('br'));

  // Indices
  pEle = document.createElement('p');
  pEle.innerHTML = 'Indices(' + indexArr.length + ')';
  databaseSchemaEle.appendChild(pEle);
  for (var i = indexArr.length - 1; i >= 0; i--) {
    var indexItem = indexArr[i];
    pEle = document.createElement('p');
    pEle.innerHTML = indexItem['name'] + ': ' + indexItem['sql'];
    databaseSchemaEle.appendChild(pEle);
  }

  databaseSchemaEle.appendChild(document.createElement('br'));

  // Views
  pEle = document.createElement('p');
  pEle.innerHTML = 'Views(' + viewArr.length + ')';
  databaseSchemaEle.appendChild(pEle);
  for (var i = viewArr.length - 1; i >= 0; i--) {
    var viewItem = viewArr[i];
    pEle = document.createElement('p');
    pEle.innerHTML = viewItem['name'] + ': ' + viewItem['sql'];
    databaseSchemaEle.appendChild(pEle);
  }

  databaseSchemaEle.appendChild(document.createElement('br'));

  // Triggers
  pEle = document.createElement('p');
  pEle.innerHTML = 'Triggers(' + triggerArr.length + ')';
  databaseSchemaEle.appendChild(pEle);
  for (var i = triggerArr.length - 1; i >= 0; i--) {
    var triggerItem = triggerArr[i];
    pEle = document.createElement('p');
    pEle.innerHTML = triggerItem['name'] + ': ' + triggerItem['sql'];
    databaseSchemaEle.appendChild(pEle);
  }
}
