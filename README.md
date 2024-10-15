# ROS_DDNS-scripts-for-Cloudflare

## 1. 简介

本脚本适合于以下情况：
- RouterOS 7.6 以上版本；
- 将域名托管在 cloudflare 上的；
- 仅用于 IPv6 的 DDNS 更新。

## 2. 准备工作

在开始之前，请确保以下条件已经满足：

- 从 cloudflare 处获取：CF_Token，CF_Zone_ID，CF_Record_ID，Your_Domain；
- 若需要 server酱 提醒服务，则需要前往[https://sct.ftqq.com/]注册获取 serverChan_key；
- 确认本地获取 IPv6 的接口，一般默认为 pppoe-out1，具体可以在 RouterOS terminal 中输入 “/interface/pppoe-client” 查看；
- 最后需要确定你所在地的 DNS 服务商，必须能够正常解析你所提供域名的 IPv6 地址的，默认为：114.114.114.114，可根据情况酌情修改。

## 3. 获取脚本

使用 `/tool fetch` 命令从远程 URL 下载脚本文件，并将其保存到 `/scripts` 目录中。

```plaintext
/tool fetch download-to=/flash/scripts/CF_DDNS.rsc url=https://raw.githubusercontent.com/kiss2u/ROS_DDNS-scripts-for-Cloudflare/refs/heads/main/CF_DDNS.rsc

通过以下命令检查：
```plaintext
/file print where path="/flash/scripts/CF_DDNS.rsc"

显示如下信息则表示下载成功：
```plaintext
flags: none; size: 1024; mtime: 2024-09-15T12:00:00Z; ctime: 2024-09-15T12:00:00Z; atime: 2024-09-15T12:00:00Z; name: CF_DDNS.rsc

## 4. 执行脚本

一旦脚本下载完成并保存到了 /scripts 目录中，你可以通过以下命令来执行脚本：

```plaintext
/system script run name=CF_DDNS

## 5. 致谢

UE-DDNS[https://github.com/kkkgo/UE-DDNS/tree/main]
License：GPLv3
