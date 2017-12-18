mkdir b2b
cd b2b
git clone http://192.168.0.204/zaki/my-admin-portal.git
git clone http://192.168.0.204/zaki/my-buyer-portal.git
git clone http://192.168.0.204/zaki/my-supplier-portal.git
cd my-admin-portal
yarn install
cd ../my-buyer-portal
yarn install
cd ../my-supplier-portal
yarn install
