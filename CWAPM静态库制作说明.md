## CWAPM静态库制作说明

1. 调试 编辑使用 Example工程
2. 运行updatePods.sh脚本，将当前编辑推送到CWAPM仓库tag N
3. 执行静态库生成脚本CWAPM.sh会去拉去步骤2中推送过去的代码生成静态库文件和头文件
4. 将步骤3中的静态库文件和头文件放在CWAPM_frameroke下,执行updatePods.sh脚本发布
