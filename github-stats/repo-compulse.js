const fs = require('fs');
var RepoStats = require('./repo-stats');
var moment = require('moment');
var _ = require('lodash');

exports.compulseStats = (user, repo, token, path) => {
  var myStats = RepoStats.getStats(user, repo, token);
  var nowDay = moment(new Date()).format("YYYY-MM-DD");
  var outputFile = path + "/repo-" + repo + ".json";
  var indexFile = path + "/index.json";
  var repoCompulsedStats = {
    general: [],
    views: {
      count: 0,
      uniques: 0,
      views: [
      ],
      referrers: [],
      paths: [],
    },
    clones: {
      count: 0,
      uniques: 0,
      clones: [
      ]
    },
    releases: []
  };
  var repoFileList = [];

  if (fs.existsSync(outputFile)) {
    var repoFile = fs.readFileSync(outputFile, "utf8").trim();
    try {
      repoCompulsedStats = JSON.parse(repoFile);
    } catch (e) {
      console.err("Unable to parse file " + outputFile + " as JSON");
    }
  }

  if (fs.existsSync(indexFile)) {
    var repoFile = fs.readFileSync(indexFile, "utf8").trim();
    try {
      repoFileList = JSON.parse(repoFile);
      if (!_.find(repoFileList, (curRepo) => { return (curRepo === repo); })) {
        repoFileList.push(repo);
        repoFileList = _.sortBy(repoFileList, (repo) => { return repo; });
        fs.writeFileSync(indexFile, JSON.stringify(repoFileList), "utf8");
      }
    } catch (e) {
      console.err("Unable to parse file " + indexFile + " as JSON");
    }
  } else {
    repoFileList.push(repo);
    fs.writeFileSync(indexFile, JSON.stringify(repoFileList), "utf8");
  }

  myStats.then((stats) => {
    // Compulse general stats
    repoCompulsedStats.general.push({
      date: nowDay,
      stargazers: stats.stargazers,
      watchers: stats.watchers,
      forks: stats.forks
    });

    // Compulse views
    _.forEach(stats.views.views, (view) => {
      var storedView;
      if (!(storedView = _.find(repoCompulsedStats.views.views, (storedView) => {return (storedView.timestamp === view.timestamp);}))) {
        repoCompulsedStats.views.views.push(view);
        repoCompulsedStats.views.count += view.count;
        repoCompulsedStats.views.uniques += view.uniques;
      } else {
        if (storedView.count !== view.count || storedView.uniques !== view.uniques) {
          storedView.count = view.count;
          storedView.uniques = view.uniques;
        }
      }
    });

    // Compulse referrers
    _.forEach(stats.referrers, (referrer) => {
      var storedReferrer = _.find(repoCompulsedStats.views.referrers, (storedRefferer) => {return (storedRefferer.referrer === referrer.referrer);});
      if (!storedReferrer) {
        referrer.date = nowDay;
        repoCompulsedStats.views.referrers.push(referrer);
      } else {
        var dateRefferer = moment(storedReferrer.date);
        if (moment(nowDay).diff(moment(storedReferrer.date), 'days') > 14) {
          storedReferrer.count += referrer.count;
          storedReferrer.uniques += referrer.uniques;
          storedReferrer.date = nowDay;
        }
      }
    });

    // Compulse paths
    _.forEach(stats.paths, (path) => {
      var storedPath = _.find(repoCompulsedStats.views.paths, (storedPath) => {return (storedPath.path === path.path);});
      if (!storedPath) {
        path.date = nowDay;
        repoCompulsedStats.views.paths.push(path);
      } else {
        var datePath = moment(storedPath.date);
        if (moment(nowDay).diff(moment(storedPath.date), 'days') > 14) {
          storedPath.count += path.count;
          storedPath.uniques += path.uniques;
          storedPath.date = nowDay;
        }
      }
    });

    // Compulse clones
    _.forEach(stats.clones.clones, (clone) => {
      var storedClone
      if (!(storedClone = _.find(repoCompulsedStats.clones.clones, (storedClone) => {return (storedClone.timestamp === clone.timestamp);}))) {
        repoCompulsedStats.clones.clones.push(clone);
        repoCompulsedStats.clones.count += clone.count;
        repoCompulsedStats.clones.uniques += clone.uniques;
      } else {
        if (storedClone.count !== clone.count || storedClone.uniques !== clone.uniques) {
          storedClone.count = clone.count;
          storedClone.uniques = clone.uniques;
        }
      }
    });

    // Compulse releases
    _.forEach(stats.releases, release => {
      var curRelease = _.find(repoCompulsedStats.releases, (myRelease) => { return (myRelease.tag_name === release.tag_name); });
      var newReleases = [];
      if (curRelease) {
        curRelease.assets_download = release.assets_download;
        _.forEach(release.assets, (asset) => {
          var curAsset = _.find(curRelease.assets, (curAsset) => { return (curAsset.name === asset.name); });
          curAsset.download_count.push({date: nowDay, count: asset.download_count});
        });
      } else {
        var curRelease = release;
        _.forEach(curRelease.assets, (asset) => {
          asset.download_count = [{date: nowDay, count: asset.download_count}];
        });
        newReleases.push(curRelease);
      }
      repoCompulsedStats.releases = newReleases.concat(repoCompulsedStats.releases);
    });

    fs.writeFileSync(outputFile, JSON.stringify(repoCompulsedStats), "utf8");
  });
}
