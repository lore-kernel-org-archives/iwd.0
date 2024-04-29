Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C7177986
	for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426157; cv=none; b=YGQB3iNc7+MoQUj/z8bhd7iiGMSAk2ib6TSWN8rUUzz9Kgmv5G77eDigtRcaP/zTTx1DPfRq5iB8qwDWkMecNC2ZpQEd6YIx4XMKD8SyA1OwOw8Uvfmd4S3RCp6MHNr9fwS03YBAqE4JzOf0CW/ouCnGpMBjYetYP0FmEwjbdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426157; c=relaxed/simple;
	bh=f7EuT/7aQ7Q9G+CkWHjnIpmzSmdQZ3jZKu3nNxrLqTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BENdQrNUsniH1c/W0uzLK/9MfIzYu+JtUNPtNVyte0nUxi5S2Hopc2uXks3Aebj5cHOK+p1qp8OLVNScs7zd1wQGfKkWVmL/dZF0EbyVi+2ecpy/PAtly14vjpaGWhf7NSPNuCaGeQe5EqHVMAMMOmTvk2veklTamTZIv5gMqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD+0sRjR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD+0sRjR"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a05f376effso39393616d6.0
        for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426155; x=1715030955; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIQb/2/6d3DuyPFPsy3fMgnFar+jDhELmYtfj+P5Ftg=;
        b=OD+0sRjREQyXGT1O/g8sW593uk0XIDhfAI1W14lDJy7HqZcHrsQjb2TVEbsfs/4a3G
         KOa6I/mKrYqHOtn5c5QYRcxUjO2l6MqjyO0DAwgwM+ws8PWkw44aIKVX6tn4m0oNBImn
         kYD7jWrNkS5MT/yNACT9Nsa5+t+IKkTWeCv6Xs3TqwLODDBWrC0/pp24EtjazUDvXUKf
         JgnVs94UamcWuDo20lthPT7dQIo6Fr36GMu7FIYZTUoxNu6FnYzW1sSqDWk1lH2V8jfY
         0aE9X5fyglD7+PmNkUaZJhhshEd7zExQDC0px9QC3KtRd+4CtTPA27/pd9teD/se7WrD
         nrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426155; x=1715030955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQb/2/6d3DuyPFPsy3fMgnFar+jDhELmYtfj+P5Ftg=;
        b=XGR2Or4rs1Y4q7WDAL3SnjZil//CAkzRM1r4ErOiKaZlU3Txk2YP4s635kMNuWj/hC
         QC1H52TUZjrBzImt93bQrvazpqXmW5GnzqeEslqR2dxJwaV2HN8mW+gwRHWKPcoCiFtJ
         rJHZxJmK84pnBZvN88vf4kaIrCWptXbbRXQyVWwPMtEVMbosP5KeYBk4Bk6cdcrm0uv5
         vAg40o91yIk6Da0NY6G3bVIB/b6EXUMYgU6EpOI3TminPgPAnX6/2KJMfOiTDaGmPExB
         qOzPNdU4U6RE8Ao2A5czjFWGWwacda8ypBwZW1bjK4bcfYYfHmggAiiLWbF2XP+V2mxG
         4PNg==
X-Forwarded-Encrypted: i=1; AJvYcCVHn/bOnZod+MBiqP+LO7Lr7SAw7dmBOyN7cb/hdFoI59TAnRi0iRgadQCmD7zCEOn3cZpaYKll0HGR2qQ8vZNT+LJI
X-Gm-Message-State: AOJu0YyNOChrM9WbR7uzNsR98I2lTDpJF4cWLKsJ5PKgXvDh3m3hBXbh
	ZkioKgyaQBuz5tYWIF1pTCS1nvH+0ch/0wiKj+b3ItE630vg/Pbj
X-Google-Smtp-Source: AGHT+IG1aRG2Ss43jNFLigZeS8fbSe0ARP8Ddx7aDxMHI0YQw5bsSI8PJ5AQZsxtR6Y+eFZ+zAb+ZA==
X-Received: by 2002:a05:6214:1c44:b0:6a0:d290:693b with SMTP id if4-20020a0562141c4400b006a0d290693bmr3672989qvb.50.1714426154650;
        Mon, 29 Apr 2024 14:29:14 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kh10-20020a056214514a00b006a0cd8efe9dsm1411098qvb.31.2024.04.29.14.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 14:29:14 -0700 (PDT)
Message-ID: <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
Date: Mon, 29 Apr 2024 14:29:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and WPA3
Content-Language: en-US
To: Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harry,

On 4/29/24 1:25 PM, Harry ten Berge wrote:
> Hi,
>
> I'm not sure this is the right place to ask for some assistance, but
> here we go...
>
> I'm the author for a small Raspberry Pi audio image that is
> specifically targeting Roon.
> If you're not familiair with Roon: it's an audio streaming platform
> targeting audiophiles ;-)
>
> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
> full satisfaction.
> Better and easier integration, and overall a feel of me being in more control.
>
> Now, recently I'm having issues with WPA3 support. This is partly
> related to firmware (it's just so obfuscated how this all works with
> firmware from broadcom and firmware from cypress :-(
>
> And one of those things is that I can't get it to work on the new Pi
> 5. Specifically IWD reporting this:
>
> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> CMD_EXTERNAL_AUTH for SAE
> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> Can't use SAE, trying WPA2
>
> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
> advise me to go back to wpa_supplicant. Which is not something I would
> like to do for various reasons...
>
> Do you have any advice for me on what I can do? is this
> CMD_EXTERNAL_AUTH really related to  this and are you planning on
> implementing this?

Unfortunately the external auth support is not yet implemented in IWD. 
The brcmfmac driver itself is rather unique being a fullmac driver. 
Depending on how you look at it, this on its own is "easier" to support. 
It handles connecting/roaming all on its own. But then, for some reason, 
someone didn't want to do SAE/WPA3 on the card itself so they came up 
with some one-off mechanism to offload that onto userspace. This is one 
of those things that got put upstream that is a pain for projects like 
IWD to support IMO. Its something we do need to support eventually, 
especially given the raspi 5 requires it.

Thanks,

James

>
> Thanks
>
