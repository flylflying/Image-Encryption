%置乱程度
clc 
clear
close all
tic;
Img = imread('images/lena.bmp');
jiami = Zigzagop(Img);
jiami(1:512,1:50) = 0;
jiami(1:50,51:512) = 0;
jiami(463:512,51:512) = 0;
jiami(51:462,463:512) = 0;
jiemi = iZigzagop(jiami);
toc;
figure(1);
imshow(uint8(Img)); title('原始图像'); 
figure(2);
imshow(uint8(jiami)); title('置乱图像');
figure(3);
imshow(uint8(jiemi)); title('解密图像'); 
num1=fenkuai(64,jiemi,1);
num2=fenkuai(64,jiemi,2);
num3=fenkuai(64,jiemi,3);
num4=fenkuai(64,jiemi,4);
num5=fenkuai(64,jiemi,5);
num6=fenkuai(64,jiemi,6);
num7=fenkuai(64,jiemi,7);
num8=fenkuai(64,jiemi,8);
num9=fenkuai(64,jiemi,9);
num10=fenkuai(64,jiemi,10);
num11=fenkuai(64,jiemi,11);
num12=fenkuai(64,jiemi,12);
num13=fenkuai(64,jiemi,13);
num14=fenkuai(64,jiemi,14);
num15=fenkuai(64,jiemi,15);
num16=fenkuai(64,jiemi,16);

num17=fenkuai(64,jiemi,17);
num18=fenkuai(64,jiemi,18);
num19=fenkuai(64,jiemi,19);
num20=fenkuai(64,jiemi,20);
num21=fenkuai(64,jiemi,21);
num22=fenkuai(64,jiemi,22);
num23=fenkuai(64,jiemi,23);
num24=fenkuai(64,jiemi,24);
num25=fenkuai(64,jiemi,25);
num26=fenkuai(64,jiemi,26);
num27=fenkuai(64,jiemi,27);
num28=fenkuai(64,jiemi,28);
num29=fenkuai(64,jiemi,29);
num30=fenkuai(64,jiemi,30);
num31=fenkuai(64,jiemi,31);
num32=fenkuai(64,jiemi,32);

num33=fenkuai(64,jiemi,33);
num34=fenkuai(64,jiemi,34);
num35=fenkuai(64,jiemi,35);
num36=fenkuai(64,jiemi,36);
num37=fenkuai(64,jiemi,37);
num38=fenkuai(64,jiemi,38);
num39=fenkuai(64,jiemi,39);
num40=fenkuai(64,jiemi,40);
num41=fenkuai(64,jiemi,41);
num42=fenkuai(64,jiemi,42);
num43=fenkuai(64,jiemi,43);
num44=fenkuai(64,jiemi,44);
num45=fenkuai(64,jiemi,45);
num46=fenkuai(64,jiemi,46);
num47=fenkuai(64,jiemi,47);
num48=fenkuai(64,jiemi,48);

num49=fenkuai(64,jiemi,49);
num50=fenkuai(64,jiemi,50);
num51=fenkuai(64,jiemi,51);
num52=fenkuai(64,jiemi,52);
num53=fenkuai(64,jiemi,53);
num54=fenkuai(64,jiemi,54);
num55=fenkuai(64,jiemi,55);
num56=fenkuai(64,jiemi,56);
num57=fenkuai(64,jiemi,57);
num58=fenkuai(64,jiemi,58);
num59=fenkuai(64,jiemi,59);
num60=fenkuai(64,jiemi,60);
num61=fenkuai(64,jiemi,61);
num62=fenkuai(64,jiemi,62);
num63=fenkuai(64,jiemi,63);
num64=fenkuai(64,jiemi,64);

q1 = 0;
for i = 1:64
    for j = 1:64
         if num1(i,j) == 0
                 q1 = q1+1;
        end
    end
end
q1 = q1/(64*64);
d1 = (q1-0.3525)*(q1-0.3525); 

