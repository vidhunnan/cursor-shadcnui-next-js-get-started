/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    appDir: true,
  },
  webpack: (config, { dev, isServer }) => {
    if (!dev && !isServer) {
      // Use optimized CSS in production
      const path = require('path');
      config.resolve.alias['@/styles/globals.css'] = path.resolve(
        __dirname,
        './app/globals.optimized.css'
      );
    }
    return config;
  },
}

module.exports = nextConfig 