Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D11547FB
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958408; cv=none; b=hsy4yqcy0JWvnxhYzjcpargmfwzmmfvndyAZLke6t/0QVIC1rZN1ZKdTafDh8CxiZf13MrWtPGj2yzNhsQU2LY7YrzazmBfdcpQhdhUGXU5mjxtVDKwiUiSapPu0ypUlgSeZG07MwQLF2NpO7e3KFwpkv/Xj/UgFG+DbC96wzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958408; c=relaxed/simple;
	bh=tq8T/VvZSU+ULhe4E/HkSek1CPv+U4fj+9suEd/KQnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f3G099XA+QthQlm1/leSLHC1nvZ0MiDkvyvQzAWnCqlLtn37c/IpnE5B92XuDTVbtJrI3dR4RPfy6u9V4OXLWE9q/3fBUOBAhzgKRfum36TQOECi6exaLXHXvf95mcHLIBg4w1P7WShLJdr5axRHm0NR4kNAB2uV+ERRyC6kijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7bSRBBp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7bSRBBp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccc600466so534934f8f.1
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727958405; x=1728563205; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlsQKm0imu6j8HZbpnZSwyNkSgJdlzGTzNhMrYDB2go=;
        b=e7bSRBBppUYADF3QTutUUh07eFAg6gwGKgdlEPJO1D7l+2dklnWUmBkPMfrOzNqQLI
         2Prx1qTbirgS6glm9GptdGkmYacnzpNq3zndJJr+W/0cH6pxAV8E55shFLwj1MWhzKyX
         K+5PSF1/aEC1oJfcgJIptcQMfBcmQ9tT0s/JUXiPIAObtWHRFdYX6ND/RF1Q7XlxFldS
         atgn2XWDXtWCcT7UHwRqm/aBd6u3F+P2wJEAiIAAfCBBZBn1PWtggtNWIErVO3AnL8VV
         CWF2UcD8jnxQBtie/e04jE1i9gjGZryBzGWsqwdzRVFz2tlacJRMxRG77nifFm4GXreq
         MtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727958405; x=1728563205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlsQKm0imu6j8HZbpnZSwyNkSgJdlzGTzNhMrYDB2go=;
        b=RKVuuPRY7sSJf8wxRxK687DfqHNI7D3uJD1PLwP5ojHX6GPnmPl4+wQl+63BHrM6mc
         3kMLHMSoAP0SdqbKI+qxUeIE1jpdYbqrDoNTjeGGCPEVCujFc3DUOk/tRA5BN6tfjdsU
         EDUTuhMJ+MP4BaqUVlfmiuUZg1usNEd3AiB+zU1xdMJOlpZzZhCGX+BsfAmHPCh1UNlb
         J1lWtz/b+CIK2iJe86qslUmlRwKgMcO3tif0N5N3MXybLtSKTwcg1bJs6fAUQYEws6tJ
         TwJHDtvIAtMCxXt4MU8DiWQUwdw/OVbOlSFyg3CidDwXGOrecGI2VUFoSiwctnDKF0vn
         aWVg==
X-Forwarded-Encrypted: i=1; AJvYcCWbqt4JdNYvhKkE3TBAls5ZYoezpiOMix5cREqzW+5Ew8exk27SsiOhFNFvXou/neKEkgk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJQwFFSZHSaOwgvKa6rPNjH0vNbOmOzbU4Im3OVZPQ0w/gMNvl
	LbJ0uebbailj52dUqZH6vE43QrMHl/C/dWaWWqP6X5rmfOLD7ef5r9468AWw
X-Google-Smtp-Source: AGHT+IHQp7z2H9N96s908zNyIq7V60cDOBGbZUh/WycMq9v3h/hJsoABp2Kyb5PnBpxeKEDrlGr50g==
X-Received: by 2002:a05:6000:2cb:b0:37c:d507:b44b with SMTP id ffacd0b85a97d-37cfb8cb57emr4892423f8f.26.1727958404952;
        Thu, 03 Oct 2024 05:26:44 -0700 (PDT)
