const fs = require("fs").promises,
  txtPath = process.argv[2],
  term = process.argv[3];

console.log(htmlPath, txtPath, term);

fs.readFile(txtPath, { encoding: "utf8" }).then((txtContents) => {
  const dataStatus =
    term.padEnd(9, " ") +
    "Version\n.A00Kevin,Fisher\n0035APM  12345LE1313 08001930A00";
  fs.writeFile(
    txtPath,
    txtContents
      .split(/\n|\r/g)
      .map((line, idx) => {
        if (idx == 1) {
          return dataStatus + "\n" + line;
        }
        return line;
      })
      .join("\n"),
  );
});
