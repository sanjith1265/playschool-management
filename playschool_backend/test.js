const dns = require("dns");

dns.resolveSrv(
  "_mongodb._tcp.playschool-management.0lqemnj.mongodb.net",
  (err, records) => {
    console.log("Error:", err);
    console.log("Records:", records);
  }
);