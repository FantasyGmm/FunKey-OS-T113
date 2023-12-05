# FunKey-T113

## 获取源码设置环境
```
git clone --depth=1 https://github.com//FantasyGmm/FunKey-T113
cd FunKey-T113/
git submodule update --init --recursive     # 初始化子模块仓库
source envsetup.sh                          # 配置编译环境
make fun                                    # 编译系统
make fun_menuconfig                         # 配置br
make fun_menuconfig_linux                   # 配置内核
make fun_menuconfig_uboot                   # 配置uboot
make fun_rebuild_linux                      # 重新编译内核
make fun_rebuild_uboot                      # 重新编译uboot
make fun_rebuild_busybox                    # 重新编译busybox
make fun_defconfig                          # 保存所有配置到板级文件夹
```

### 更多make可用命令,见子模块仓库的Makefile文件
### 修改的文件夹在子模块内部，如果需要提交仓库请复制出来覆盖到外部ExtBuild里面
