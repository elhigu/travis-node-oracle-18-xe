const oracledb = require("oracledb");

const conf = {
  user: "system",
  password: "Oracle18",
  connectString: "localhost:21521/XE",
  // https://github.com/oracle/node-oracledb/issues/525
  stmtCacheSize: 0
};

async function main() {
  try {
    const c1 = await oracledb.getConnection(conf);
    const res = await c1.execute(`SELECT 13376411 FROM DUAL`);
    console.log(res);
  } catch (e) {
    console.log(e);
    process.exit(1);
  }
}

main();
