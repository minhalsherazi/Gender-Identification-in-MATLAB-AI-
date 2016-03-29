function [ gender ] = genderidentifiernew( abc )
z=1;
h=0;
hz=5513;
filter = 1*ones(10,1);
m=0;
f=0;

while(z<6)
M_S3=wavread('Sample 1.wav');
M_S3_Vowel = M_S3((h+1):(h+hz));
M_S3_fourier=abs(fftshift(fft(M_S3_Vowel)));
M_S3_fourier=M_S3_fourier(floor(length(M_S3_fourier)/2):length(M_S3_fourier));
M_S2=wavread('Sample 2.wav');
M_S2_Vowel = M_S2((h+1):(h+hz));
M_S2_fourier=abs(fftshift(fft(M_S2_Vowel)));
M_S2_fourier=M_S2_fourier(floor(length(M_S2_fourier)/2):length(M_S2_fourier));
M_S1=wavread('Sample 3.wav');
M_S1_Vowel = M_S1((h+1):(h+hz));
M_S1_fourier=abs(fftshift(fft(M_S1_Vowel)));
M_S1_fourier=M_S1_fourier(floor(length(M_S1_fourier)/2):length(M_S1_fourier));
M_S3_conv=conv(filter,M_S3_fourier);
M_S2_conv=conv(filter,M_S2_fourier);
M_S1_conv=conv(filter,M_S1_fourier);
M_S_conv(1:length(M_S1_conv)) = (M_S1_conv(1:length(M_S1_conv)) + M_S2_conv(1:length(M_S1_conv)) + M_S3_conv(1:length(M_S1_conv)))/3;
M_S_final = transpose(M_S_conv);
M_S_final = M_S_final(1:length(M_S1_conv));
	
F_S3=wavread('Sample 4.wav');
F_S3_Vowel = F_S3((h+1):(h+hz));
F_S3_fourier=abs(fftshift(fft(F_S3_Vowel)));
F_S3_fourier=F_S3_fourier(floor(length(F_S3_fourier)/2):length(F_S3_fourier));
F_S2=wavread('Sample 5.wav');
F_S2_Vowel = F_S2((h+1):(h+hz));
F_S2_fourier=abs(fftshift(fft(F_S2_Vowel)));
F_S2_fourier=F_S2_fourier(floor(length(F_S2_fourier)/2):length(F_S2_fourier));
F_S1=wavread('Sample 6.wav');
F_S1_Vowel = F_S1((h+1):(h+hz));
F_S1_fourier=abs(fftshift(fft(F_S1_Vowel)));
F_S1_fourier=F_S1_fourier(floor(length(F_S1_fourier)/2):length(F_S1_fourier));
F_S3_conv=conv(filter,F_S3_fourier);
F_S2_conv=conv(filter,F_S2_fourier);
F_S1_conv=conv(filter,F_S1_fourier);
F_S_conv(1:length(F_S1_conv)) = (F_S1_conv(1:length(F_S1_conv)) + F_S2_conv(1:length(F_S1_conv)) + F_S3_conv(1:length(F_S1_conv)))/3;
F_S_final = transpose(F_S_conv);
F_S_final = F_S_final(1:length(F_S1_conv));

Sample= abc;
Sample_Vowel = Sample((h+1):(h+hz));
Sample_fourier=abs(fftshift(fft(Sample_Vowel)));
Sample_fourier=Sample_fourier(floor(length(Sample_fourier)/2):length(Sample_fourier));
Sample_conv=conv(filter,Sample_fourier);    
    
f_array(z)=corr(F_S_final,Sample_conv);
m_array(z)=corr(M_S_final,Sample_conv);

z=z+1;
h=h+5513;
end
f=(f_array(1)+f_array(2)+f_array(3)+f_array(4)+f_array(5))/3;
m=(m_array(1)+m_array(2)+m_array(3)+m_array(4)+m_array(5))/3;

if(f>m)
    gender=1;
else
    gender=2;
end

end