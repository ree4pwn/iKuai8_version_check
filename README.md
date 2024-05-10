# iKuai8_version_check

对manifest.xxx.js的文件名与md5进行比对，得到版本号，该方式适用于3.4.2及以上版本。

## 固件获取

获取所有下载bin的下载链接，固定地址https://patch.ikuai8.com/3.x/patch/iKuai8_<arch>_<version>_<buildtime>.<iso|bin|gho|img.gz>

下载所有固件

```BASH
cat download_link| xargs -n 1 -P 10 wget
```

## 版本获取

运行 `get_manifest_md5sum.sh` 计算得到文件名与md5

```BASH
for i in `ls iKuai*`;do sudo bash ./get_manifest_md5sum.sh $i >> version.csv ; done
```

## version

|version|arch|manifest|md5|
|:-:|:-:|:-:|:-:|
3.4.2|x64|manifest.d42b117034b091e48afe.js|6dbd4ffb7814372cab33ba2e9f7caf9e
3.4.3|x64|manifest.c65fc0b5744067d5b1c2.js|2dd92cb8d51cfb79dc970e37bd2b41e0
3.4.7|x64|manifest.f600273201148b331ccb.js|8b40d16e7cb4b67817e978411f73541b
3.4.8|x64|manifest.dd9ee0f409b482e1aeb5.js|f51003154833d68f4060425ebf4c9b0b
3.4.9|x64|manifest.5b48a046f621f7b6c6a8.js|a3f5bff7b9bd742458ca4c839e7ab557
3.5.0|x64|manifest.8196b95602930dbb944d.js|027079841fe7fe0bc4fbb81821b41554
3.5.10|x64|manifest.fbee6a57a76374d8d545.js|25e1740115e2ac33fbcf00e46c442c8d
3.5.11|x64|manifest.99e79c442d0ad87991b2.js|fc174e82a68f033b65b6e450d7462d30
3.5.12|x64|manifest.99e79c442d0ad87991b2.js|fc174e82a68f033b65b6e450d7462d30
3.5.1|x64|manifest.8196b95602930dbb944d.js|027079841fe7fe0bc4fbb81821b41554
3.5.2|x64|manifest.62d01877bcc2e558c7dc.js|b57b7b99474c23877f8b32d018a4473c
3.5.3|x64|manifest.9ab296016ab45383de91.js|8825d99a03ed1cbbbbc87a13860bc5c6
3.5.4|x64|manifest.b641ee19e25813d15ce9.js|7cfa02e7c7d9a719f27a7497ebb88618
3.5.5|x64|manifest.88a85ac5c7b9c3342e7e.js|62d00e44c58d7dfdac62d630c63da2f1
3.5.6|x64|manifest.5a4b60fbf31c3e0f49db.js|71b5d47b032c52d858f53edf4d8cd071
3.5.7|x64|manifest.1358866a94deeabeb485.js|6478c24d7abc78749c87a619244eda1d
3.5.8|x64|manifest.d9ce2f79a5b68df119a8.js|d3c580dbd3fce2caa49b711f663b4735
3.5.9|x64|manifest.fbee6a57a76374d8d545.js|25e1740115e2ac33fbcf00e46c442c8d
3.6.0|x64|manifest.cc8deb2fa9a1afd9ca24.js|a2ecec6fcf2f243c99eb96cde3f906cb
3.6.10|x64|manifest.e63a87af9a4e1ff59452.js|cab3f7f41845b708555b25f13f8a78b2
3.6.11|x64|manifest.7cf9260568ed1b2a62cf.js|e142bb66729871bbfe118b5ac661fbbf
3.6.12|x64|manifest.71527c5253c8e0d1c7e0.js|7a5a0f0ce9aab6091755c03fbd74b542
3.6.13|x64|manifest.71527c5253c8e0d1c7e0.js|7a5a0f0ce9aab6091755c03fbd74b542
3.6.1|x64|manifest.1ec56656226df62aee10.js|39d06f441bf9641f081cbb356ced4848
3.6.2|x64|manifest.9e153f1174c3d6eb4992.js|8baf3db7758e3d61da2b00e32ee3c8b3
3.6.3|x64|manifest.b10fbbb636073c880ac2.js|eb0dd0be483e8df3fb4450beb2866e30
3.6.4|x64|manifest.9582d3525a92c935afef.js|3d85500f030d6939d7ab93b527f503c8
3.6.5|x64|manifest.97dbc3e97a2942216f26.js|79d8675aa5c4dc8e6afb7fea5a5199bf
3.6.6|x64|manifest.fe06239c7503960aa674.js|136b82b4a82b99d38a927a5d2fdbecef
3.6.7|x64|manifest.88b8c526b7017a92f28f.js|de329e86cbb1c4181fd7043ee3ad7c20
3.6.8|x64|manifest.e77066aa79eda757d3d7.js|f924977b3faf3f9166c9ecdc24aad349
3.6.9|x64|manifest.95eb000e8ca8e3efff3d.js|608974119a4a7b6311b669344ec0fd33
3.7.0|x64|manifest.4a0be13e77595c416358.js|6c325024873d1be5d2d4c9154d693bcf
3.7.10|x64|manifest.6d77d3bd8378bda54121.js|01ba27c3724ee50d08185802b596b853
3.7.11|x64|manifest.f7b3364de16d34248d55.js|93bc8e128f6f65636c91303ae16c417a
3.7.1|x64|manifest.94944335338b75787c0d.js|a525f2e344a6bac56aab3902964aec4e
3.7.2|x64|manifest.bd94de543ed773a2148c.js|27804026a09e4b9f0dfe185f3c78e5e2
3.7.3|x64|manifest.76786e6e72c3172859c9.js|0c46188531827f302d0ab0d619d2d632
3.7.4|x64|manifest.5ff991a64b3b5549bd78.js|c67623997655006cfe12fb1f75a2d0a9
3.7.5|x64|manifest.e85b486e4b80c0f8a3cf.js|55bdb1900fdab8cf4926c8553d1221ec
3.7.6|x64|manifest.6b4e21916369c156495a.js|8ff6e1586c27b3a17987dd1c5707e8de
3.7.7|x64|manifest.6fd25e39c0c7b3bf3295.js|278451b1bb8ce59dd63db02e1cd3d4f0
3.7.8|x64|manifest.da29f5660e21470791bd.js|97687819d33b3c6ce105c29a566fbdca
3.7.9|x64|manifest.e84872871fc439fa8b98.js|9a053c37437779219219bd00f7d7fe7f
