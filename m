Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1343AB3
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGxwciSQ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3afc38cbdbcso2979275b6e.1
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556686; x=1698161486; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKVgzDCbb33XPvIluRBG00DnPYgG6qggmSTCUII9dUc=;
        b=NGxwciSQzW8fGSJR8j7AD/OvVocvL3qXBjEXLYHSf7Bsr8FOY5Dho46Xip8oCvRwia
         2k4YqcKNP9994noLZswR9YTBQrcBGtRKyYsb177A5UW2u5OhkgYFYagV453pn+ijfbij
         HV/sagyy0BI4Fg6Y9erlmlYT+7xHolE/w9PQfXh6Az/VoC8ZHK0zDTy+R5O3LtMCaVtl
         vLBGiP9fmB8rI/s8JmGcDm16gGcUm08OuKr4uhC8HJ33omu69HXLZ8ivG2FaAjK1hhEW
         xMYxFnNz2VlyYCJdVwpA8TKgoeDV4meR+Z6VZZH9JBbfhZTf4J62SEzW40/8L6MzzI9U
         eDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556686; x=1698161486;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKVgzDCbb33XPvIluRBG00DnPYgG6qggmSTCUII9dUc=;
        b=kJBnGP3StBryDC8N5o7tU3GAI1d7LaKmCTDqgMNNscY2xNZodNwihSFjUbu4tZ9WyJ
         T0n/hp+sKHX3kUn7uRhVHiG5ESFmyjUtyL/4CUkHXyKFfHyB3Me6r2Jcn8zcSdNTrR1M
         SlINJVf0xXobvbT9+jPk+QaXeG5SJ02jYjNghANOwgFu/KErvHQT8ckiO+Z7vbB+VSUB
         dBPnCXFqD8H6SD3schcAQ1fyVLUWylcYqBbWcontwbRqrp24AMabcfFvcPMT5Fgr12Af
         gVWZNJAXGuHdU6iEr7JwwWdXXl0cPv0oclUv3h5ESm2eLa18vz1tlQJi7vyNoLJlAqXa
         pXeQ==
X-Gm-Message-State: AOJu0Yx34THdnQ0Cg+SMvOdUpJYNf5mnPQ1qqNhHyQnzUHmXl5kN/ZPj
	oBWR/fVmDFFd5lUrp6DXSyU=
X-Google-Smtp-Source: AGHT+IHVlTwIW6rTX0WX2CkgzUdSuMrKoNLFSmTeI0o1f9DSiiHWBvnkYKVj+tO/OAb6q6UTjOV0cg==
X-Received: by 2002:a05:6808:b0a:b0:3ab:688f:f8f6 with SMTP id s10-20020a0568080b0a00b003ab688ff8f6mr1083568oij.24.1697556685801;
        Tue, 17 Oct 2023 08:31:25 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z21-20020a056808049500b003ae11a7ab80sm292394oid.47.2023.10.17.08.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:31:25 -0700 (PDT)
Message-ID: <6bbfd6ca-0e0c-458f-925c-c353547a4a32@gmail.com>
Date: Tue, 17 Oct 2023 10:31:24 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] dpp: rename dpp_presence_timeout to be generic
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> PKEX will utilize the same offchannel timeout, so rename to
> dpp_offchannel_timeout to be more generic.
> ---
>   src/dpp.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

Regards,
-Denis

