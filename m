Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BA363
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 14:34:03 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id w127so2226484oiw.8
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U51vuW8yqZi9hTC4IWDsGECe92KgOVvPSAyE8uo753w=;
        b=lwLvtCSWpwVIJ1SQYgwhi0Eose8ReKSz8cgqWN1Ca7/G+HZ4sWgxn4e0ap6RXdnwzB
         bhiJ+H66dSfsWdJyDIjvlrMm8uT2YS8NrWtXMQGaCV0WevzhfZNdF6dRrb13O47b9khE
         2XMpz9oCl2hBEnZrCOIfa9lGe3+vFmJz9S0YPTtYJLSTC9K8XHxDcbqNkWuwmhuPy0ce
         tjKoWjrgSvcfW0fx4PiOJwYrEvb+T9MCppKCDWt8xwBe0RtgjfrNd2MLVEcQVRiQFgaR
         QSd0OgIUOWYkNsZPemM91rHu07zLD897yayXAPRB44QTJaI2rsUeVrKPBAHDmNSemzFx
         aNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U51vuW8yqZi9hTC4IWDsGECe92KgOVvPSAyE8uo753w=;
        b=ZIYwVT5uuy4XueUOh7nbGlAaRUn07RMo0p5DcZHlIem6nKePtGvXNYwpmj+XVHoxck
         qgxkSE9Q4G+cmfxEll/FSF00ndj5mo1Baafy2kleaDyc2A7unSauEP4yRRsdDiZtbJwv
         WuGHv/mSuqjPmYy99cCPXRnNzHzOTDmhczkVkM+oTw/XQjV5hU/krKTCApYlY51XLDDC
         3GUc1f9NKWfN6Ch2+UrPgfscqghg78fblGyqWpWffXMqL3KN2aU2puIbt+4vsGGebepP
         XN1Yl+lPsZgijt1I4Ql6Mx2WLh/kXrla6l5/q/MRJPYsyjzgGBfzBoWOSre5zHPc+Raf
         GqWQ==
X-Gm-Message-State: ACrzQf2HxbGAB0Kmfg/nWEcq+RBwTkxphDi6e3dP/epX3ojL7s0Db0Yy
	NCuPEI6FLSndvpONy4+Uu5KqHvyG3ng=
X-Google-Smtp-Source: AMsMyM4ddWnlk8HRCltPcuD9R93ozKWMjWM4dLpQLA6fIajfSyV8onjyJTfEju5+JOgX4CIbggAHSg==
X-Received: by 2002:a05:6808:10d2:b0:354:814:9ef with SMTP id s18-20020a05680810d200b00354081409efmr3364904ois.24.1665066842387;
        Thu, 06 Oct 2022 07:34:02 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bx21-20020a056830601500b0065689e13f52sm5534020otb.71.2022.10.06.07.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 07:34:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wIDUEuvjaXE3nPKW3JpIceas"
Message-ID: <772f09aa-fe9e-708e-2ec2-a89f8784d391@gmail.com>
Date: Thu, 6 Oct 2022 09:34:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: GCMP and other unknown ciphers
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>, iwd@lists.linux.dev
References: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>

This is a multi-part message in MIME format.
--------------wIDUEuvjaXE3nPKW3JpIceas
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

On 10/6/22 08:22, Emil Velikov wrote:
> Greetings team,
> 
> Recently we've noticed that IWD fails to connect to WPA2-PSK networks
> whenever GCMP+CCMP cipher is used. Browsing through the IWD code-base
> it appears that it lacks support for GCMP, GCMP-256 and CCMP-256
> amongst others.

We do not support or select GCMP.  But I'm not sure why this would prevent a 
connection?  We would always select CCMP instead.  See wiphy_select_cipher().

Hmm... maybe we reject GCMP at a lower layer...?  Try the attached patch?

> 
> Was my analysis correct - is GCMP supported? Are there any plans on doing so?

No real plans, patches are always welcome.

> 
> Somewhat relatedly - is there a configuration knob that one can switch
> and let IWD fall-back to the other supported ciphers? In the GCMP+CCMP
> case, we can opt for CCMP for example.
> 

This should already happen.

Regards,
-Denis
--------------wIDUEuvjaXE3nPKW3JpIceas
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ie-Skip-unknown-pairwise-ciphers.patch"
Content-Disposition: attachment;
 filename="0001-ie-Skip-unknown-pairwise-ciphers.patch"
Content-Transfer-Encoding: base64

