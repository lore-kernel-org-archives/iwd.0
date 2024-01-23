Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53785F867
	for <iwd@lists.linux.dev>; Tue, 23 Jan 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019321; cv=none; b=KgaODL4tFwx5tI+4BZ7FWS+VQ7pba9rWQ/AdLIv6dwwErpSTymPYSoO2ioFQP0SK7GA8HNj2aOrstAB/C4RthM0Uil2E2OdAhwP5mCgYABaWIjrBC36oauBTXUwRbH5R8q7ijGNlDigFuS5RCZufMceEYXOGwrdXJd+5extBYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019321; c=relaxed/simple;
	bh=38kAVL5Quq0+C8bwhNdlNAhBGlowksIb246Nxe0piBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e81AXfYUurW1pbnWCe3ruq5YqNuu135j9puxHw34A4cVmvXVCCIqLICyWVe54VdFGRbWNpZEjpXjT+3tTEtYdKhQtOBeWCiNsnYtUYEYJPWsb3xKmIWSw4EXPWFYNZ/bKbTRktXb369Kszkba19/JxAd2cK74EwhzI4V+rx6vUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVR99UzB; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVR99UzB"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68009cb4669so22356926d6.1
        for <iwd@lists.linux.dev>; Tue, 23 Jan 2024 06:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706019318; x=1706624118; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3ylmKXN/8oVgwWXOlgMPqRm3OIDRF1H7HBtqIDPyAM=;
        b=QVR99UzB94efIIaz4APNMj9bXiivGKUBlsi8zSX+zsflzyKLJhTNnNsPsY7cQRdejI
         Wo/CSzCPi8GXKhh07uAN/IYMex2g2dU6gsVKDPD4V4nK07hQnItGwYU5u6ZNdSvXJO1x
         UJclwQbSxbzSYd5zlDNjhArZ2eu7o+7N8SwGCnqvHeCF9vt3TkCTsjhuUrGRaK9pEoba
         vNMwxgn/Ly8OaVEBHQorDYbUgJRqM5x0BLuQtKrrjpe5Z0GfDIfnDFBmrtPAJgRDHL4Y
         12inVvmPzsJf+8xWPyt/yWHlTBbzUdUFjCR9f1yKZzY0TifLopmNaE2HT5oWjew6AEE6
         jemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019318; x=1706624118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3ylmKXN/8oVgwWXOlgMPqRm3OIDRF1H7HBtqIDPyAM=;
        b=S/5MpvS3rrJwPtxQRK0WIozR82es2gSCEBY/kFqnz+cpR+Nj2ynohRHQb+RHkEWTc8
         gt2a43uPnGBATw2xk9mPGrYi/u5IU80WtgKRGKVhe00mOEjSio3qI4/6G90GdvQWd6n8
         ROoPzoPTuJ9N/y1EEocxuR9WIYoSLR076s3BodDJxlnwwAxGu+6ev8jxsklLeWsC1myi
         BwtCPISEPGA7bqo2dKR6AqsaTwj1f95qpO39v0byomoSH8K6hecrX3OnWQ+YuG21lbZn
         g5r3PuO1G4njLPJEmFe3oSrj/Vf8hdSdY0f/5YEePAVxTrkQH0JDmFOhQub4CIvNsad6
         RgHQ==
X-Gm-Message-State: AOJu0Yz32U5nJd81Z66wdK/t+aVDE2WSuiVSL3JR/a+PZcCnDrumrV5j
	A992nN2UT75GhpAKmOD/UR1OvKytWlDobUG9t6QAJV30mDNMs4Lo
X-Google-Smtp-Source: AGHT+IFev2PmBu7654nx5NJyep0KOHgj0IHDETVusmAWmviVGGGpmo208NdvCNrneCEaU1x24o88jA==
X-Received: by 2002:a05:6214:2021:b0:685:8f1d:259d with SMTP id 1-20020a056214202100b006858f1d259dmr1041709qvf.14.1706019318153;
        Tue, 23 Jan 2024 06:15:18 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kv8-20020a056214534800b00681929ad11fsm359339qvb.76.2024.01.23.06.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:15:17 -0800 (PST)
Message-ID: <d8e965da-ae8b-45cf-b29b-2b75faa73805@gmail.com>
Date: Tue, 23 Jan 2024 06:15:16 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
Content-Language: en-US
To: Fabian Herb <fabian.herb@xtonomy.ai>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabian,

On 1/23/24 5:36 AM, Fabian Herb wrote:
> Hi James,
>
>> Am 18.01.2024 um 13:18 schrieb James Prestwood <prestwoj@gmail.com>:
>>
>> On 1/18/24 3:51 AM, Fabian Herb wrote:
>>>> Without implementing a new feature with per-phy profiles about the only thing you could do would be:
>>>>
>>>>   - Create a network namespace (e.g. ns0)
>>> Thanks! I’ll look into that idea. At a first glance it looks quite cumbersome though. Maybe this could be done with LXC or Docker...
>> Yeah I actually hesitated to even suggest it :) Though once you've done it its not _that_ bad. We do this in our autotests framework to simulate networks, and run multiple instances of IWD. You may be able to do it with a container as well.
> I tried with systemd-nspawn, but that didn't work so well. For one you can’t put the phy into the container with the provided tools because it’s not a regular network interface (setting the ns manually works though). And also starting iwd inside the container gives me a „Module rfkill failed to start: -2“, even if I bind /dev/rfkill into the container…
I only ever did this with low level namespaces, but yeah, its a quirky 
setup to achieve what you want.
>
> I’m starting to think that it might be easier to add a feature to iwd that does what I want :). But I’m still a bit lost in the source code.
>
>>>> What exactly are you trying to accomplish by connecting to separate SSID’s?
>>> That’s for redundancy. The machine is moving around quite a bit, so there’s lots of roaming. Reception can be bad in some areas. And with two WiFi connections and 802.11r Fast Transition if possible, I hope to get network interruptions close to zero. Redundancy itself is done on application level.
>> So this very same thing is being added in WiFi 7, called Multi-Link Operation (MLO). It doesn't help you now as IWD doesn't have any logic for it but just putting it out there (and maybe AP support is also needed). They've been working on this feature in the kernel for quite some time now.
> Yes, WiFi 7 is certainly interesting. You can already buy WiFi-7-capable hardware now. UniFi promises MLO support to be available in February with a firmware update for example.
>
> Is there a time frame when MLO support might be added to iwd? Or is the work on kernel support still ongoing?

It very much seems like its in active development in the 
kernel/wpa_supplicant. There time-frame to add it to IWD but at the very 
least we'd want the kernel support to be stable. Another factor to 
adding larger features, simply put, is corporate agendas. Unfortunately, 
gone are the days of us IWD devs getting paid to add whatever we want, 
whenever we want (that's at least my situation).

So as for MLO yes I could see it being added at some point, but its not 
really a priority. My company is just now starting to add WiFi 6e. When 
WiFi 7 becomes more widespread I could probably get MLO support on the 
agenda as it seems like it would add connection reliability but I won't 
lie, its a long way off. Anyone else is welcome to implement before then 
though :)

Thanks,

James

>
> Best regards,
> Fabian
>
