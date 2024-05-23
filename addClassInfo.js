const fs = require("fs").promises,
  txtPath = process.argv[2],
  term = process.argv[3];

fs.readFile(txtPath, { encoding: "utf8" }).then((txtContents) => {
  const dataStatus =
    term.padEnd(9, " ") +
    "Version\n.A00Kevin,Fisher\n0035APM  12345LE1313 08001930A00",
    splitText = txtContents.split(/\n|\r/g)
  fs.writeFile(
    txtPath,
    [].concat(
      splitText[0],
      dataStatus,
      splitText.slice(1)
    )
      .join("\n"),
  );
});
