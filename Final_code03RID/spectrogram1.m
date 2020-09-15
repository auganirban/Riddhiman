A= zeros(1,214)
B= zeros(1,214)
C= zeros(1,214)
for(i=1:213)
    A(i)=g_final(1,4,i);
end
for(i=1:213)
    B(i)=g_final(2,4,i);
end
for(i=1:213)
    C(i)=g_final(3,4,i);
end
A=A(1,1:213)
B=B(1,1:213)
C=C(1,1:213)
s1 = spectrogram(A);
spectrogram(A,'yaxis')
s2 = spectrogram(B);
spectrogram(B,'yaxis')
s3 = spectrogram(C);
spectrogram(C,'yaxis')