q2 = 0;
for i = 1:64
    for j = 1:64
         if num2(i,j) == 0
                 q2 = q2+1;
        end
    end
end
q2 = q2/(64*64);
d2 = (q2-0.3525)*(q2-0.3525);

q3 = 0;
for i = 1:64
    for j = 1:64
         if num3(i,j) == 0
                 q3 = q3+1;
        end
    end
end
q3 = q3/(64*64);
d3 = (q3-0.3525)*(q3-0.3525);

q4 = 0;
for i = 1:64
    for j = 1:64
         if num4(i,j) == 0
                 q4 = q4+1;
        end
    end
end
q4 = q4/(64*64);
d4 = (q4-0.3525)*(q4-0.3525);

q5 = 0;
for i = 1:64
    for j = 1:64
         if num5(i,j) == 0
                 q5 = q5+1;
        end
    end
end
q5 = q5/(64*64);
d5 = (q5-0.3525)*(q5-0.3525);

q6 = 0;
for i = 1:64
    for j = 1:64
         if num6(i,j) == 0
                 q6 = q6+1;
        end
    end
end
q6 = q6/(64*64);
d6 = (q6-0.3525)*(q6-0.3525);

q7 = 0;
for i = 1:64
    for j = 1:64
         if num7(i,j) == 0
                 q7 = q7+1;
        end
    end
end
q7 = q7/(64*64);
d7 = (q7-0.3525)*(q7-0.3525);

q8 = 0;
for i = 1:64
    for j = 1:64
         if num8(i,j) == 0
                 q8 = q8+1;
        end
    end
end
q8 = q8/(64*64);
d8 = (q8-0.3525)*(q8-0.3525);

q9 = 0;
for i = 1:64
    for j = 1:64
         if num9(i,j) == 0
                 q9 = q9+1;
        end
    end
end
q9 = q9/(64*64);
d9 = (q9-0.3525)*(q9-0.3525);

q10 = 0;
for i = 1:64
    for j = 1:64
         if num10(i,j) == 0
                 q10 = q10+1;
        end
    end
end
q10 = q10/(64*64);
d10 = (q10-0.3525)*(q10-0.3525);

q11 = 0;
for i = 1:64
    for j = 1:64
         if num11(i,j) == 0
                 q11 = q11+1;
        end
    end
end
q11 = q11/(64*64);
d11 = (q11-0.3525)*(q11-0.3525);

q12 = 0;
for i = 1:64
    for j = 1:64
         if num12(i,j) == 0
                 q12 = q12+1;
        end
    end
end
q12 = q12/(64*64);
d12 = (q12-0.3525)*(q12-0.3525);

q13 = 0;
for i = 1:64
    for j = 1:64
         if num13(i,j) == 0
                 q13 = q13+1;
        end
    end
end
q13 = q13/(64*64);
d13 = (q13-0.3525)*(q13-0.3525);

q14 = 0;
for i = 1:64
    for j = 1:64
         if num14(i,j) == 0
                 q14 = q14+1;
        end
    end
end
q14 = q14/(64*64);
d14 = (q14-0.3525)*(q14-0.3525);


q15 = 0;
for i = 1:64
    for j = 1:64
         if num15(i,j) == 0
                 q15 = q15+1;
        end
    end
end
q15 = q15/(64*64);
d15 = (q15-0.3525)*(q15-0.3525);

q16 = 0;
for i = 1:64
    for j = 1:64
         if num16(i,j) == 0
                 q16 = q16+1;
        end
    end
end
q16 = q16/(64*64);
d16 = (q16-0.3525)*(q16-0.3525);

q17 = 0;
for i = 1:64
    for j = 1:64
         if num17(i,j) == 0
                 q17 = q17+1;
        end
    end
end
q17 = q17/(64*64);
d17 = (q17-0.3525)*(q17-0.3525);

