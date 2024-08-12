Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459B174EE7
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462570; cv=none; b=Vl0UyhJ53CMgXKDFwIoLNrskACRLPkg3fkKS9A2buk4uKXngdkcXJzFen8rzN/BoTSRhucrAhbEoMsvrrvXY00GvBgijeO5Y3YZKYjgClwabCBPwkhVn4PfUQLtqoZ5+H5wZn5HpTWvVXX0j//F1QtGH6ifDdubn3NU8eB9fvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462570; c=relaxed/simple;
	bh=Ea+dPjdtv8AIWwVbEGp7xSOIUDHtGsuKiXdVjTSFjmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBuaZv7HGi3IWLOhbcu5mVeQ7fxq+9W5fXquGZ/rV81qfu34GXpaxy9gXQdCfxb01Nnj7E2qwLPedGqBzKULRcmkvjtp4iwcKB4CY49h29T8fuDd/Nj0WVkqEco50f46kDHgGS6zkMVHvss5hP6ZWWLGAhgltRgXdg5Co2GytDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFTJWh5Q; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFTJWh5Q"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b3c36d297so13479265ab.1
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723462568; x=1724067368; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gD85A6S4JHHbpJaFpvmU5TsV5O1W28hYSgHMJ7eF+GM=;
        b=KFTJWh5Qfg129/hraeDhpwe1WFTg1sWYz1JoLy12QlPKUXeJ32L9885rA/l0wvy38x
         VzLbTA/t4c5jDLKYTSw/gEJrlxZh22jQXajJ4rm0QBQJ6YeB+GoiMdNeqxspK8/udaQ5
         RcdSyIfhSZbi2Y96GZuyiOLGynLfjjzeSn8sR5jyr8+tohIEn6fcyX52rTVd6GyCPbRP
         phPyrPyXqPGkYXNTWiJlNx/lRTzoLWyWzRiUIMhF4Mi5GvG2U1QdNatYGtCbI4176B8k
         ZYhQgpKRxrzzbHfEHAyq8slzjcct2x9AQxAiEvvr5ZSTInzyhtOJw904Pe/RVu1+e9FA
         un0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723462568; x=1724067368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD85A6S4JHHbpJaFpvmU5TsV5O1W28hYSgHMJ7eF+GM=;
        b=AbyhMtOZ6kRSiNEQymI7vjYs5WGLhDHLF1ObTgVbu7HvAmHsqcfia74dZBn/Oa36Yg
         BkYkoaG8G3oV9I7z2nU87xsROulN+CuseRbfpmZJ6y8crWi2z7Wk9U1GKl66BbgW7eZe
         ZR6kPxbDw6oCBuExweG2GQqWsFYlYFKLKT54pgmKmhWk1E42eZH0o99prp7b7fn1g0+5
         QSDpZfdR+EHJ08xPurtsSKMSLNIXmm5iOv5GssItk64fCLfnqY6hFl6JFwc8wAmoI+TK
         Zwve828qx7M3z7YbVeCUmQB7zLiANvg9KpyjBO0GxkysrvdoB+V0WwO7xlNLmroW3EX5
         RTKg==
X-Gm-Message-State: AOJu0YzM26qeg6Jx7IvVgrjTtPlZfZEomp2BLv33MckBk6hGiDB9RDUB
	amF5w7DCqtQZ5zdKGIDvrlPcqwIBHPkzhjYXSJZjBLmFTIbFgfF8
X-Google-Smtp-Source: AGHT+IHESqVt1Vy8NcWrukDsLaaZXD/DfQ1h4mJIMKe5iUzwrV4A+xM8D9xgKRyfVahSzwU71kZOWw==
X-Received: by 2002:a05:6e02:1fc4:b0:39b:2daf:1b82 with SMTP id e9e14a558f8ab-39b7a41683fmr141272425ab.16.1723462567695;
        Mon, 12 Aug 2024 04:36:07 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe082desm4117143a12.4.2024.08.12.04.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 04:36:07 -0700 (PDT)
