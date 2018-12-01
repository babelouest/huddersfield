const request = require('request-promise');

exports.getStats = (user, repo, token) => {
  var stats = {
    stargazers: 0,
    watchers: 0,
    forks: 0,
    views: {},
    clones: {},
    referrers: [],
    paths: [],
    statistics: {
      commit_activity: [],
      code_frequency: []
    },
    releases: []
  };
  
  var promises = [];
  var requestOptions = {url: "", headers: {Authorization: "token " + token.trim(), "User-Agent": "nodejs"}, json: true, resolveWithFullResponse: true, method: "GET"};
  var apiPrefix = "https://api.github.com/repos/";
  var promises = [];

  requestOptions.url = apiPrefix + user + "/" + repo;
  promises.push(request(requestOptions)
  .then((result) => {
    stats.stargazers = result.body.stargazers_count;
    stats.watchers = result.body.subscribers_count;
    stats.forks = result.body.forks_count;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/traffic/views";
  promises.push(request(requestOptions)
  .then((result) => {
    stats.views = result.body;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/traffic/popular/referrers";
  promises.push(request(requestOptions)
  .then((result) => {
    stats.referrers = result.body;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/traffic/popular/paths";
  promises.push(request(requestOptions)
  .then((result) => {
    stats.paths = result.body;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/traffic/clones";
  promises.push(request(requestOptions)
  .then((result) => {
    stats.clones = result.body;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/stats/commit_activity";
  promises.push(request(requestOptions)
  .then((result) => {
    var commit_activity = [];
    for (var i in result.body) {
      if (result.body[i].total) {
        commit_activity.push(result.body[i]);
      }
    }
    stats.statistics.commit_activity = commit_activity;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/stats/code_frequency";
  promises.push(request(requestOptions)
  .then((result) => {
    var code_frequency = [];
    for (var i in result.body) {
      if (result.body[i][1] || result.body[i][2]) {
        code_frequency.push(result.body[i]);
      }
    }
    stats.statistics.code_frequency = code_frequency;
  }));

  requestOptions.url = apiPrefix + user + "/" + repo + "/releases";
  promises.push(request(requestOptions)
  .then((result) => {
    for (var i in result.body) {
      var release = {
        tag_name: result.body[i].tag_name,
        name: result.body[i].name,
        created_at: result.body[i].created_at,
        published_at: result.body[i].published_at,
        html_url: result.body[i].html_url,
        assets: [],
        assets_download: 0
      };
      for (var j in result.body[i].assets) {
        release.assets.push({
          name: result.body[i].assets[j].name,
          size: result.body[i].assets[j].size,
          download_count: result.body[i].assets[j].download_count
        });
        release.assets_download += result.body[i].assets[j].download_count;
      }
      stats.releases.push(release);
    }
  }));

  return Promise.all(promises)
  .then(() => {
    return stats;
  });
}
