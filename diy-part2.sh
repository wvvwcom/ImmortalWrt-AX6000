#!/bin/bash
###
 # @Author: xiawang1024
 # @Date: 2023-02-11 21:21:21
 # @LastEditTime: 2023-02-25 17:16:22
 # @LastEditors: IraXu
 # @Description: 
 # @FilePath: /ImmortalWrt-RedMi-AX6000/diy2-part2.sh
 # 开源让世界美好
### 

# 更新指定软件包
# ./scripts/feeds uninstall alist luci-app-alist luci-app-vlmcsd
# ./scripts/feeds install -p nuexini alist luci-app-alist luci-app-vlmcsd



# 删除多余的主题和软件包，直接在ax6000_hanwckf.config里面配置
# sed -i '/CONFIG_PACKAGE_luci-theme-argon=y/d' .config
# sed -i '/.*luci-theme-bootstrap-mod.*/d' .config
# sed -i '/.*luci-app-ssr-plus.*/d' .config
# sed -i '/.*luci-app-passwall.*/d' .config

# 自定义默认网关，后方的192.168.10.1即是可自定义的部分
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
# 固件版本名称自定义
# sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='ImmortalWrt By IraXu $(date +"%Y%m%d") '/g" package/base-files/files/etc/openwrt_release

# 更新golang版本，修改为主线版本，alist xray 编译要求21.x
rm -rf feeds/packages/lang/golang
svn co https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang

# 更新frpc，golang版本更新后，旧版本编译报错，需要放在feeds/packages/net/frp路径下，makefile有相对路径依赖golang
rm -rf feeds/packages/net/frp
svn co https://github.com/coolsnowwolf/packages/trunk/net/frp feeds/packages/net/frp
rm -rf feeds/luci/applications/luci-app-frpc
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frpc feeds/luci/applications/luci-app-frpc
rm -rf feeds/luci/applications/luci-app-frps
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frps feeds/luci/applications/luci-app-frps

# 中文包的命名ImmortalWrt和Lede不一样，修改适配
mv feeds/luci/applications/luci-app-frpc/po/zh-cn feeds/luci/applications/luci-app-frpc/po/zh_Hans
mv feeds/luci/applications/luci-app-frps/po/zh-cn feeds/luci/applications/luci-app-frps/po/zh_Hans

# frp新版本依赖，会报警，编译不会报错
rm -rf package/feeds/packages/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ucl package/feeds/packages/ucl
rm -rf package/feeds/packages/upx
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/upx package/feeds/packages/upx

# fw876/helloworld，使用主分支， main分支针对openwrt23版本
rm -rf package/feeds/helloworld
git clone https://github.com/fw876/helloworld.git package/feeds/helloworld
rm -rf package/feeds/luci/luci-app-ssr-plus
rm -rf package/feeds/packages/chinadns-ng
rm -rf package/feeds/packages/dns2socks
rm -rf package/feeds/packages/dns2tcp
rm -rf package/feeds/packages/gn
rm -rf package/feeds/packages/hysteria
rm -rf package/feeds/packages/ipt2socks
rm -rf package/feeds/packages/lua-neturl
rm -rf package/feeds/packages/microsocks
rm -rf package/feeds/packages/mosdns
rm -rf package/feeds/packages/naiveproxy
rm -rf package/feeds/packages/redsocks2
rm -rf package/feeds/packages/shadowsocksr-libev
rm -rf package/feeds/packages/shadowsocks-rust
rm -rf package/feeds/packages/shadow-tls
rm -rf package/feeds/packages/simple-obfs
rm -rf package/feeds/packages/tcping
rm -rf package/feeds/packages/trojan
rm -rf package/feeds/packages/tuic-client
rm -rf package/feeds/packages/v2raya
rm -rf package/feeds/packages/v2ray-core
rm -rf package/feeds/packages/v2ray-geodata
rm -rf package/feeds/packages/v2ray-plugin
rm -rf package/feeds/packages/xray-core
rm -rf package/feeds/packages/xray-plugin

# ilxp/luci-app-ikoolproxy，路径放在helloworld同目录
rm -rf package/feeds/helloworld/luci-app-ikoolproxy
git clone https://github.com/ilxp/luci-app-ikoolproxy.git package/feeds/helloworld/luci-app-ikoolproxy