q18 = 0;
for i = 1:64
    for j = 1:64
         if num18(i,j) == 0
                 q18 = q18+1;
        end
    end
end
q18 = q18/(64*64);
d18 = (q18-0.3525)*(q18-0.3525);

q19 = 0;
for i = 1:64
    for j = 1:64
         if num19(i,j) == 0
                 q19 = q19+1;
        end
    end
end
q19 = q19/(64*64);
d19 = (q19-0.3525)*(q19-0.3525);

q20 = 0;
for i = 1:64
    for j = 1:64
         if num20(i,j) == 0
                 q20 = q20+1;
        end
    end
end
q20 = q20/(64*64);
d20 = (q20-0.3525)*(q20-0.3525);

q21 = 0;
for i = 1:64
    for j = 1:64
         if num21(i,j) == 0
                 q21 = q21+1;
        end
    end
end
q21 = q21/(64*64);
d21 = (q21-0.3525)*(q21-0.3525);

q22 = 0;
for i = 1:64
    for j = 1:64
         if num22(i,j) == 0
                 q22 = q22+1;
        end
    end
end
q22 = q22/(64*64);
d22 = (q22-0.3525)*(q22-0.3525);

q23 = 0;
for i = 1:64
    for j = 1:64
         if num23(i,j) == 0
                 q23 = q23+1;
        end
    end
end
q23 = q23/(64*64);
d23 = (q23-0.3525)*(q23-0.3525);

q24 = 0;
for i = 1:64
    for j = 1:64
         if num24(i,j) == 0
                 q24 = q24+1;
        end
    end
end
q24 = q24/(64*64);
d24 = (q24-0.3525)*(q24-0.3525);

q25 = 0;
for i = 1:64
    for j = 1:64
         if num25(i,j) == 0
                 q25 = q25+1;
        end
    end
end
q25 = q25/(64*64);
d25 = (q25-0.3525)*(q25-0.3525);

q26 = 0;
for i = 1:64
    for j = 1:64
         if num26(i,j) == 0
                 q26 = q26+1;
        end
    end
end
q26 = q26/(64*64);
d26 = (q26-0.3525)*(q26-0.3525);

q27 = 0;
for i = 1:64
    for j = 1:64
         if num27(i,j) == 0
                 q27 = q27+1;
        end
    end
end
q27 = q27/(64*64);
d27 = (q27-0.3525)*(q27-0.3525);

q28 = 0;
for i = 1:64
    for j = 1:64
         if num28(i,j) == 0
                 q28 = q28+1;
        end
    end
end
q28 = q28/(64*64);
d28 = (q28-0.3525)*(q28-0.3525);


q29 = 0;
for i = 1:64
    for j = 1:64
         if num29(i,j) == 0
                 q29 = q29+1;
        end
    end
end
q29 = q29/(64*64);
d29 = (q29-0.3525)*(q29-0.3525);

q30 = 0;
for i = 1:64
    for j = 1:64
         if num30(i,j) == 0
                 q30 = q30+1;
        end
    end
end
q30 = q30/(64*64);
d30 = (q30-0.3525)*(q30-0.3525);

q31 = 0;
for i = 1:64
    for j = 1:64
         if num31(i,j) == 0
                 q31 = q31+1;
        end
    end
end
q31 = q31/(64*64);
d31 = (q31-0.3525)*(q31-0.3525);

q32 = 0;
for i = 1:64
    for j = 1:64
         if num32(i,j) == 0
                 q32= q32+1;
        end
    end
end
q32 = q32/(64*64);
d32 = (q32-0.3525)*(q32-0.3525);

q33 = 0;
for i = 1:64
    for j = 1:64
         if num33(i,j) == 0
                 q33 = q33+1;
        end
    end
end
q33 = q33/(64*64);
d33 = (q33-0.3525)*(q33-0.3525);

