Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5210A1E
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960439; cv=none; b=H4yxLotq9T6t3lx80s3g0Yp+Idj1xi/n267YnQAmpjy3kS866XBF+KSZwCe3QFYbIjSl3Dyk9zPBFb8b6KsW4l7PNyv4+1n1Yx+pGwxB0U1iz9WeffQZQLg7eOeHZGWbwA0aBeUqFCyJGWx2CjfZ4cVJ6YFVfur3hy2e8slZXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960439; c=relaxed/simple;
	bh=D7Dp6jplMFsIsB6o7kDltvX0nk1krWMs7Ti+Apn+mxA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fwk/d6HzQafr04XK2m6EKLP3YIV7bFCh7ldzx/a3TwfqDXtiAQEmEsMByVprkGGuUHPZIMs6OZRlUIPcjvL6ggDj0gWfj+5PFTgqQbawx0BmcD0JcF9cCHZvpoQFJj2/nrX1Jdm+5OpOwK3eSg9f7dABMbFbeHswaXFHtBf+tQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFL9KtaR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFL9KtaR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccc597b96so668515f8f.3
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960436; x=1728565236; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdnd2xzgi6SWd8Ws/iTATnLnBkzdv8ijAh/WSG7DkCk=;
        b=ZFL9KtaRLkiwad1Xyepm/V52jgCqTOIv+OJEwe5NlYuyyhhoYmTWbj9My2tJliD7DQ
         oIZSiWIuK4klgnbMYgs0Vo7IsZ2Ne9Cpn/IsAtqR+rGCZdMcrgcx5YJ2kmi9K11pgMHa
         gtzn/i04And8wj7Gv3dfUngFua8Phg9vUW6I/lLlDXCGr/0leeqrmX+TERpfB9hlA1bv
         w8tR6JurCYKJD9YKi8eQxhC9XzCIjNKE4ZSMq8EnwOetO9L1P56EpYIoPF2cqZol3Xf8
         Q833jKxdOvEDgMrdGrLbi7zk5UKvikVVnHpn5ZHmcmLAysFKSDfFtVjPYPhjT0U1hkGZ
         Plig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960436; x=1728565236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnd2xzgi6SWd8Ws/iTATnLnBkzdv8ijAh/WSG7DkCk=;
        b=QmTldK1cXvt662eTNXxxDJX3EJaZ8b38Icl1qke4RWx104pPWxLY0SiDFSLCHJ8DJg
         58LyHi8zAGrhiJrRLbMCcF4QoHwRI42QKY+MB2p3mokEJysrqLHGCQ2g2V8ISrw0zuGD
         Ee0ZDEb55aYdgQH7mDQdrAjVIqQW7YPYe6T+3lRStkS7Q2etnfY2e8Ujcy9Ez8ok5EyO
         WwhI0T1q7CXeZjUL38eew+LnWMQfu/MKxNSsGV8tifI4tVSiFTDaGKzbW+Zf6TNjltG+
         ENmo4K0WYJpV+TkjsST3j1mrEYVxQAOc1hXLU+zjpsN2eaYkZmz+dWe/zYI/W75VSzgL
         JHDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3knCffd+E9zY6qT94XiM8m78VYcMzcWn3pI0P+1n9q0PE7F60GyRiUJgiLg3Mp0l+fcU=@lists.linux.dev
X-Gm-Message-State: AOJu0YybT/CfFDBaPVPY9sf1EMznLXOTTClwzYzwURv3wRfyyjFnWMiQ
	PEIJMryR5ioHsQVudawiUKaWJ9K3CVHirz/K8Z0sZ5eSzENraxaRK6B41u65
X-Google-Smtp-Source: AGHT+IE2nky3szEwj6sAzgYSykkWdl8fQPbZwq8COdCbA3aqxuc1BDTl8VziJNgnMNAsVHKZ52wsfg==
X-Received: by 2002:adf:f846:0:b0:37c:cd1a:31d with SMTP id ffacd0b85a97d-37cfb9d285emr4248493f8f.26.1727960435648;
        Thu, 03 Oct 2024 06:00:35 -0700 (PDT)
Received: from [10.168.3.25] ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d97aasm1209613f8f.111.2024.10.03.06.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:00:35 -0700 (PDT)
Message-ID: <ba4ea86c-7abe-4873-9ccc-44bc339d9ee7@gmail.com>
Date: Thu, 3 Oct 2024 06:00:31 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.22 segfault
From: James Prestwood <prestwoj@gmail.com>
To: Jules Maselbas <jmaselbas@zdiv.net>, iwd@lists.linux.dev
References: <D4M5LOG8MPW1.SYF1VD48Y3YH@zdiv.net>
 <afdaa1f4-5b24-4d33-962e-3b026b65c626@gmail.com>
