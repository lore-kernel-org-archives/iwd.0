Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88111C92
	for <iwd@lists.linux.dev>; Fri,  4 Oct 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009197; cv=none; b=FZOcKaX40MbdpRzpZnX+zcJVy7Ulpb389pLNGAOivi6XfPv0eGNc/kVFq57PKkTmsfPyW4n9E6BrrdDc2WHpFSWsN1806oCRSi8/xoOodOq1vNwGTOiWV3nUyha5HPLlzUzpxfUxAgAM6MmRoV3Z2xPvG3AsB98ut9OIO4PwPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009197; c=relaxed/simple;
	bh=xpbDXrL1kAmXLCPKq/ta4iwHK5fnQXshSLcKRqR6izI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s4ELi6TGoCKyA/lOUw7DdUhX3eC/zU4+pgrrBd9KrHKW2z9+q+YjclZ6PBTkN2ZU82UWS3VePRWsvjBwW4aN1qE2bFvgk58j//kZELp2d+0KnOVmdx4cUsi+MKTcSjW+nNO1S6MK10LqcDP656OOLo8A51ouX6nhaT/ZLFTp2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn6DTKwp; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn6DTKwp"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e16d974030so833033b6e.1
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728009194; x=1728613994; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKiZBxpFJ905cXb1KvPBrplt+UVApTeKwDjVMVDhfGo=;
        b=Zn6DTKwpm5OZZBJG4+mfELeU/jcdb/Nxbzi4EnCPu2fJQJm5va1yonBk46r79Hv/aZ
         tHb2dhtXk+j2ExVOtUSGuc0ETK07g4OM/IiJnKnQaoUs1vPqXx1LZqPWpgxteTdEkRcy
         1qiV1XY+/zGshbnlX5wBUyRCaM7uPp/LCCIn0OfBTvvB9lM9UIjhXksEjpcZpEaf051H
         AL5N0sI9xj9mrZ4DRamuh6bKCdG/xo1BrXYKuHfmZ/1Y5lbbJlLVPCVks+Q3BcrI5XvC
         RyE5wPZf2Sl91RpnFyXK5Hi0PLn7vKUO/1E+jwqTdHLpgCLbQnMbKVEUz3Zj4aSltXcA
         WpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728009194; x=1728613994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKiZBxpFJ905cXb1KvPBrplt+UVApTeKwDjVMVDhfGo=;
        b=Z7WUcaJK37+YVg61inNnqnBwo4V+2QzOgDvrwtL8uZxcitC2TkUywmnuJReZfmdPtZ
         Gckf3XM5jZOv0rYpsecqOtlgYVo+H6Hy8dc451YgdqvtErs7cxW9eOUVlD7kSjk1V1cx
         BVB7NmJpnh2povG4VtFWp6c73ZiF9cg0DOPsD2tLS6A5rnku8w4EyZQjYaw7naK31DJT
         16tJkqPYcknRleJNvtbQZcLBbuSoS6nptuZSwQet9aoJaU09Q9AP1qU0kgvWKni9nnxB
         KdCEQt5NwqtCn8qLTt+SYn4v1laxG69cArka8nmEafryfwDHavD2rUUgEpoOABAnjvx6
         g6jw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3c31mYEvtkBmc8dd+8Cl5m5hOcRxY3enlvVVuU7uRcNisD3Y0P6UD177wjabHrisI64=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc+GuXWa7VqH14Nbh4YOyRzQc1yZfk64viIpzAmDkDJpw44pAm
	RJ24lXLe8T+KhpokLT+KpcUyrBqPXHHbQAksE5RwpyxiHadkhAwy
X-Google-Smtp-Source: AGHT+IEBnywUhTKIGnDAO8yfQ9hZxUbsw4dFoe3ovjrPkNdf25ggAXEWngmgQL0vZrhohx1OPLvcZg==
X-Received: by 2002:a05:6808:1306:b0:3e0:b64:14f with SMTP id 5614622812f47-3e3ba1bc72fmr3116248b6e.13.1728009194511;
        Thu, 03 Oct 2024 19:33:14 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e3bc3627f9sm749864b6e.8.2024.10.03.19.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 19:33:13 -0700 (PDT)
Message-ID: <237bd91d-95a9-44d4-b5a3-c1db53b7622f@gmail.com>
Date: Thu, 3 Oct 2024 21:33:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: fix crash in the RSSI polling fallback workaround
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241003125817.75004-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241003125817.75004-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/3/24 7:58 AM, James Prestwood wrote:
> Prior to adding the polling fallback this code path was only used for
> signal level list notifications and netdev_rssi_polling_update() was
> structured as such, where if the RSSI list feature existed there was
> nothing to be done as the kernel handled the notifications.
> 
> For certain mediatek cards this is broken, hence why the fallback was
> added. But netdev_rssi_polling_update() was never changed to take
> this into account which bypassed the timer cleanup on disconnections
> resulting in a crash when the timer fired after IWD was disconnected:
> 
> iwd: ++++++++ backtrace ++++++++
> iwd: #0  0x7b5459642520 in /lib/x86_64-linux-gnu/libc.so.6
> iwd: #1  0x7b54597aedf4 in /lib/x86_64-linux-gnu/libc.so.6
> iwd: #2  0x49f82d in l_netlink_message_append() at ome/jprestwood/iwd/ell/netlink.c:825
> iwd: #3  0x4a0c12 in l_genl_msg_append_attr() at ome/jprestwood/iwd/ell/genl.c:1522
> iwd: #4  0x405c61 in netdev_rssi_poll() at ome/jprestwood/iwd/src/netdev.c:764
> iwd: #5  0x49cce4 in timeout_callback() at ome/jprestwood/iwd/ell/timeout.c:70
> iwd: #6  0x49c2ed in l_main_iterate() at ome/jprestwood/iwd/ell/main.c:455 (discriminator 2)
> iwd: #7  0x49c3bc in l_main_run() at ome/jprestwood/iwd/ell/main.c:504
> iwd: #8  0x49c5f0 in l_main_run_with_signal() at ome/jprestwood/iwd/ell/main.c:632
> iwd: #9  0x4049ed in main() at ome/jprestwood/iwd/src/main.c:614
> iwd: #10 0x7b5459629d90 in /lib/x86_64-linux-gnu/libc.so.6
> iwd: #11 0x7b5459629e40 in /lib/x86_64-linux-gnu/libc.so.6
> iwd: +++++++++++++++++++++++++++
> 
> To fix this we need to add checks for the cqm_poll_fallback flag in
> netdev_rssi_polling_update().
> ---
>   src/netdev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

