# ROS_DDNS-scripts-for-Cloudflare

## 1. 简介

本脚本适用于以下情况：
- RouterOS 7.6 以上版本；
- 将域名托管在 Cloudflare 上的；
- 仅用于 IPv6 的 DDNS 更新。

## 2. 准备工作

在开始之前，请确保以下条件已经满足：

- **从 Cloudflare 获取**：
  - CF_Token：Cloudflare 的 API 令牌；
  - CF_Zone_ID：Cloudflare 区域 ID；
  - CF_Record_ID：Cloudflare DNS 记录 ID；
  - Your_Domain：需要更新的域名；

- **Server 酱提醒服务**：
  - 如果需要 Server 酱提醒服务，请前往 [https://sct.ftqq.com/] 注册并获取 ServerChan_key；

- **确认本地 IPv6 接口**：
  - 默认为 `pppoe-out1`，具体可以在 RouterOS 终端中输入 `/interface/pppoe-client` 查看；

- **确认 DNS 服务商**：
  - 必须能够正常解析你所提供域名的 IPv6 地址，默认为 `114.114.114.114`，可根据情况酌情修改。

## 3. 获取脚本

使用 `/tool fetch` 命令从远程 URL 下载脚本文件，并将其保存到 `/scripts` 目录中。

```routeros scripts
/tool fetch download-to=/flash/scripts/CF_DDNS.rsc url=https://raw.githubusercontent.com/kiss2u/ROS_DDNS-scripts-for-Cloudflare/refs/heads/main/CF_DDNS.rsc
```

通过以下命令检查下载是否成功：
```routeros scripts
/file print where path="/flash/scripts/CF_DDNS.rsc"
```

如果下载成功，命令将输出类似如下信息：
```routeros scripts
flags: none; size: 1024; mtime: 2024-09-15T12:00:00Z; ctime: 2024-09-15T12:00:00Z; atime: 2024-09-15T12:00:00Z; name: CF_DDNS.rsc
```

## 4. 执行脚本

一旦脚本下载完成并保存到了 /scripts 目录中，你可以通过以下命令来执行脚本：
```routeros scripts
/system script run name=CF_DDNS
```

## 5. 致谢

本脚本基于以下项目进行了修改：

UE-DDNS：[https://github.com/kkkgo/UE-DDNS/tree/main]

License：GPLv3
