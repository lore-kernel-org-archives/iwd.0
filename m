Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D01A5B1
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 19:48:38 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c4cbab83aaso5799872a34.1
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844117; x=1696448917; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJRJtPjmRFya0DWSUsr95f5MSaJNZbhpSAOkvWvDWpo=;
        b=R9cgr4sWVaRPAHCkTp2bvT70BA6gvj/R6lRkxCRFVIL5xsH/0GKuwYKDFWBMGGmZbd
         442ZTwTpwDDq8SLKF9Mt36g+SZVHITETLJuY/53iBDtF7ifxkMG7p0anPgdSq5Nyr47K
         ksC46BGHopd9nCA16KJVwvs05A0HEm+QIzMAuX+qIdc4k597cCbj6LD059a4Cd4Oy0Yn
         GRNrvKo1yzbc1WFqTl9cL/LURaX2Gv2LYwCgD+S5inr9t5gZTbeXQzMpN5YHJua0dem3
         LCeqcOMh3rT38c7Ylb0Jmk5MEYmu9SzhesSdSKLyia4V1U3wHfgmUq0p5ZgHLkfQ/6kL
         iK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844117; x=1696448917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJRJtPjmRFya0DWSUsr95f5MSaJNZbhpSAOkvWvDWpo=;
        b=oMT7Qcd2WtfDyHLZ0T6zLxlSzw3S2VFXIqJ1f4iHzUsQ/gMxgpaQOjRpgjyJzJ5a+/
         /OiRORRKWlAuZMb7SpfU0PNId047dFRI2ti+cK7K78NO5xhpGpruKa2FtSomyKPcVeTU
         DPp2/IyW3yzpFMV0B8hE5IitMf3Acz+PzfzsCH0TyJNd0O+yufGX996BHzsXtI1cUsm1
         pwvt2LCrp5CmdJkx4AUps4gZ9LFW0ZkeJYkv3UCXlAsm39UjpSWmVTdXLS07yXVpmp1W
         gCpkLaR+Qv9h2xoN+5g17Un94n4ddVepg0ok8ZdFURS3Cu8ZzQP36mj5kyRjhiDogDzn
         m7aw==
X-Gm-Message-State: AOJu0Yy+VaCzzsEvHlLWplkcPFosEVq/FQJMYLJ1JlmvscI8djLBtmTx
	sDxOKIINKdzDHLtv2QkWvSs=
X-Google-Smtp-Source: AGHT+IF9A3N4jw1psAviNXeNQOcz8zWb+Tr6ZSTleW3zo8vm4Xft1xZ8U08AAW061gIUoogr0zZjCg==
X-Received: by 2002:a05:6830:454:b0:6bc:9078:81c8 with SMTP id d20-20020a056830045400b006bc907881c8mr3152344otc.20.1695844117255;
        Wed, 27 Sep 2023 12:48:37 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q143-20020a4a3395000000b00541fbbbcd31sm1511194ooq.5.2023.09.27.12.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 12:48:36 -0700 (PDT)
Message-ID: <74bb681f-b374-f535-1697-64b7dbe804a3@gmail.com>
Date: Wed, 27 Sep 2023 14:48:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] scan: add [Rank].BandModifier2_4Ghz
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/25/23 13:54, James Prestwood wrote:
> Similar to the 5/6Ghz options, allow modifying the rank for 2.4Ghz
> scan results.
> ---
>   src/scan.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Patches 1-4 applied, thanks.

Regards,
-Denis