Content-Language: en-US
In-Reply-To: <afdaa1f4-5b24-4d33-962e-3b026b65c626@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jules,

On 10/3/24 5:26 AM, James Prestwood wrote:
> Hi Jules,
>
> On 10/3/24 5:01 AM, Jules Maselbas wrote:
>> Hi,
>>
>> I am having a segfault in iwd 2.22, running on Alpine Linux (on edge).
>>
>> I can reproduce the segfault by doing `rc-service networking restart`,
>> dmesg gives this information:
>>
>> iwd[4229]: segfault at a ip 00007f027ca94c6b sp 00007fffd6c75858 
>> error 4 in ld-musl-x86_64.so.1[7f027ca44000+57000] likely on CPU 4 
>> (core 2, socket 0)
>> Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 
>> 07 00 00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> 
>> ff ca 75 fb c3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48
>> ...
>> iwd[24403]: segfault at a ip 00007fa91633ac6b sp 00007ffd1faaa028 
>> error 4 in ld-musl-x86_64.so.1[7fa9162ea000+57000] likely on CPU 6 
>> (core 3, socket 0)
>> Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 
>> 07 00 00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> 
>> ff ca 75 fb c3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48
>>
>> This is not an issue in musl-libc, but a call to memcpy with a bad 
>> address,
>> we can see that the source address is 0xa (10) which is also the 
>> offset of `aa` field in the `netdev->handshake` struct
>> which makes me think that handshake is null when netdev_rssi_poll is 
>> called.
>>
>> Here is a backtrace when iwd segfault:
>> (gdb) bt
>> #0  memcpy () at src/string/x86_64/memcpy.s:22
>> #1  0x00005555555fc0dc in memcpy (__od=<optimized out>, __os=0xa, 
>> __n=6) at /usr/include/fortify/string.h:55
>> #2  l_netlink_message_append (message=0x7ffff7f34050, 
>> type=type@entry=6, data=0xa, len=len@entry=6) at ell/netlink.c:841
>> #3  0x00005555555fd78f in l_genl_msg_append_attr 
>> (msg=msg@entry=0x7ffff7f34020, type=type@entry=6, len=len@entry=6, 
>> data=<optimized out>) at ell/genl.c:1518
>> #4  0x0000555555559080 in netdev_rssi_poll (timeout=<optimized out>, 
>> user_data=0x7ffff7f38dc0) at src/netdev.c:760
>> #5  0x00005555555f959e in timeout_callback (fd=<optimized out>, 
>> events=<optimized out>, user_data=0x7ffff7f363b0) at ell/timeout.c:69
>> #6  timeout_callback (fd=<optimized out>, events=<optimized out>, 
>> user_data=0x7ffff7f363b0) at ell/timeout.c:58
>> #7  0x00005555555f8a75 in l_main_iterate (timeout=<optimized out>) at 
>> ell/main.c:461
>> #8  0x00005555555f8b4e in l_main_run () at ell/main.c:508
>> #9  l_main_run () at ell/main.c:490
>> #10 0x00005555555f8d7f in l_main_run_with_signal 
>> (callback=callback@entry=0x5555555587f0 <signal_handler>, 
>> user_data=user_data@entry=0x0) at ell/main.c:630
>> #11 0x0000555555557bd0 in main (argc=<optimized out>, argv=<optimized 
>> out>) at src/main.c:614
>>
>>
>> I've also ran a git bisect which points to
>> 154a29be0552f5a39e34301ebaf24623d64073da netdev: fall back to RSSI 
>> polling if SET_CQM fails
>> as the first bad commit. I noticed the "rssi" word is also present in 
>> the stacktrace.
>
> Thanks for such detailed info, do you happen to have debug logs when 
> this happens? I'm just trying to see the code path which leads to 
> this. I can't seem to reproduce it but I suspect musl-libc is just 
> different enough that its exposing the bug
>
>
>>
>> I am using the following wifi card:
>> 03:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI 
>> Express Wireless Network Adapter
>> driver: mt7921e
>> version: 6.6.53-0-lts
>> firmware-version: ____000000-20240716163327
>> expansion-rom-version:
>> bus-info: 0000:03:00.0
>> supports-statistics: yes
>> supports-test: no
>> supports-eeprom-access: no
>> supports-register-dump: no
>> supports-priv-flags: no
>>
>>
>> Cheers,
>> Jules
>>
>>
> Thanks,
>
> James
>
I was finally able to reproduce it. Its completely timing dependent and 
I think if IWD gets restarted _just_ before the timer fires it will 
crash. The easiest way to reproduce it was to just disconnect with 
iwctl. Anyways, I sent a patch to the list which should fix it. If you 
have the ability to try it out to confirm that would be great!

Thanks,

James

