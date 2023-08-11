# AssemblyCaesarCipher

Caesar Cipher encryption and decryption program done in Assembly (MASM 32 bits) for the discipline Computer Architecture I at the Federal University of Paraíba (UFPB) in 2022.2 semester.

## Goal

The Caesar Cipher consists of replacing each letter of the original message with another letter that is listed in the alphabet in a fixed number of positions after the substituted letter. For example, if we consider using the Caesar Cipher using an offset of 3 positions (in this example, the “key” would be the constant 3), we would have the following original and encrypted characters:

```
ORIGINAL: ABCDE
ENCRYPTED: DEFGH
```

In this work, we will consider a variation of the Caesar Cipher where all the bytes of a text file are shifted forward (positive shift) in a constant that can be from 1 to 20 (this constant will be called “key”). That is, the encryption process consists of adding the key value to each of the bytes of a file, and the decryption process consists of subtracting the key value of each of the bytes of a file.

## Execution

After compiling and executing the file, the user can choose the desired mode (encryption or decryption) and indicate the input file, the output file and the displacement.

## Result

Using the `hateassembly.txt` file, it was possible to arrive at the result of the `hateassemblycrypto.txt` file. Reversal is also possible given the correct displacement.

hateassembly.txt
```
In the realm of code, where bits and bytes unite,
Lies assembly, a language that fills me with spite.
With its cryptic syntax, devoid of grace,
I struggle to find a smile on my face.

Oh, assembly, you're a puzzle so complex,
Each line of code a never-ending hex.
Registers and opcodes, a tangled mess,
My mind in knots, oh, what a distress!

Your instructions are cryptic, lacking clarity,
Jumping around with such audacity.
Branches and loops, a maze I can't escape,
Oh, assembly, you leave me in a mind-scraping state.

Error messages haunt me, mocking my plight,
As I wrestle with your syntax late into the night.
One misplaced character, a tiny mistake,
And my hopes and dreams you willingly break.

But still, I delve into your world of despair,
Seeking understanding, though it seems unfair.
For within your darkness, there lies hidden might,
Unlocking the secrets of the CPU's inner light.

Though I curse your name and grumble in disdain,
I cannot deny the power you contain.
Assembly, you are the foundation of it all,
A necessary evil, standing tall.

So let us not dwell solely on hate,
For assembly, in its way, is truly great.
A testament to the raw power of machines,
A reminder that technology reigns supreme.

But, oh assembly, you test my patience so,
With your endless intricacies that constantly grow.
I'll wrestle with you, begrudgingly play my part,
But deep down inside, there's a love-hate in my heart.
```

hateassemblycrypto.txt
```
Lq#wkh#uhdop#ri#frgh/#zkhuh#elwv#dqg#e|whv#xqlwh/
Olhv#dvvhpeo|/#d#odqjxdjh#wkdw#iloov#ph#zlwk#vslwh1
Zlwk#lwv#fu|swlf#v|qwd{/#ghyrlg#ri#judfh/
L#vwuxjjoh#wr#ilqg#d#vploh#rq#p|#idfh1

Rk/#dvvhpeo|/#|rx*uh#d#sx}}oh#vr#frpsoh{/
Hdfk#olqh#ri#frgh#d#qhyhu0hqglqj#kh{1
Uhjlvwhuv#dqg#rsfrghv/#d#wdqjohg#phvv/
P|#plqg#lq#nqrwv/#rk/#zkdw#d#glvwuhvv$

\rxu#lqvwuxfwlrqv#duh#fu|swlf/#odfnlqj#fodulw|/
Mxpslqj#durxqg#zlwk#vxfk#dxgdflw|1
Eudqfkhv#dqg#orrsv/#d#pd}h#L#fdq*w#hvfdsh/
Rk/#dvvhpeo|/#|rx#ohdyh#ph#lq#d#plqg0vfudslqj#vwdwh1

Huuru#phvvdjhv#kdxqw#ph/#prfnlqj#p|#soljkw/
Dv#L#zuhvwoh#zlwk#|rxu#v|qwd{#odwh#lqwr#wkh#qljkw1
Rqh#plvsodfhg#fkdudfwhu/#d#wlq|#plvwdnh/
Dqg#p|#krshv#dqg#guhdpv#|rx#zloolqjo|#euhdn1

Exw#vwloo/#L#ghoyh#lqwr#|rxu#zruog#ri#ghvsdlu/
Vhhnlqj#xqghuvwdqglqj/#wkrxjk#lw#vhhpv#xqidlu1
Iru#zlwklq#|rxu#gdunqhvv/#wkhuh#olhv#klgghq#pljkw/
Xqorfnlqj#wkh#vhfuhwv#ri#wkh#FSX*v#lqqhu#oljkw1

Wkrxjk#L#fxuvh#|rxu#qdph#dqg#juxpeoh#lq#glvgdlq/
L#fdqqrw#ghq|#wkh#srzhu#|rx#frqwdlq1
Dvvhpeo|/#|rx#duh#wkh#irxqgdwlrq#ri#lw#doo/
D#qhfhvvdu|#hylo/#vwdqglqj#wdoo1

Vr#ohw#xv#qrw#gzhoo#vroho|#rq#kdwh/
Iru#dvvhpeo|/#lq#lwv#zd|/#lv#wuxo|#juhdw1
D#whvwdphqw#wr#wkh#udz#srzhu#ri#pdfklqhv/
D#uhplqghu#wkdw#whfkqrorj|#uhljqv#vxsuhph1

Exw/#rk#dvvhpeo|/#|rx#whvw#p|#sdwlhqfh#vr/
Zlwk#|rxu#hqgohvv#lqwulfdflhv#wkdw#frqvwdqwo|#jurz1
L*oo#zuhvwoh#zlwk#|rx/#ehjuxgjlqjo|#sod|#p|#sduw/
Exw#ghhs#grzq#lqvlgh/#wkhuh*v#d#oryh0kdwh#lq#p|#khduw1
```
