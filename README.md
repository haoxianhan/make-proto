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
### gen_pt_marco2num.scm
- 1.生成前缀为pt-type的宏 `-define(S/C-MARCO, pt-num).`
- 2.生成前缀为pt-type的宏 `-define(S/C-MARCO, pt-alias).`