Message-ID: <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
Date: Mon, 12 Aug 2024 04:36:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: KeithG <ys3al35l@gmail.com>, Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
 <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
 <de951e97-547f-4c14-841c-267f64b0020b@gmail.com>
 <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 8/11/24 6:19 PM, KeithG wrote:
> On Sun, Aug 11, 2024 at 2:38 PM Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Keith,
>>
>>>       Supported extended features:
>>>           * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>>>           * [ DFS_OFFLOAD ]: DFS offload
>>>
>> <snip>
>>
>>> The pcap is uploaded to my gdrive:
>>> https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8/view?usp=drivesdk
>> What is the PCAP supposed to show?  There's no Connection attempt in there.
>>
>>> Hopefully, this helps to get started.
>>>
>> Anyway, I was curious and snooped on wpa_s from git trying to connect to an
>> iPhone 12 Personal Hotspot (Maximum Compatibility option off, so it uses SAE).
>> Not a pretty sight.  Firmware fails with errno=-52, Invalid exchange.  Has
>> anyone from RPI team actually tested this firmware before pushing it out?
>>
>> I also tried the old firmware with SAE_OFFLOAD bits, and that doesn't work with
>> wpa_s or iwd either.
>>
>> Until someone sends me a iwmon trace showing CMD_EXTERNAL_AUTH exchange working
>> on an WPA3-Personal Only network, I remain skeptical that any of the Cypress
>> firmwares actually work.
>>
>> Regards,
>> -Denis
> Denis,
>
> I did not attempt a connect with that first log. I misunderstood what
> James was asking for.

You didn't misunderstand :) I was confused by what I thought brcmfmac 
supported but Denis pointed out that the "Device supports SAE with 
AUTHENTICATE command" only mean NL80211_FEATURE_SAE was set, not that 
CMD_AUTHENTICATE is actually supported (really dumb and confusing, I know).

What is interesting though is even in your pcap CMD_EXTERNAL_AUTH isn't 
showing up as a supported command.

     Supported Commands:
         New Interface [7]
         Set Interface [6]
         New Key [11]
         Start AP [15]
         Join IBSS [43]
         Set PMKSA [52]
         Del PMKSA [53]
         Flush PMKSA [54]
         Remain on Channel [55]
         Frame [59]
         Set Wiphy Netns [49]
         Set Channel [65]
         Start Sched Scan [75]
         Start P2P Device [89]
         Connect [46]
         Disconnect [48]
         Crit Protocol Start [98]
         Crit Protocol Stop [99]
         Update Connect Params [122]

So I'm even more confused now. But as Denis said, we do need a iwmon 
pcap of wpa_supplicant working I think to see how its actually 
connecting successfully.

Thanks,

James

>   I tried connecting
> with my Samsung phone and was able to connect so it seems that the AP
> is working and allows a
> connection from my phone.
>
> I tried to connect from the Pi with iwctl:
> https://drive.google.com/file/d/1f1jnD0EUOJSaJXd8l7uYG9nisAxCPeo4/view?usp=drivesdk
>
> I uninstalled iwd, installed wpa_supplicant (built from git) rebooted
> and tried to connect with connman and collected another pcap and it
> did not connect:
> https://drive.google.com/file/d/1zuVSF0xu4Nk2fN9ketBSv1tiquT-Sc-p/view?usp=drivesdk
>
> I then tried from wpa_cli and did not connect. I tried again with a
> wpa_supplicant.conf and also could not connect.
>
> Now I am trying to figure out what I did to allow this connection to a
> sae AP... Now that I have nlmon
> module and iwmon, I will see if I can re-connect, somehow.
> The brcmfmac is such a pain.
> When I get a wpa3/SAE connection, I will make a pcap and post it.
> I actually was able to make one with wpa_supplicant once and actually
> passed data, but it does not seem to work today.
>
> Keith
