# make-proto

## 协议源文件为yaml格式

## 字段
- pt-num: 协议号
- pt-type: server | s | client | c
- pt-marco: 宏名字
- pt-alias: 协议号字符串(别名)
- pt-comment: 协议注释,置于读写方法前
- pt-content: 协议内容
	  key0: val0
	  key1: val1
	  keyx: valx

## 方法
### marco2num
- 1.以pt-num生成前缀为pt-type的宏 `-define(S/C_PTMARCO, pt-num). %% pt-comment`
- 2.以pt-alias生成前缀为pt-type的宏 `-define(S/C_PTMARCO_STR, pt-alias). %% pt-comment`
