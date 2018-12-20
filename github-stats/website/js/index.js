$(function() {
  var ctx = document.getElementById("myChart");
  var repos = {};
  var currentRepo = false;
  var currentNav = false;
  var myChart = false;

  $.get("data/index.json", function(indexFiles) {
    for (var i = 0; i < indexFiles.length; i++) {
      fillDropdown(indexFiles[i], (i===0));
    }
  });

  $("#navGeneral").click(() => { navGeneralFunc(); });
  $("#navViews").click(() => { navViewsFunc(); });
  $("#navClones").click(() => { navClonesFunc(); });
  $("#navReleases").click(() => { navReleasesFunc(); });

  function fillDropdown(repo, first) {
    $("#repoDropdown").append('<a class="dropdown-item" href="#" id="repoDropdown-' + repo + '">' + repo + '</a>');
    $("#repoDropdown-" + repo).click(() => {
      currentRepo = repo;
      currentNav(repo);
    });
    getRepo(repo, first);
  }
  
  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
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
    
    $("#graphTitle").text("Dashboard for " + currentRepo);
    var data = {
      labels: [],
      datasets:
      [{
        label: "Stargazers",
        borderColor: "red",
        lineTension: 0,
        data: []
      },
      {
        label: "Watchers",
        borderColor: "blue",
        lineTension: 0,
        data: []
      },
      {
        label: "Forks",
         borderColor: "green",
         lineTension: 0,
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
    
    $("#graphTitle").text("Views for " + currentRepo);
    var maxValue = 0;
    var data = {
      labels: [],
      datasets:
      [{
        label: "Total",
        yAxisID: 'total',
        borderColor: "red",
        lineTension: 0,
        data: []
      },
      {
        label: "Uniques",
        yAxisID: 'uniques',
        borderColor: "blue",
        lineTension: 0,
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
              fontColor: 'red',
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
    
    $("#graphTitle").text("Clones for " + currentRepo);
    var maxValue = 0;
    var data = {
      labels: [],
      datasets:
      [{
        label: "Total",
        yAxisID: 'total',
        borderColor: "red",
        lineTension: 0,
        data: []
      },
      {
        label: "Uniques",
        yAxisID: 'uniques',
        borderColor: "blue",
        lineTension: 0,
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
              fontColor: 'red',
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
    
    $("#graphTitle").text("Releases downloads for " + currentRepo);
    var data = {
      labels: [],
      datasets: []
    };
    for (var i = 0; i < repos[currentRepo].releases.length; i++) {
      var currentRelease = repos[currentRepo].releases[i];
      if (currentRelease.assets.length > 0) {
        data.labels.push(currentRelease.name);
        for (var j = 0; j < currentRelease.assets.length; j++) {
          var currDowndloadCount = currentRelease.assets[j].download_count;
          if (data.datasets[i]) {
            data.datasets[i].data.push(currDowndloadCount[currDowndloadCount.length - 1].count);
          } else {
            data.datasets.push({
              label: '',
              backgroundColor: getRandomColor(),
              data: [currDowndloadCount[currDowndloadCount.length - 1].count]
            });
          }
        }
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
        }
      }
    });
  }
});
