$(function() {
  var ctx = document.getElementById("myChart");
  var repos = {};
  var currentRepo = false;
  var currentNav = false;
  var myChart = false;
  var debianColorCounter = 0xD80150;
  var alpineColorCounter = 0x0D597F;
  var raspbianColorCOunter = 0xC31C4A;
  var ubuntuColorCounter = 0xE95420;
  var fedoraColorCounter = 0x294172;
  var defaultColorCounter = 0xDBDBDB;
  var counterIncrement = 0x010101;
  var lastXDays = parseInt($("#lastXDays").val());

  $.get("data/index.json", function(indexFiles) {
    for (var i = 0; i < indexFiles.length; i++) {
      fillDropdown(indexFiles[i], (i===0));
    }
  });

  $("#navGeneral").click(() => { navGeneralFunc(); });
  $("#navViews").click(() => { navViewsFunc(); });
  $("#navClones").click(() => { navClonesFunc(); });
  $("#navReleases").click(() => { navReleasesFunc(); });
  $("#navRefresh").click(() => { navRefreshFunc(); });
  $("#lastXDays").change(() => { lastXDays  = parseInt($("#lastXDays").val()); currentNav(); });

  function getColorForAsset(asset) {
    var color = "#";
    if (asset.indexOf('ebian') > 0) {
      color += ('' + debianColorCounter);
      debianColorCounter += counterIncrement;
    } else if (asset.indexOf('lpine') > 0) {
      color += ('' + alpineColorCounter);
      alpineColorCounter += counterIncrement;
    } else if (asset.indexOf('aspbian') > 0) {
      color += ('' + raspbianColorCOunter);
      raspbianColorCOunter += counterIncrement;
    } else if (asset.indexOf('buntu') > 0) {
      color += ('' + ubuntuColorCounter);
      ubuntuColorCounter += counterIncrement;
    } else if (asset.indexOf('edora') > 0) {
      color += ('' + fedoraColorCounter);
      fedoraColorCounter += counterIncrement;
    } else {
      color += ('' + defaultColorCounter);
      defaultColorCounter += counterIncrement;
    }
    return color;
  }
  
  function resetColorForAsset() {
    debianColorCounter = 0xD80150;
    alpineColorCounter = 0x0D597F;
    raspbianColorCOunter = 0xC31C4A;
    ubuntuColorCounter = 0xE95420;
    fedoraColorCounter = 0x294172;
    defaultColorCounter = 0xDBDBDB;
  }
  
  function fillDropdown(repo, first) {
    $("#repoDropdown").append('<a class="dropdown-item" href="#" id="repoDropdown-' + repo + '">' + repo + '</a>');
    $("#repoDropdown-" + repo).click(() => {
      currentRepo = repo;
      currentNav(repo);
    });
    getRepo(repo, first);
  }
  
  function getRepo(repoName, choose) {
    $.get("data/repo-" + repoName + ".json", function(repo) {
      repos[repoName] = repo;
      if (choose) {
        currentRepo = repoName;
        navGeneralFunc();
      }
    });
  }

  var navGeneralFunc = function navGeneral() {
    currentNav = navGeneralFunc;
    $("#navGeneral").parent().addClass("active");
    $("#navViews").parent().removeClass("active");
    $("#navClones").parent().removeClass("active");
    $("#navReleases").parent().removeClass("active");
    $("#tableRow").hide();
    
    $("#graphTitle").text("Dashboard for " + currentRepo);
    var data = {
      labels: [],
      datasets:
      [{
        label: "Stargazers",
        borderColor: "green",
        lineTension: 0.4,
        data: []
      },
      {
        label: "Watchers",
        borderColor: "blue",
        lineTension: 0.4,
        data: []
      },
      {
        label: "Forks",
         borderColor: "red",
         lineTension: 0.4,
         data: []
      }]
    };
    for (var i = 0; i < repos[currentRepo].general.length; i++) {
      var current = repos[currentRepo].general[i];
      data.labels.push(current.date);
      data.datasets[0].data.push(current.stargazers);
      data.datasets[1].data.push(current.watchers);
      data.datasets[2].data.push(current.forks);
    }
    if (lastXDays < data.labels.length) {
      data.labels = data.labels.slice(data.labels.length - lastXDays);
      data.datasets[0].data = data.datasets[0].data.slice(data.datasets[0].data.length - lastXDays);
      data.datasets[1].data = data.datasets[1].data.slice(data.datasets[1].data.length - lastXDays);
      data.datasets[2].data = data.datasets[2].data.slice(data.datasets[2].data.length - lastXDays);
    }

    myChart && myChart.destroy();
    myChart = new Chart(ctx, {
      type: 'line',
      data: data
    });
  }

  var navViewsFunc = function navViews() {
    currentNav = navViewsFunc;
    $("#navGeneral").parent().removeClass("active");
    $("#navViews").parent().addClass("active");
    $("#navClones").parent().removeClass("active");
    $("#navReleases").parent().removeClass("active");
    $("#tableRow").show();
    
    $("#graphTitle").text("Views for " + currentRepo);
    var maxValue = 0;
    var data = {
      labels: [],
      datasets:
      [{
        label: "Total",
        yAxisID: 'total',
        borderColor: "green",
        lineTension: 0.4,
        data: []
      },
      {
        label: "Uniques",
        yAxisID: 'uniques',
        borderColor: "blue",
        lineTension: 0.4,
        data: []
      }]
    };
    var dateCounter = repos[currentRepo].views.views.length?new Date(repos[currentRepo].views.views[0].timestamp):null;
    if (dateCounter) {
      dateCounter.setDate(dateCounter.getDate() + 1);
    }
    for (var i = 0; i < repos[currentRepo].views.views.length; i++) {
      var current = repos[currentRepo].views.views[i];
      var currentDate = new Date(current.timestamp);
      currentDate.setDate(currentDate.getDate() + 1);
      while (dateCounter.getTime() < currentDate.getTime()) {
        data.labels.push(dateCounter.toLocaleDateString());
        data.datasets[0].data.push(0);
        data.datasets[1].data.push(0);
        dateCounter.setDate(dateCounter.getDate() + 1);
      }
      data.labels.push(currentDate.toLocaleDateString());
      data.datasets[0].data.push(current.count);
      data.datasets[1].data.push(current.uniques);
      dateCounter.setDate(dateCounter.getDate() + 1);
      maxValue = maxValue<current.count?current.count:maxValue;
    }
    if (lastXDays < data.labels.length) {
      data.labels = data.labels.slice(data.labels.length - lastXDays);
      data.datasets[0].data = data.datasets[0].data.slice(data.datasets[0].data.length - lastXDays);
      data.datasets[1].data = data.datasets[1].data.slice(data.datasets[1].data.length - lastXDays);
    }

    $("#tableReferrersBody").empty();
    for (var i = 0; i < repos[currentRepo].views.referrers.length; i++) {
      var referrer = repos[currentRepo].views.referrers[i];
      $("#tableReferrersBody").append("<tr><td>" + referrer.referrer + "</td><td>" + referrer.count + "</td><td>" + referrer.uniques + "</td></tr>");
    }

    $("#tablePathsBody").empty();
    for (var i = 0; i < repos[currentRepo].views.paths.length; i++) {
      var path = repos[currentRepo].views.paths[i];
      $("#tablePathsBody").append("<tr><td><a href=\"https://github.com" + path.path + "\" title=\"" + path.title + "\">" + path.title + "</a></td><td>" + path.count + "</td><td>" + path.uniques + "</td></tr>");
    }

    myChart && myChart.destroy();
    myChart = new Chart(ctx, {
      type: 'line',
      data: data,
      options: {
        scales : {
          yAxes : [{
            id: 'total',
            position: 'left',
            ticks : {
              beginAtZero : true,
              fontColor: 'green',
              suggestedMax: maxValue
            }
          },
          {
            id: 'uniques',
            position: 'right',
            ticks : {
              beginAtZero : true,
              fontColor: 'blue',
              suggestedMax: maxValue
            }   
          }]
        }
      }
    });
  }

  var navClonesFunc = function navClones() {
    currentNav = navClonesFunc;
    $("#navGeneral").parent().removeClass("active");
    $("#navViews").parent().removeClass("active");
    $("#navClones").parent().addClass("active");
    $("#navReleases").parent().removeClass("active");
    $("#tableRow").hide();
    
    $("#graphTitle").text("Clones for " + currentRepo);
    var maxValue = 0;
    var data = {
      labels: [],
      datasets:
      [{
        label: "Total",
        yAxisID: 'total',
        borderColor: "green",
        lineTension: 0.4,
        data: []
      },
      {
        label: "Uniques",
        yAxisID: 'uniques',
        borderColor: "blue",
        lineTension: 0.4,
        data: []
      }]
    };
    var dateCounter = repos[currentRepo].views.views.length?new Date(repos[currentRepo].views.views[0].timestamp):null;
    if (dateCounter) {
      dateCounter.setDate(dateCounter.getDate() + 1);
    }
    for (var i = 0; i < repos[currentRepo].clones.clones.length; i++) {
      var current = repos[currentRepo].clones.clones[i];
      var currentDate = new Date(current.timestamp);
      currentDate.setDate(currentDate.getDate() + 1);
      while (dateCounter.getTime() < currentDate.getTime()) {
        data.labels.push(dateCounter.toLocaleDateString());
        data.datasets[0].data.push(0);
        data.datasets[1].data.push(0);
        dateCounter.setDate(dateCounter.getDate() + 1);
      }
      data.labels.push(currentDate.toLocaleDateString());
      data.datasets[0].data.push(current.count);
      data.datasets[1].data.push(current.uniques);
      dateCounter.setDate(dateCounter.getDate() + 1);
      maxValue = maxValue<current.count?current.count:maxValue;
    }
    if (lastXDays) {
      data.labels = data.labels.slice(data.labels.length - lastXDays);
      data.datasets[0].data = data.datasets[0].data.slice(data.datasets[0].data.length - lastXDays);
      data.datasets[1].data = data.datasets[1].data.slice(data.datasets[1].data.length - lastXDays);
    }

    myChart && myChart.destroy();
    myChart = new Chart(ctx, {
      type: 'line',
      data: data,
      options: {
        scales : {
          yAxes : [{
            position: 'left',
            id: 'total',
            ticks : {
              beginAtZero : true,
              fontColor: 'green',
              suggestedMax: maxValue
            }   
          },
          {
            position: 'right',
            id: 'uniques',
            ticks : {
              beginAtZero : true,
              fontColor: 'blue',
              suggestedMax: maxValue
            }   
          }]
        }
      }
    });
  }

  var navReleasesFunc = function navReleases() {
    currentNav = navReleasesFunc;
    $("#navGeneral").parent().removeClass("active");
    $("#navViews").parent().removeClass("active");
    $("#navClones").parent().removeClass("active");
    $("#navReleases").parent().addClass("active");
    $("#tableRow").hide();
    resetColorForAsset();
    
    $("#graphTitle").text("Releases downloads for " + currentRepo);
    var data = {
      labels: [],
      datasets: []
    };
    var firstParse = 1;
    for (var i = 0; i < repos[currentRepo].releases.length; i++) {
      var currentRelease = repos[currentRepo].releases[i];
      if (currentRelease.assets.length > 0 && currentRelease.assets_download > 0) {
        data.labels.push(currentRelease.name);
        for (var j = 0; j < currentRelease.assets.length; j++) {
          var currDownloadCount = currentRelease.assets[j].download_count;
          if (!firstParse) {
            if (data.datasets[j]) {
              data.datasets[j].data.push(currDownloadCount[currDownloadCount.length - 1].count);
            }
          } else {
            var datasetName = currentRelease.assets[j].name;
            var assetName = datasetName.substring(0, datasetName.indexOf("_")+1);
            datasetName = datasetName.substring(datasetName.indexOf("_")+1);
            datasetName = datasetName.substring(datasetName.indexOf("_")+1);
            if (datasetName.indexOf(".tar.gz") > 0) {
              datasetName = datasetName.substring(0, datasetName.indexOf(".tar.gz"));
            } else {
              datasetName = datasetName.substring(0, datasetName.lastIndexOf("."));
            }
            data.datasets.push({
              label: (assetName + datasetName),
              backgroundColor: getColorForAsset(currentRelease.assets[j].name),
              data: [currDownloadCount[currDownloadCount.length - 1].count]
            });
          }
        }
        firstParse = 0;
      }
    }
    myChart && myChart.destroy();
    myChart = new Chart(ctx, {
      type: 'bar',
      data: data,
      options: {
        tooltips: {
          mode: 'index',
          intersect: false
        },
        responsive: true,
        scales: {
          xAxes: [{
            stacked: true,
          }],
          yAxes: [{
            stacked: true,
            ticks : {
              beginAtZero : true
            }
          }]
        },
        onClick: function (evt) {
          var activeElement = myChart.getElementAtEvent(evt);
          if (activeElement.length) {
            for (var i=0; i<repos[currentRepo].releases.length; i++) {
              if (repos[currentRepo].releases[i].name === activeElement[0]._model.label) {
                myChart.destroy();
                navOneRelease(repos[currentRepo].releases[i]);
              }
            }
          }
        }
      }
    });
  }

  var navOneRelease = function(release) {
    $("#graphTitle").text("Download assets for " + release.name);
    resetColorForAsset();
    var data = {
      labels: [],
      datasets: []
    };

    for (var i=0; i<release.assets.length; i++) {
      var curAsset = release.assets[i];
      var dataset = {label: curAsset.name, lineTension: 0, data: [], backgroundColor: getColorForAsset(curAsset.name)};

      for (var j=0; j<curAsset.download_count.length; j++) {
        dataset.data.push(curAsset.download_count[j].count);
        if (!i) {
          data.labels.push(curAsset.download_count[j].date);
        }
      }
      data.datasets.push(dataset);
    }
    if (lastXDays < data.labels.length) {
      data.labels = data.labels.slice(data.labels.length - lastXDays);
      data.datasets[0].data = data.datasets[0].data.slice(data.datasets[0].data.length - lastXDays);
    }

    myChart && myChart.destroy();
    myChart = new Chart(ctx, {
      type: 'line',
      data: data,
      options: {
        scales: {
          yAxes: [{
            stacked: true,
            ticks : {
              beginAtZero : true
            }
          }]
        }
      }
    });
  }

  var navRefreshFunc = function() {
    $("#repoDropdown").empty();
    $.get("data/index.json", function(indexFiles) {
      for (var i = 0; i < indexFiles.length; i++) {
        fillDropdown(indexFiles[i], (i===0));
      }
    });
  }
});
