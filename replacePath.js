const fs = require("fs").promises,
  htmlPath = process.argv[2],
  txtPath = process.argv[3],
  txtHTMLPath = process.argv[4],
  term = process.argv[5];

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

fs.readFile(htmlPath, { encoding: "utf8" }).then((htmlContents) => {
  var nextLineReplace = false;
  fs.writeFile(
    htmlPath,
    htmlContents
      .split(/\n|\r/g)
      .map((line) => {
        if (nextLineReplace) {
          console.log(
            "replace line: `" +
              line +
              '` with `    window.icl.CURRENT_PATH = "' +
              txtHTMLPath +
              '";`',
          );
          nextLineReplace = false;
          return '    window.icl.CURRENT_PATH = "' + txtHTMLPath + '";';
        }
        if (line.includes("MARK-NEXTLINEPATH")) {
          console.log("replace next line");
          nextLineReplace = true;
        }
        return line;
      })
      .join("\n"),
  );
});
