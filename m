Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080524B28
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778446; cv=none; b=GMCb8B/e5nY3Lv4g5iOd+HZkXj0QqqZ7yVWOJ/hxeLw9Eioa5CrmfO3U6buHg7+EEogcJWxryd2C1TtkSLK67b1aBPSsfYrBHo3fcaTy2MkoWJRZ8v3BbfiaF5VVvHOkgVeqg4X9olMt6/UyxdHjQX/ATKoRCmH9eprot4cx3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778446; c=relaxed/simple;
	bh=8+3pNZ7Necc94jtAMyW6spEdZQjrtb9ybIfhdH+LA9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnpAEQ3w/SZ8T3zZ9Je9vhtOfItq+yj5XHIcwNLU3AOid7rZGmBkvJu8skJ/Qx1q/OCEcxsHF422sEJFkBuuAPlNZ1Blv7jVvHjiyjG/6pCkESjKykUv3O1by+6POhO1u9ZgOYyMk0ixJ5EnC+/IqJ0RL7SqXUDTlqPnd7L3YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjZ6xXF9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjZ6xXF9"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e98bfea0ceso430513eaf.0
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729778443; x=1730383243; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufc2rfiS/UZvtUfHoFMWfyg8s9aI3hHS7xESLpZDFGY=;
        b=QjZ6xXF9KlmPi0u3ldSHNtZIuZABLhKg+0KeAhSx8cj+cLqL56pd4Btbna0u7QHhkz
         KgsfxRV7Up5vDL5k7rJ9B8AhYhfz87E7soKrqdelPR0DqVSm79TDJpWYUXhIdjit7wUD
         A7oW2OTd37Iqei3YSpAbgxcEDc9tqizI4QLRCr72JpVSitTa+AixlbAcaUb2vC9ZtKOS
         QPu6x2TB8LdDQq4DbYUVPtB7WqIhr2+VW9753j50rd4YHAbDR1DaCMM5JldTOvJysIM2
         qRWBvJKNsJxH/9E+4OjeQootwfkmhmD1bxVUE2o2A4GfHC2u3ZuRFDtJdfpjWN51I1Xo
         BTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778443; x=1730383243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufc2rfiS/UZvtUfHoFMWfyg8s9aI3hHS7xESLpZDFGY=;
        b=JPYNg7THOJyfRZnzAc04i++/yHEmMIDhp7OkFf2FqnT7QqMLgH1eE7vSRsDp+ypEdR
         35w0EldhsPcPErwR4qlGAFuC2wZZjxA2EhLPgtOiN3UDw/OVLf58KBDEz8+odNVm100K
         o9LDsAwMu4U5RVWThl62lawwQccAW4QVitPzjQ7T6i1AT2sTI4GUaj/afyLVIsXvr8h9
         ZyqgJO82/EznwxUAXqOW3clu8MJxvtfzJYMDEiqjnaAwx2eHMDfrU87lm1fV1Cp0pTt7
         yaVgpPan8jgtVrBKTSrBeC/S/VtSbbPL2B1UIuI8yDI2WS1vzaQHatMU9rYIsVU6I3B1
         gGUA==
X-Gm-Message-State: AOJu0YydEkMYk6OVp4aAvUEmR1AW9sUduWmhYs+8nNQwf+c+wLbKwUpP
	8NlDAW7pX7fvQ61XhLmtOlZFMa5fjbmhssKI0aKdmcZtrGOJhM97
X-Google-Smtp-Source: AGHT+IGaLGi/4tYz+qBWygc03GWwzzeHr10shf0mY/l/8aIIXQ5OX+we1R02zGt87AHFQjvfHSfoXA==
X-Received: by 2002:a05:6820:825:b0:5e5:b652:9d14 with SMTP id 006d021491bc7-5ebee4adea3mr5152737eaf.1.1729778442109;
        Thu, 24 Oct 2024 07:00:42 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5ec02b6d73dsm370989eaf.24.2024.10.24.07.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:00:41 -0700 (PDT)
Message-ID: <d27c9f76-ee7f-4509-a05e-6e05ee444181@gmail.com>
Date: Thu, 24 Oct 2024 09:00:40 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.22 scan fails but... works ok with ConnMan
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: iwd@lists.linux.dev
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
 <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
 <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Piotr,

>>
>> What hardware is being used?
> 
> 
> this is allwinner h618 zero3 sbc with uwe5622 wifi chip.
> Kernel is 6.11.5 with uwe5622 driver backported from vendor bsp (https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.11/files/0630-net-wireless-add-uwe5622-support-v20231020.patch)

So yet another non-upstream driver, sigh.

> 
> 
>>   Can you include iwmon output?
>> https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html#iwmon
> 
> Trying to use iwmon shows me:
> 
> root@myth-frontend-0200dd63cc00:~ # ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
>      link/ether 02:00:dd:63:cc:00 brd ff:ff:ff:ff:ff:ff
> 3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
>      link/ether 24:b7:2a:45:f4:e5 brd ff:ff:ff:ff:ff:ff
> root@myth-frontend-0200dd63cc00:~ # iwmon -i wlan0

That doesn't do what you think it does.  -i is a mostly deprecated option to 
specify the nlmon device to use (not the wireless device you're trying to snoop on)

Try it without -i.

> Wireless monitor ver 3.0
> Failed to create monitor interface wlan0: Unknown error -17
> root@myth-frontend-0200dd63cc00:~ #
> 

Is this in any way related to the problem reported in this thread?
https://lore.kernel.org/all/CAOCHtYj9OjZGQ=G139i=KRRcxpFD-1=GSvUPmFYaqSvFz0NwJg@mail.gmail.com/

Regards,
-Denis