q34 = 0;
for i = 1:64
    for j = 1:64
         if num5(i,j) == 0
                 q34= q34+1;
        end
    end
end
q34 = q34/(64*64);
d34 = (q34-0.3525)*(q34-0.3525);

q35 = 0;
for i = 1:64
    for j = 1:64
         if num35(i,j) == 0
                 q35 = q35+1;
        end
    end
end
q35 = q35/(64*64);
d35 = (q35-0.3525)*(q35-0.3525);

q36 = 0;
for i = 1:64
    for j = 1:64
         if num36(i,j) == 0
                 q36 = q36+1;
        end
    end
end
q36 = q36/(64*64);
d36 = (q36-0.3525)*(q36-0.3525);

q37 = 0;
for i = 1:64
    for j = 1:64
         if num37(i,j) == 0
                 q37 = q37+1;
        end
    end
end
q37 = q37/(64*64);
d37 = (q37-0.3525)*(q37-0.3525);

q38 = 0;
for i = 1:64
    for j = 1:64
         if num38(i,j) == 0
                 q38 = q38+1;
        end
    end
end
q38 = q38/(64*64);
d38 = (q38-0.3525)*(q38-0.3525);


q39 = 0;
for i = 1:64
    for j = 1:64
         if num39(i,j) == 0
                 q39 = q39+1;
        end
    end
end
q39 = q39/(64*64);
d39 = (q39-0.3525)*(q39-0.3525);

q40 = 0;
for i = 1:64
    for j = 1:64
         if num40(i,j) == 0
                 q40 = q40+1;
        end
    end
end
q40 = q40/(64*64);
d40 = (q40-0.3525)*(q40-0.3525);

q41 = 0;
for i = 1:64
    for j = 1:64
         if num41(i,j) == 0
                 q41 = q41+1;
        end
    end
end
q41 = q41/(64*64);
d41 = (q41-0.3525)*(q41-0.3525);

q42 = 0;
for i = 1:64
    for j = 1:64
         if num42(i,j) == 0
                 q42 = q42+1;
        end
    end
end
q42 = q42/(64*64);
d42 = (q42-0.3525)*(q42-0.3525);

q43 = 0;
for i = 1:64
    for j = 1:64
         if num43(i,j) == 0
                 q43 = q43+1;
        end
    end
end
q43 = q43/(64*64);
d43 = (q43-0.3525)*(q43-0.3525);

q44 = 0;
for i = 1:64
    for j = 1:64
         if num44(i,j) == 0
                 q44 = q44+1;
        end
    end
end
q44 = q44/(64*64);
d44 = (q44-0.3525)*(q44-0.3525);

q45 = 0;
for i = 1:64
    for j = 1:64
         if num45(i,j) == 0
                 q45 = q45+1;
        end
    end
end
q45 = q45/(64*64);
d45 = (q45-0.3525)*(q45-0.3525);

q46 = 0;
for i = 1:64
    for j = 1:64
         if num46(i,j) == 0
                 q46 = q46+1;
        end
    end
end
q46 = q46/(64*64);
d46 = (q46-0.3525)*(q46-0.3525);

q47 = 0;
for i = 1:64
    for j = 1:64
         if num47(i,j) == 0
                 q47 = q47+1;
        end
    end
end
q47 = q47/(64*64);
d47 = (q47-0.3525)*(q47-0.3525);


q48 = 0;
for i = 1:64
    for j = 1:64
         if num48(i,j) == 0
                 q48 = q48+1;
        end
    end
end
q48 = q48/(64*64);
d48 = (q48-0.3525)*(q48-0.3525);

q49 = 0;
for i = 1:64
    for j = 1:64
         if num49(i,j) == 0
                 q49 = q49+1;
        end
    end
end
q49 = q49/(64*64);
d49 = (q49-0.3525)*(q49-0.3525);

q50 = 0;
for i = 1:64
    for j = 1:64
         if num50(i,j) == 0
                 q50 = q50+1;
        end
    end
