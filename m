Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00D1991B0
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537323; cv=none; b=XzjkEjKMaqfKZPptT2mER0+7c2Z7UECHQRT5i14ZyAkHBdl4C/KBAF3wQD+2QB33vZk7o0TTqhSpF4rwpQtRoZXHD1GFmYZLBN2OUU6IW2+PrdwyRah3gtINzz+TvHUa+cfZLJN0wg+ZtcyIpEo3EESn2v49n8V+/cQv+o9IrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537323; c=relaxed/simple;
	bh=8RX5iIVBKhIBMO9TX38EbsmaLO9W385rTW8YYqetu30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=he3G/RsqMkLDbLj0l9LZshmEGR9ilr3Ct88uE3B/chOqqL1QUaYlL6P2+YxuKk2hUY+D7ZlibfbP1X8nIS7jtM2zG+0IVnF+1AEel9/+iRf4dNwt/8t5N59mAMovxSJvCN94SFsPREQyrZIyc2geTJTl839bHnUKbWhOUgoricc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kasf9CpV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kasf9CpV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a8160a7239so44072185a.3
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725537321; x=1726142121; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UekhmUKCv2GMk0ed+CLDwYVtDw2y+Pib3IXdhyDFO4=;
        b=kasf9CpV0+D5Ssn+yjBoBxD/OaOdXb7q/ky4NoFGDcWnwaoBglghMNb957oicVDpU1
         82spMercYzRuD5gZ5yFsQZGCUYCmwpVijJuMRhLATbVWcUCi1fYNwbzmjgxl1faYQc5t
         A0S5QKCML0APog0HcKhSQ58tRUej8drYRbgd50wr9lVivPwehBITM+kWg3+ITaNjrYhv
         PjDSuOBWI4j6N1IctYYBz8xNLUm5hymvju1yBmgNs3v4RM34cLJO78GNiknNubPSQPqk
         u7EYbTDfnpUTBpnLf52LGQ5/VQYFhbsKEbluLtvl9FiB5CklRT6+vldl+beHPatRO2pw
         qa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725537321; x=1726142121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UekhmUKCv2GMk0ed+CLDwYVtDw2y+Pib3IXdhyDFO4=;
        b=ngWwS6WnBiIQ0xfwC4wmEwhQIGqyj4dWSRrBqKP2spZkLy/CPhErJKg9yPbSOKZ/ul
         2QNTpGN/D2K1xHyE+JMvter7gWFSeiFq7PX5VjxmTOj9HF00OgUrhPnyFr81C5yAO+rD
         GRLf5V7EIVuBzZRSXULtq1Og9xAUHi9FyKn9tMgiYA2uoInWZ7NDneirRxsQcAJATXpn
         z3EQE3d3vcZFHjg7kDNFtG4gMNYSviwX8nQqbIW+sHikAv+AFVWVnLPwItsWCMimnieG
         2valMwJPK1Q9AdoQJskOsI5EYlqFHO8Qb/grpfEblxSK/EzXtzjG9hd3mlKMYmbS+xpj
         SSuw==
X-Gm-Message-State: AOJu0YzVrRZMijkYfJeFn7m3nlltdSVUnt19Elvuhu1TR7J5z5wb5Wkk
	f+RoKG8beQbKmBvonZZ8PCpoYChNgL41PzicCO8V4OH49/v6tH2pLtV6xQ==
X-Google-Smtp-Source: AGHT+IE8ugblFB3VNiu9jehWdUKgYNOBBw18b1zSmrc4Sx7QvHKyD3vOR8YijFEnLmTwVwQwaB11Qw==
X-Received: by 2002:a05:620a:1909:b0:79f:1873:5463 with SMTP id af79cd13be357-7a80418699dmr2742217485a.6.1725537320804;
        Thu, 05 Sep 2024 04:55:20 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef4d588sm68299785a.62.2024.09.05.04.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 04:55:20 -0700 (PDT)
Message-ID: <8eb5e60f-19ec-4ec7-8175-600f077d5a2d@gmail.com>
Date: Thu, 5 Sep 2024 04:55:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: Denis Kenzior <denkenz@gmail.com>, Daniel Bond <danielbondno@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
 <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
 <7b6f85d6-136f-4b4e-9b67-f71879191cd1@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7b6f85d6-136f-4b4e-9b67-f71879191cd1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/4/24 8:23 PM, Denis Kenzior wrote:
> Hi James,
>
>>>
>>> The issue seems to be resolved by checking that results->sr is set:
>>>
>>> - if (!results->sr->canceled)
>>> + if (results->sr && !results->sr->canceled)
>> The patch on the arch issue report looks good to me. Can we go ahead 
>> and just send that patch with git send-email?
>
> Why is results->sr NULL?
>
> Is it caused by the cancellation path introduced by:
> 64d68b4f080c ("scan: fix invalid read when canceling an ongoing scan")
> ?
>
> Or is this caused by calling scan_get_results with a NULL sr like in 
> scan_notify()?  If sr is NULL, perhaps we shouldn't be invoking the 
> survey path in the first place?
I'm looking more into this. Its related to an external scan which I can 
now reproduce if I just remove my network profile and let IWD periodic 
scan then issue an external one. Worse though is I see more invalid 
reads related to the survey code path (when periodic scanning) so there 
is more to it than I originally thought.
>
> Regards,
> -Denis
