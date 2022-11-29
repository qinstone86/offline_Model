input_file=test/test.en
output_file=test/test.en.bpe

#全半角转换
python tools/full2half.py < $input_file > $input_file.f2h

#分词
./tools/tokenizer.perl < $input_file.f2h > $input_file.f2h.token

#大写转小写
cat $input_file.f2h.token | tr A-Z a-z >  $input_file.f2h.token.low

#bpe
python tools/apply_bpe.py --codes train.en.bpe_codes --input  $input_file.f2h.token.low --output $output_file
