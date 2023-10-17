Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278E43AB3
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH5jJbiv"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57be3d8e738so3322838eaf.1
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556963; x=1698161763; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hystojbakhmpHLOK60Up9yWA59oI80fLBLAi+SgQ/7s=;
        b=WH5jJbivaW2FfpvUvDwvqjg1sUrNA9F6LSSqbc8v1rATQMBK6sfOLHKoV+adA4F5Tf
         y3sOgINEXY7Nr7knBMAXLdKQHNqhZHpsqkTK1H1VPy1N09Iow3b681o3Izfyl6HX7oNg
         BZO4XWP+r+BNazltTXE90D5ywTsfFxSJtZpGs6BuLVP8jxJYUl8aoLSVJxB0oDjleKD1
         axv41JcjBmDLUpQ1QTwgZL3/iuOUT/Tg4FCkvg70Oa92SxzktyOY0s0X0QvnaszFa4KO
         ng0NzrfDwlsh+cK4v5g1Z6Ned1ULq0QL+vVIQAfdllaoMDSSfqTxDqU97oUnW3dhZ6f2
         IaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556963; x=1698161763;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hystojbakhmpHLOK60Up9yWA59oI80fLBLAi+SgQ/7s=;
        b=Lkxd02fNTMep98IhX945JgapMBSII439yHZ/CB5GvZZ37TyloIZ4wjezOWblCalA4B
         7jWyPB2WLNrBG+Y+FpZ0SrDhDkT0hAo4Agtf3M6hlPhbQBqQD1yrxUL81d00UO2P6hnU
         QevOM4SfM3RN4Pz5GDZZK0tcyYxQCbmjlsmqctNEkfXzbnednQVRjoOyASq3YWolAW8U
         L93zjQiSIGwQD01Ajpbg5//6hZuveT2Loge+RCKnoeYEC6BwNU3klY5M4ADBK3R3x6Jg
         IKdKBVbIgrQy30LO5r17a6IJCGQLrxws6r9+c6kiHz6qk5MRgpbWqEuaeLa0Fu+qzADE
         Ay0g==
X-Gm-Message-State: AOJu0YwBAjWX8OGC9hcwnytbO3J8SiTWIvbbUoSlL57BIGEZA2xunNOx
	Ga+lYqCTe35Q4nUqnvYBNfoo0PJ3eTM=
X-Google-Smtp-Source: AGHT+IEvXtrEr0E+HuofVzjC5LufL/Dtw+1W1yHaRZAzsSkYFaG8FuzYRQcSL2eih32TSM7F4eHwsQ==
X-Received: by 2002:a4a:b1c4:0:b0:581:eef8:131f with SMTP id j4-20020a4ab1c4000000b00581eef8131fmr152732ooo.1.1697556962804;
        Tue, 17 Oct 2023 08:36:02 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i2-20020a4ad682000000b005658aed310bsm287700oot.15.2023.10.17.08.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:36:02 -0700 (PDT)
Message-ID: <77378ac9-ab33-437b-910d-5441b0332ea0@gmail.com>
Date: Tue, 17 Oct 2023 10:36:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] dpp: fix retransmits if on operating channel
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> DPP configurators are running the majority of the protocol on the
> current operating channel, meaning no ROC work. The retry logic
> was bailing out if !dpp->roc_started with the assumption that DPP
> was in between requesting offchannel work and it actually starting.
> For configurators, this may not be the case. The offchannel ID also
> needs to be checked, and if no work is scheduled we can send the
> frame.
> ---
>   src/dpp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

