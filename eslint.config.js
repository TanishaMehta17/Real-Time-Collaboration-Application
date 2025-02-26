module.exports = [
    {
      ignores: ["node_modules", "dist"], // Ignore common folders
    },
    {
      files: ["**/*.js"], // Apply rules to JavaScript files
      languageOptions: {
        ecmaVersion: "latest",
        sourceType: "module",
      },
      rules: {
        "no-unused-vars": "warn",
        "no-console": "off",
      },
    },
  ];
  