RnJvbSAxNTU4NjdlMGFjYmI3YWI2NTY2NzZkZWM2NjZhMWI3NWUyNWU5MGU2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNv
bT4KRGF0ZTogVGh1LCA2IE9jdCAyMDIyIDA5OjMwOjE3IC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gaWU6IFNraXAgdW5rbm93biBwYWlyd2lzZSBjaXBoZXJzCgotLS0KIHNyYy9pZS5jIHwg
MTYgKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvaWUuYyBiL3NyYy9pZS5jCmluZGV4
IDA3MDQ1NGVmNGY4Zi4uMTNlOTIxZGFjNWJjIDEwMDY0NAotLS0gYS9zcmMvaWUuYworKysg
Yi9zcmMvaWUuYwpAQCAtNTg5LDE1ICs1ODksMTQgQEAgc3RhdGljIGJvb2wgaWVfcGFyc2Vf
Z3JvdXBfY2lwaGVyKGNvbnN0IHVpbnQ4X3QgKmRhdGEsCiAJcmV0dXJuIHRydWU7CiB9CiAK
LXN0YXRpYyBib29sIGllX3BhcnNlX3BhaXJ3aXNlX2NpcGhlcihjb25zdCB1aW50OF90ICpk
YXRhLAorc3RhdGljIGludCBpZV9wYXJzZV9wYWlyd2lzZV9jaXBoZXIoY29uc3QgdWludDhf
dCAqZGF0YSwKIAkJCQkJZW51bSBpZV9yc25fY2lwaGVyX3N1aXRlICpvdXQpCiB7CiAJZW51
bSBpZV9yc25fY2lwaGVyX3N1aXRlIHRtcDsKLQogCWJvb2wgciA9IGllX3BhcnNlX2NpcGhl
cl9zdWl0ZShkYXRhLCAmdG1wKTsKIAogCWlmICghcikKLQkJcmV0dXJuIHI7CisJCXJldHVy
biAtRU5PRU5UOwogCiAJc3dpdGNoICh0bXApIHsKIAljYXNlIElFX1JTTl9DSVBIRVJfU1VJ
VEVfQ0NNUDoKQEAgLTYwNywxMSArNjA2LDExIEBAIHN0YXRpYyBib29sIGllX3BhcnNlX3Bh
aXJ3aXNlX2NpcGhlcihjb25zdCB1aW50OF90ICpkYXRhLAogCWNhc2UgSUVfUlNOX0NJUEhF
Ul9TVUlURV9VU0VfR1JPVVBfQ0lQSEVSOgogCQlicmVhazsKIAlkZWZhdWx0OgotCQlyZXR1
cm4gZmFsc2U7CisJCXJldHVybiAtRVJBTkdFOwogCX0KIAogCSpvdXQgPSB0bXA7Ci0JcmV0
dXJuIHRydWU7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBib29sIGllX3BhcnNlX2dyb3Vw
X21hbmFnZW1lbnRfY2lwaGVyKGNvbnN0IHVpbnQ4X3QgKmRhdGEsCkBAIC02ODIsOSArNjgx
LDEyIEBAIHN0YXRpYyBpbnQgcGFyc2VfY2lwaGVycyhjb25zdCB1aW50OF90ICpkYXRhLCBz
aXplX3QgbGVuLAogCS8qIFBhcnNlIFBhaXJ3aXNlIENpcGhlciBTdWl0ZSBMaXN0IGZpZWxk
ICovCiAJZm9yIChpID0gMCwgb3V0X2luZm8tPnBhaXJ3aXNlX2NpcGhlcnMgPSAwOyBpIDwg
Y291bnQ7IGkrKykgewogCQllbnVtIGllX3Jzbl9jaXBoZXJfc3VpdGUgc3VpdGU7CisJCWlu
dCByID0gaWVfcGFyc2VfcGFpcndpc2VfY2lwaGVyKGRhdGEgKyBpICogNCwgJnN1aXRlKTsK
IAotCQlpZiAoIWllX3BhcnNlX3BhaXJ3aXNlX2NpcGhlcihkYXRhICsgaSAqIDQsICZzdWl0
ZSkpCi0JCQlyZXR1cm4gLUVSQU5HRTsKKwkJaWYgKHIgPT0gLUVOT0VOVCkgLyogU2tpcCB1
bmtub3duICovCisJCQljb250aW51ZTsKKwkJZWxzZSBpZiAociA8IDApCisJCQlyZXR1cm4g
cjsKIAogCQlvdXRfaW5mby0+cGFpcndpc2VfY2lwaGVycyB8PSBzdWl0ZTsKIAl9Ci0tIAoy
LjM1LjEKCg==

--------------wIDUEuvjaXE3nPKW3JpIceas--
