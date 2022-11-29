path_fairseq=./nmt_transformer_offline_0.10.0/fairseq_cli

data_dirr=/mnt/5a7d1f8f-9f33-435f-b2f3-bf2936c0073f/zhangxu/zhangpei/data/zh-en/train_data

lr=0.001

arch=transformer_vaswani_wmt_en_de_E6D2_hy
bath_size=$[8192]

model_path=/mnt/5a7d1f8f-9f33-435f-b2f3-bf2936c0073f/zhangxu/zhangpei/data/zh-en/en2zh_yt/data_train2
save_dirr=$model_path/checkpoints


ChunkData=$(ls $data_dirr)
ALLDATA=""
for filechunk in ${ChunkData};do
        if [ ! -d $data_dirr/$filechunk ];then
                continue
        fi
        ALLDATA=${ALLDATA}:$data_dirr/${filechunk}
done

if [ ${#ALLDATA} -eq 0 ]; then
        ALLDATA=$data_dirr
else
        ALLDATA=${ALLDATA:1:${#ALLDATA}}
fi

echo $ALLDATA


CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
python $path_fairseq/train.py  $ALLDATA  \
	--source-lang en --target-lang zh \
        --arch $arch --task translation --log-format simple --log-interval 10 \
        --optimizer adam --adam-betas '(0.9, 0.98)' --clip-norm 0.0 \
        --lr $lr --lr-scheduler inverse_sqrt --warmup-updates 4000 \
        --dropout 0.1 --weight-decay 0.0001 \
        --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
        --max-tokens $bath_size --update-freq 8 --max-epoch 1000 --save-interval-updates 500 \
	 --save-dir $save_dirr --fp16 
