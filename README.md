### 训练代码
```
nmt_transformer_0.10.0
```
### 模型

```
1. 模型
   model/checkpoint_best.pt 
   由于github上保存的最大模型为100M，现在将模型打包切片，切片后用以下命令即可得到翻译模型checkpoint_best.pt ：
   cd model/
   cat model.tar.0  model.tar.1  model.tar.2  model.tar.3  model.tar.4  model.tar.5  model.tar.6  model.tar.7  model.tar.8  model.tar.9 > model.tar 
   tar –xvf model.tar
   
2. 词典
   model/data/dict.* 
   
3. bpe codes
   train.en.bpe_codes
```

### 前后处理
```
1. 英文前处理
   preProcessing.sh
2. 中文后处理
   postProcessing.sh
```

### 训练与解码脚本
```
1-train.sh  
2_decoder.sh 
```
