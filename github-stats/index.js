const fs = require('fs');
var RepoCompulse = require('./repo-compulse');

var token = fs.readFileSync("../GITHUB_TOKEN", "utf8").trim();

if (process.argv.length < 5) {
  console.error("You must specify the github username, repository name and path to output file");
  console.error(process.argv[0] + " " + process.argv[1] + " <github_user> <repository> <path_output>");
  process.exit(1);
}

var user = process.argv[2], repo = process.argv[3];

RepoCompulse.compulseStats(user, repo, token, process.argv[4]);
