Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B33C16
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMYe4DOn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7789cc5c8ccso91508685a.0
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939672; x=1699544472; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dTuN9UoXhUtAsvejQ/zCjcu534ZcztNN7k4iq+2bDY=;
        b=XMYe4DOnOUuxtoG7Gnh3ZuKtES/MOXMKIaOuaWF+5OYhtLzL5+dLzIc8HQtHQ6ytqD
         ciSsupFiG54JhorrhO2/XLPEDtYuUrOHAvHmE2x1f3qeQoLHMtJSldl9+HJa4Q2Miamy
         hJgNsWuQ5wfn2vr3F3zR0Ks4Tn/PSSoX27CRxuWWQv2NTVCBdNZPhTCzej7D6fE889FH
         1/dkAPDQVKo0tgsYDaeRhRU9RPjA1NxPIW8OXdxdHM/5cafNXOrrTRWzk37f6WIrkysh
         x2zwjBwF9/HySlSYEnJIiShO5zutbUXtZ+NCo1OPGLm9tvtiWI91XKypC09Lu/gQC8MZ
         TFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939672; x=1699544472;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dTuN9UoXhUtAsvejQ/zCjcu534ZcztNN7k4iq+2bDY=;
        b=lW+GIffvnk29SVWCKjeIkLoA8GWX70bfwcwvh6vDqLXWJp8wyBCfiOAWJ/wNIJIUTK
         LP7VNQvAr0o48INW+QLx4fDswRZD2Ds7yj1qKos4SZJzWKDNpu50WdVbI2phpq/oDAUd
         6SGa0hKey7DGId91E+mk9c+XKuRkpmrplFSqc1MPdvOLUtCwJWVbcccxS9m8XoXRJXIF
         PEs3m+k1QEJIUe6cV2mdPv2mgZLv5Xq8AoU1OfurdsN8zaYjvfcPolBKhivlPcB23fr1
         iFomqAxXqwJ+cCgbbF6o4mzgB97I9sOBqsm5DNcUHgHXqsYMvE4YXhr0n0cLuqeiRZN1
         9GZw==
X-Gm-Message-State: AOJu0Ywzec08IV1a/b6tPSSAT5U/87yyFLE5GZlPrMdNeJWY79rkKUla
	VqCFMpgCgqqJU2aCRmLmeTn+JhX/o70=
X-Google-Smtp-Source: AGHT+IG6cYA+8pJupuj3cEChxSdNN9NtxjmKlFZWWgOBuloEKl8J1/Iihso0ZAdqNvcdcg8xYc0DeA==
X-Received: by 2002:a05:620a:4612:b0:778:a656:e352 with SMTP id br18-20020a05620a461200b00778a656e352mr332415qkb.11.1698939672479;
        Thu, 02 Nov 2023 08:41:12 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a158e00b0076cc0a6e127sm33092qkk.116.2023.11.02.08.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 08:41:12 -0700 (PDT)
Message-ID: <99451a2d-7b3d-4927-a733-a86e58c81a4d@gmail.com>
Date: Thu, 2 Nov 2023 08:41:09 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
 <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
 <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
 <424127a9-af47-4a15-91f1-ff97e7ceacc8@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <424127a9-af47-4a15-91f1-ff97e7ceacc8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

>>
>> In theory only 5:
>> known_freq_set = known_networks_get_recent_frequencies(5);
>>
> 
> No, that picks the top 5 most recently used networks.  The known 
> frequencies for each of the top 5 are added to the quick scan.  This 
> works okay most of the time, but we do not rotate out known frequencies, 
> so if you have a network with lots of APs spread out over the spectrum, 
> it might end up scanning quite a bit.

Ah, that is exactly the problem then.

I wonder if we should be limiting both known networks and frequencies in 
those networks. We do push new frequencies in order that they are added 
so it may be nice to just pick the first 5 or so in the queue. Then we'd 
be capping 25 frequencies at most instead of the whole spectrum in the 
worst case.

> 
> Regards,
> -Denis
