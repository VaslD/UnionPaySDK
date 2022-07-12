# 银联云闪付 iOS SDK

获取自“云闪付网络支付平台（商户侧）”业务产品详情，更新于 2022-07-13：

https://open.unionpay.com/tjweb/acproduct/list?apiSvcId=450&index=5



SDK 包含“客户端用” (`libPaymentControlPure`) 和“通用版” (`libPaymentControlMini`) 两个库。

由于接入文档没有指明两者的区别，此仓库同时提供两个版本，通过 subspec 选取：

- `UnionPay/Pure`
- `UnionPay/Mini`



此项目并非官方项目，所提供 SDK 为个人封装，方便在 CocoaPods 生态中依赖。

原文件归中国银联版权所有 © 2002-2022