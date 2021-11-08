# 如何部署Vault

### 使用Docker Compose安装Vault

```
git clone https://gitee.com/jianmu-dev/jianmu-deploy.git
cd jianmu-deploy
docker-compose -f docker-compose-vault.yml up -d
```

#### 生成自签名证书

首先修改`volumes/cert/cert.conf`中的`CN`和`IP.1`为本机IP

**注意：** 这里如果写错有可能导致Chrome等浏览器无法打开Vault的UI界面

然后在`volumes/cert/`目录下，使用openssl生成证书和Key

```
openssl req -nodes -x509 -days 365 -keyout vault.key -out vault.crt -config cert.conf
```

#### 进入容器

```
docker exec -it 容器id sh
```

#### 设置环境变量

```
export VAULT_SKIP_VERIFY=true
export VAULT_ADDR="https://192.168.1.24:443"
```

#### 初始化vault
```
vault operator init
```
示例输出
```
Unseal Key 1: 4jYbl2CBIv6SpkKj6Hos9iD32k5RfGkLzlosrrq/JgOm
Unseal Key 2: B05G1DRtfYckFV5BbdBvXq0wkK5HFqB9g2jcDmNfTQiS
Unseal Key 3: Arig0N9rN9ezkTRo7qTB7gsIZDaonOcc53EHo83F5chA
Unseal Key 4: 0cZE0C/gEk3YHaKjIWxhyyfs8REhqkRW/CSXTnmTilv+
Unseal Key 5: fYhZOseRgzxmJCmIqUdxEm9C3jB5Q27AowER9w4FC2Ck

Initial Root Token: s.KkNJYWF5g0pomcCLEmDdOVCW

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 3 key to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
```
保存输出的`Unseal Key`和`Root Token`备用

解封Vault, 输入上面保存的Key，默认情况下需要输入3个不同的Key
```
vault operator unseal
```
解封后，使用上面的Root Token登录
```
vault login <Initial_Root_Token>
```

登录成功后，开启cert认证模式
```
# 开启cert认证模式
vault auth enable cert
# 写入证书
vault write auth/cert/certs/jianmu policies=jianmu certificate=@/vault/cert/vault.crt ttl=1h
# 写入policy
vault policy write jianmu /vault/config/jianmu-policy.hcl
```
验证一下是否成功开启
```
vault login -method=cert -client-cert=/vault/cert/vault.crt -client-key=/vault/cert/vault.key name=jianmu
# 写入数据
vault kv put jianmu/test bar=baz
# 读取数据
vault kv get -version=1 jianmu/test
```
应返回
```
=== Data ===
Key    Value
---    -----
bar    baz
```
至此Vault部署成功