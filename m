Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203721CA0D
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576383; cv=none; b=N2DQ9qWf/wUSY0DVR6ThMZMhHgsfS2yrT5+Muf3X5qwX7R6bmqih5PGPd/YVpYbpfg5Bvefr7PRqiLMc558MsFPKFvmow7S0zlgwZHsuOhJjsLovuoEhjbIzFpxY+AkOXqB24Q0dBwdpC01NPrc2GUf1Mpgs6KJCJ4PAvwEladg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576383; c=relaxed/simple;
	bh=Cfes4EpYLHTeYsRAs2KA9F4dcCPDtS66q0n4ifBnhao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itu5+DAnE+oFjeGYF37lc1JiWHQK74evKl9Ws+xOzAaQp1FBKKWjqJr9PkPEMu+7lDy/RvM0h9PR98EoiYlnpYBmtnnvr0vwENc+eG+I0ZyY4MHW9tvbwQSKCdE39ixO6/yyPbOUXJf3DW3ZoDYKHBvrkk9gTk0aCfmwIqdukJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCOjHNc5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCOjHNc5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2210d92292eso50651215ad.1
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 05:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740576381; x=1741181181; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwkP7QCuTx9iC+reXO7XG2W1BEJM3HseNw+GdtAK99g=;
        b=lCOjHNc500CYdAOX/RzzMlKOS7LOFdonKtunYmd2/Bel/LGwU7PXTF9/2h4rI56Xbi
         4rnulfh1lnEoKw4znFdw58cvY3x9G4+/b6d7j/IMKNV3z9Se2UM99Xfg4QnsAI1UXfMe
         skbBXu+X1AX3J0MsnxU0b2iy0+cbD5Hnnv2Gz1TL313HXq4frK3dBHjhf344wwIE6vW2
         ZuIzC0nlZTXrUnBVUFl4VBIEW4RQXQV3M4k8A2CX6Rrvh1RQs1D1VdOLapLXz3cyisk1
         zebpinvT5YZg9wTjuIBpy4EBcwcUHtCn58Q05KijrWEu7LqKfvCAS72eBUycIyuWnhRQ
         SdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576381; x=1741181181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwkP7QCuTx9iC+reXO7XG2W1BEJM3HseNw+GdtAK99g=;
        b=oUhQc8LNdUHhVH6ZHnAVq+hCYETAHJJCTg8A6K88G9fKEiihxeqOQeTwGAgWsztayh
         6AcI3dLvQr19nsBFMc0rQGs9/aMn8UBkn08F0k5J391IYQqGFT4ixvYkkwC+H0jnzLFT
         JCSOQltz5Xu7+KwIt/cLT3tigs5wFJe212rbJpjjMPoLGpSL6SaXTJW5qf7MSCRCQdN5
         umoaXym0vtO48WNLf+HeNfyJdkHsipasapN/O0u3Xrcx6ZywwqwyC2wwJStGM6GBTieh
         n3UmIoQCqkCuru19zwvsKZIlR9tssIcNMFt3Gpd61K720lzzjk42Ao4oG7rRCyxhN3tQ
         nRnw==
X-Gm-Message-State: AOJu0YxluCp0kWVTKFv/BXJHP3btx0GkYTD55bmMnMzAkQzexs48mBvt
	oDq+Guu4nHBnvHWy5xwousM3XlaIjBe39cozXxtvhRTm7ehP6q07QbV/bw==
X-Gm-Gg: ASbGncuGTPjzqMzg8cttjoIJDnBH7p/ynBf7j4BC2csGbWN6Zh1iMghzFSmc6yFAKlJ
	yBt32L7hklYs9PJkuRlpn/4RWfE3aKcwab4CHmhFMSVayLyfHL6ZCBauySiFaaY09HE8GCAEN4v
	AWYxQS3y49o2w0MOkkel1Lrnh8c73DuvhCsRzq9cy9T+WciQW1xOn7BCYfGDTPG1QJJSsJUcsXJ
	7aK+TsKDmHBCN/1uB/A8C+qZxTkTh/nkDutDgCj7EQOOj88K0318AHsDSCiGnrVbSZLZNxiMNaT
	MrnwX0rgfDnT5K9dWdos7dZndXojSg==
X-Google-Smtp-Source: AGHT+IFU1LdRMpGp3LckEVGaM+g2KDO/0TdrZTGfDPAmi5J+HZZjs4c+L2CBuAlhuQ8InSIGV3HHAg==
X-Received: by 2002:a05:6a00:928d:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7348bdd9611mr5461625b3a.14.1740576379792;
        Wed, 26 Feb 2025 05:26:19 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6aba4dsm3385561b3a.8.2025.02.26.05.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:26:19 -0800 (PST)
Message-ID: <d3b96b3b-83b0-4b13-b86d-b11174272922@gmail.com>
Date: Wed, 26 Feb 2025 05:26:17 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EAP-TLS support in AP mode
To: =?UTF-8?Q?Frederik_Br=C3=A6ndstrup?= <frederikbraendstrup@gmail.com>
Cc: iwd@lists.linux.dev
References: <CADs2FCEpXNpdrVOjiRN6i5WG8=HayYRqQ5P-L36dj=zLyYh3ZA@mail.gmail.com>
 <adedcace-ed93-4fff-9927-e58383489abe@gmail.com>
 <CADs2FCFx4Ts5zeftNLshqSOKzQJ057ViVG5od8Luj9TorOt9Cw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADs2FCFx4Ts5zeftNLshqSOKzQJ057ViVG5od8Luj9TorOt9Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/26/25 4:29 AM, Frederik Brændstrup wrote:
> Hello James
>
> Thanks for the clarification. Is it something that's planned, or would
> you consider taking contributions?
No, nothing is really planned per-se. AP mode is still considered 
"experimental" in IWD. It was originally implemented to cover the 
"hotspot" use-case but never really extended more. Of course 
contributions are always welcome!
>
> Best regards
> Frede B.
>
> On Wed, Feb 26, 2025 at 1:08 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Frederik,
>>
>> On 2/26/25 3:49 AM, Frederik Brændstrup wrote:
>>> Hello
>>>
>>> I'm working on a project and would like to know if there's any
>>> existing, or planned, support for EAP-TLS in iwd. I haven't been able
>>> to find any info in the wiki regarding this, as the only page I've
>>> found is https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/ap_mode.html
>>> which only mentions basic WPAPSK
>> At the moment no, AP mode in IWD is PSK only.
>>> Best regards
>>> Frede B.
>>>
