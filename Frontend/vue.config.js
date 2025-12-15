module.exports = {
  transpileDependencies: true,
  devServer: {
    proxy: {
      '/api': {
        target: 'http://backend:8000', // For Docker Compose
        changeOrigin: true,
        pathRewrite: {
          '^/api': '/api' // Optional: rewrite the path if needed
        }
      }
    }
  }
}