Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F5EED7;
	Mon, 27 Jan 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988144; cv=none; b=ju3CAPWJN/f7WbqzQFzKMoNTY59t9jLpQ6Z8GkblY6N8tI+aYsZPRzvPn/62awI/Wik5Q/3LDDiS3jCSAgP7dwPwd+4JBBrUvPdRDF7q+Nxr3jYkQX37shwR7DfGtNhwDVBQrkj8IXgLIbzDdW3NicnEgTpahjj8BGFi8E4J/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988144; c=relaxed/simple;
	bh=B/zJx043/p/wvH4Nl4QzDxFpuG3Tm7CPXHpgwXWDgsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvyDA66KM3ORFq7SSXuiA+y1mOw7aZI2Er8CLoJYbxj45uzltWMTVpSrU31hS5YSLx4EBkVHkNL++oNPtggmQ7HI5Z+QkZse3YM3CUuGYxObjvSUYomFjLy5Y4RONzeMD/cQ1hjG66j0uKkkybJ/4xE3IaiIZU069tGidqmxqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMiwPaIU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMiwPaIU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so426072685a.1;
        Mon, 27 Jan 2025 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988142; x=1738592942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rerxuWxc3AlP4zg1YaA507UnJhlV5+v4ZidVCpYaM8=;
        b=jMiwPaIUNsDy1LCb84YM9iqE6NSo6CNQ2MlQRT99052GYlr4cZxeO445ZssZMg6tQC
         WiMvRjCaHcDBCpPHbTvBuHJSTe4UuKe5ymvwy3ncP5KsfIt1igU6bmRc/eJeaucErvl2
         5rtqR5vBIQm003o8vjeLIGjOwoAeRTNqZYOi0ZvBq1wXdK3dFibZAS/ZcvojjauBUlxL
         4OjR/djtv3GS8dBJM3wRMoGB1d6bTtotDWuMq7L84qegKPmvzFOyDT9if/RpRk0tpZ2P
         ZLl0s9JBCJw/n8UMIrdSLmd1o+Fo+B5Z/ycJwVRDDl9ypyDzusv0OYNmiS1VJ+qn3enK
         cfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988142; x=1738592942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rerxuWxc3AlP4zg1YaA507UnJhlV5+v4ZidVCpYaM8=;
        b=OsDV/1kbHShQseFv4MSLMiFgmuECvUzREeL0I4985oZpIpbR06sDQ3Vs54PG8Yj7bu
         Y/lfqPxy39XlXUTMO4tr0xFAumbTzlk1iAKlgil8/nS8pJl3uULVdI3SHvGzbNS3UT4f
         w18rgqSChqGaD5/MkfxBN+EXuWLg46X349u8X8+VlYXrl3jF7hzIpsNbVDV7mZ0kNgGn
         SbwrW87CgrsbHwRGxlUZQfQnoH+G+0mPco0/H4tb7fLVDVZGbJRvpbPivK+USW9440kQ
         s9Y7+NWREhI5kIXE7ltIXQPXYr0vhgoiedVMDAPeyOfDp3l9wQ5WNXelkHWiH6yDoVEy
         fBNw==
X-Forwarded-Encrypted: i=1; AJvYcCU6IL3pkfWw4vAfL6w8JZfCuUOfQ7smeKps1Rd7lardesrRr79wv8KklgZiwAHLHrSngHBr5XNJjjk=@lists.linux.dev, AJvYcCUeLoZprlBC/9/bos7tCcGCD7Knb1T3dc2RlBL9BZuie+RUN9MsynvXLGQKR7XOMfjXnGVAU/Y74A==@lists.linux.dev, AJvYcCX1+LltxQaTkiZO/sYVNiFucCW+ZuM1fWYaqBxnAtiAGVdyxiTU34CQcNkOFOn70vuMrjPM@lists.linux.dev
X-Gm-Message-State: AOJu0YyVjVvbpoUS9N7r3Cgz3HGXTrtntbR+JH14LxqOlOiLGO98Fo+G
	nalNxwbmhFpwnj9uqGn75GPddklNdrdzxIJ/Q2fMkzXUrsTkT3O4PMWAbQ==
X-Gm-Gg: ASbGnctBH4c1lqMUuShnM+Bx1G6MMoFElYiAzO0eYLG+Yg5knc1VMAlFTtzP5ZP7uHo
	AIeQI0HiHJNkRADizbL2zuZqrEmQZCbSqJOd5eBlj4RZwhAKIdK1Rx2R5ENHMw4jxaCv+jOS3gb
	BdVG4uvu0iLfpBn5uScUIgp0ty7kP42MSUALh4ERRgMVHGM5U3I411ObXdx/hHlvQnuVNN1Dgwz
	n/NCviy9fynrdUI94lB8766cu1P0WxMCie79HeEf0WhXk4uhhXT/cMiISsJp8V1SPivbY4Hy52w
	bDvm3ilHI/n/CZ9XtRM=
X-Google-Smtp-Source: AGHT+IF6pcHuCIFo6gEEsulDRRBvOPSFUX1YVEa/Z16qMurf4mfCqj0I+y6naYS8M54vbLHEBaf3RQ==
X-Received: by 2002:a05:620a:440b:b0:7b6:cf60:3973 with SMTP id af79cd13be357-7be6321c80fmr6523268185a.23.1737988141970;
        Mon, 27 Jan 2025 06:29:01 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm392061785a.31.2025.01.27.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 06:29:01 -0800 (PST)
Message-ID: <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
Date: Mon, 27 Jan 2025 06:28:58 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>, Denis Kenzior <denkenz@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, connman@lists.linux.dev,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 iwd@lists.linux.dev
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
 <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/25/25 8:37 AM, KeithG wrote:

<snip>
>> With wpa_supplincant, before the AP sends the 'PAE:', we get this
>> which is not in any of the iwmon logs with iwd:
>> < Request: Set PMKSA (0x34) len 92 [ack]                              14.561627
>>      Interface Index: 3 (0x00000003)
>>      PMKID: len 16
>>          05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#.b.M
>>      MAC Address D8:3A:DD:60:A3:0C
>>      Unknown: 287 len 4
>>          c0 a8 00 00                                      ....
>>      Unknown: 288 len 1
>>          46                                               F
>>      PMK: 254 len 32
>>          35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.....
>>          74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.u..:
>>> Response: Set PMKSA (0x34) len 4 [0x100]                            14.562171
>>      Status: Success (0)
>>
>> Is there any more info or help I can provide?

Looks like the only difference between IWD working and not working is 
when it includes the PMKID. This is due to the new PMKSA feature which 
looks like it requires some extra work on brcmfmac (using SET_PMKSA). 
Try disabling PMKSA in main.conf with:

[General].DisablePMKSA=true

This should hopefully get IWD reliably connecting.

Thanks,

James