end
q50 = q50/(64*64);
d50 = (q50-0.3525)*(q50-0.3525);
q51 = 0;
for i = 1:64
    for j = 1:64
         if num51(i,j) == 0
                 q51 = q51+1;
        end
    end
end
q51 = q51/(64*64);
d51 = (q51-0.3525)*(q51-0.3525);
q52 = 0;
for i = 1:64
    for j = 1:64
         if num52(i,j) == 0
                 q52 = q52+1;
        end
    end
end
q52 = q52/(64*64);
d52 = (q52-0.3525)*(q52-0.3525);
q53 = 0;
for i = 1:64
    for j = 1:64
         if num53(i,j) == 0
                 q53 = q53+1;
        end
    end
end
q53 = q53/(64*64);
d53 = (q53-0.3525)*(q53-0.3525);

q54 = 0;
for i = 1:64
    for j = 1:64
         if num54(i,j) == 0
                 q54 = q54+1;
        end
    end
end
q54 = q54/(64*64);
d54 = (q54-0.3525)*(q54-0.3525);

q55 = 0;
for i = 1:64
    for j = 1:64
         if num55(i,j) == 0
                 q55 = q55+1;
        end
    end
end
q55 = q55/(64*64);
d55 = (q55-0.3525)*(q55-0.3525);

q56 = 0;
for i = 1:64
    for j = 1:64
         if num56(i,j) == 0
                 q56 = q56+1;
        end
    end
end
q56 = q56/(64*64);
d56 = (q56-0.3525)*(q56-0.3525);

q57 = 0;
for i = 1:64
    for j = 1:64
         if num57(i,j) == 0
                 q57 = q57+1;
        end
    end
end
q57 = q57/(64*64);
d57 = (q57-0.3525)*(q57-0.3525);

q58 = 0;
for i = 1:64
    for j = 1:64
         if num58(i,j) == 0
                 q58 = q58+1;
        end
    end
end
q58 = q58/(64*64);
d58 = (q58-0.3525)*(q58-0.3525);

q59 = 0;
for i = 1:64
    for j = 1:64
         if num59(i,j) == 0
                 q59 = q59+1;
        end
    end
end
q59 = q59/(64*64);
d59 = (q59-0.3525)*(q59-0.3525);
q60 = 0;
for i = 1:64
    for j = 1:64
         if num60(i,j) == 0
                 q60 = q60+1;
        end
    end
end
q60 = q60/(64*64);
d60 = (q60-0.3525)*(q60-0.3525);
q61 = 0;
for i = 1:64
    for j = 1:64
         if num61(i,j) == 0
                 q61 = q61+1;
        end
    end
end
q61 = q61/(64*64);
d61 = (q61-0.3525)*(q61-0.3525);
q62 = 0;
for i = 1:64
    for j = 1:64
         if num62(i,j) == 0
                 q62 = q62+1;
        end
    end
end
q62 = q62/(64*64);
d62 = (q62-0.3525)*(q62-0.3525);
q63 = 0;
for i = 1:64
    for j = 1:64
         if num63(i,j) == 0
                 q63 = q63+1;
        end
    end
end
q63 = q63/(64*64);
d63 = (q63-0.3525)*(q63-0.3525);
q64 = 0;
for i = 1:64
    for j = 1:64
         if num64(i,j) == 0
                 q64 = q64+1;
        end
    end
end
q64 = q64/(64*64);
d64 = (q64-0.3525)*(q64-0.3525);

D = d1+d2+d3+d4+d5+d6+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17+d18+d19+d20+d21+d22+d23+d24+d25+d26+d27+d28+d29+d30+d31+d32+d33+d34+d35+d36+d37+d38+d39+d40+d41+d42+d43+d44+d45+d46+d47+d48+d49+d50+d51+d52+d53+d54+d55+d56+d57+d58+d59+d60+d61+d62+d63+d64;