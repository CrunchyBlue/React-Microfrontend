const { merge } = require("webpack-merge");
const ModuleFederationPlugin = require("webpack/lib/container/ModuleFederationPlugin");
const commonConfig = require("./webpack.common");

const prodConfig = {
  mode: "production",
  output: {
    publicPath: "/marketing/latest/",
    filename: "[name].[contenthash].js",
  },
  plugins: [
    new ModuleFederationPlugin({
      name: "marketing",
      filename: "remoteEntry.js",
      exposes: {
        "./Mount": "./src/bootstrap",
      },
      shared: ["react", "react-dom", "react-router-dom"],
    }),
  ],
};

module.exports = merge(commonConfig, prodConfig);
