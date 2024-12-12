function H=HashSumRowSumCol(PlainImg,KeyHex)
    SumRow=sum(PlainImg,2);  %行和
    SumCol=sum(PlainImg,1);  %列和
    SumDiag=sum(spdiags(rot90(PlainImg)));  %对角线和
    SumCol=SumCol';
    D=[HashFunction(SumRow,'MD2') HashFunction(SumCol,'MD5') HashFunction(SumDiag,'SHA384')   HashFunction(KeyHex,'SHA512')];
    H=HashFunction(D,'SHA-256');
end