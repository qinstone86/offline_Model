path_fairseq=./nmt_transformer_offline_0.10.0/fairseq_cli

data_dirr=./model/data

input_file=./test/test.en.bpe

ref_file=./test/test.zh

files=$(ls $model_dirr)

res_dirr=test

output_file=$res_dirr/test.translation

model_path=model/checkpoint_best.pt 
CUDA_VISIBLE_DEVICES=0 python $path_fairseq/interactive.py $data_dirr \
                        --task translation  \
                        --source-lang en --target-lang zh \
                        --path $model_path \
                        --buffer-size 2000 --batch-size 128 --remove-bpe \
                        --beam 5 --input $input_file # | grep "H-"| cut -f3 > $output_file
