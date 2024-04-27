const path = require("path");

module.exports = {
  entry: "./index.js", // Entry point of your application
  output: {
    path: path.resolve(__dirname, "dist"), // Output directory
    filename: "bundle.js", // Output filename
  },
  resolve: {
    fallback: {
      assert: require.resolve("assert"),
      url: require.resolve("url"),
      util: require.resolve("util"),
    },
  },
  module: {
    rules: [
      {
        test: /\.js$/, // Apply loader to all JavaScript files
        exclude: /node_modules/,
        use: {
          loader: "babel-loader", // Use babel-loader for transpiling ES6+ code
          options: {
            presets: ["@babel/preset-env"], // Use @babel/preset-env for configuring babel
          },
        },
      },
    ],
  },
};