Received: from [10.168.3.25] ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08245059sm1176233f8f.55.2024.10.03.05.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:26:44 -0700 (PDT)
Message-ID: <afdaa1f4-5b24-4d33-962e-3b026b65c626@gmail.com>
Date: Thu, 3 Oct 2024 05:26:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.22 segfault
To: Jules Maselbas <jmaselbas@zdiv.net>, iwd@lists.linux.dev
References: <D4M5LOG8MPW1.SYF1VD48Y3YH@zdiv.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <D4M5LOG8MPW1.SYF1VD48Y3YH@zdiv.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jules,

On 10/3/24 5:01 AM, Jules Maselbas wrote:
> Hi,
>
> I am having a segfault in iwd 2.22, running on Alpine Linux (on edge).
>
> I can reproduce the segfault by doing `rc-service networking restart`,
> dmesg gives this information:
>
> iwd[4229]: segfault at a ip 00007f027ca94c6b sp 00007fffd6c75858 error 4 in ld-musl-x86_64.so.1[7f027ca44000+57000] likely on CPU 4 (core 2, socket 0)
> Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 07 00 00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> ff ca 75 fb c3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48
> ...
> iwd[24403]: segfault at a ip 00007fa91633ac6b sp 00007ffd1faaa028 error 4 in ld-musl-x86_64.so.1[7fa9162ea000+57000] likely on CPU 6 (core 3, socket 0)
> Code: f8 48 83 fa 08 72 14 f7 c7 07 00 00 00 74 0c a4 48 ff ca f7 c7 07 00 00 00 75 f4 48 89 d1 48 c1 e9 03 f3 48 a5 83 e2 07 74 05 <a4> ff ca 75 fb c3 48 89 f8 48 29 f0 48 39 d0 0f 83 bf ff ff ff 48
>
> This is not an issue in musl-libc, but a call to memcpy with a bad address,
> we can see that the source address is 0xa (10) which is also the offset of `aa` field in the `netdev->handshake` struct
> which makes me think that handshake is null when netdev_rssi_poll is called.
>
> Here is a backtrace when iwd segfault:
> (gdb) bt
> #0  memcpy () at src/string/x86_64/memcpy.s:22
> #1  0x00005555555fc0dc in memcpy (__od=<optimized out>, __os=0xa, __n=6) at /usr/include/fortify/string.h:55
> #2  l_netlink_message_append (message=0x7ffff7f34050, type=type@entry=6, data=0xa, len=len@entry=6) at ell/netlink.c:841
> #3  0x00005555555fd78f in l_genl_msg_append_attr (msg=msg@entry=0x7ffff7f34020, type=type@entry=6, len=len@entry=6, data=<optimized out>) at ell/genl.c:1518
> #4  0x0000555555559080 in netdev_rssi_poll (timeout=<optimized out>, user_data=0x7ffff7f38dc0) at src/netdev.c:760
> #5  0x00005555555f959e in timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x7ffff7f363b0) at ell/timeout.c:69
> #6  timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x7ffff7f363b0) at ell/timeout.c:58
> #7  0x00005555555f8a75 in l_main_iterate (timeout=<optimized out>) at ell/main.c:461
> #8  0x00005555555f8b4e in l_main_run () at ell/main.c:508
> #9  l_main_run () at ell/main.c:490
> #10 0x00005555555f8d7f in l_main_run_with_signal (callback=callback@entry=0x5555555587f0 <signal_handler>, user_data=user_data@entry=0x0) at ell/main.c:630
> #11 0x0000555555557bd0 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614
>
>
> I've also ran a git bisect which points to
> 154a29be0552f5a39e34301ebaf24623d64073da netdev: fall back to RSSI polling if SET_CQM fails
> as the first bad commit. I noticed the "rssi" word is also present in the stacktrace.

Thanks for such detailed info, do you happen to have debug logs when 
this happens? I'm just trying to see the code path which leads to this. 
I can't seem to reproduce it but I suspect musl-libc is just different 
enough that its exposing the bug


>
> I am using the following wifi card:
> 03:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
> driver: mt7921e
> version: 6.6.53-0-lts
> firmware-version: ____000000-20240716163327
> expansion-rom-version:
> bus-info: 0000:03:00.0
> supports-statistics: yes
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
>
>
> Cheers,
> Jules
>
>
Thanks,

James

