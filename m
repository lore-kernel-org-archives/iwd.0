Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594037B97
	for <iwd@lists.linux.dev>; Tue,  6 Jun 2023 15:46:24 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1a2b4b922d5so2418064fac.0
        for <iwd@lists.linux.dev>; Tue, 06 Jun 2023 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686066383; x=1688658383;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/swxzAIhMTtK/EY0/z9ZeYu33+BAh8PAW9NJY8kG8tw=;
        b=dO9aQdblwbBULJpLMb3V0lIO6eUPfT46DGoVjeNGQK4Zw3sFC6yLvAuq4Bj6Nl/MO6
         0qb6oAB+Arkzyc9BdnmMNxegPhnH49YsGf/2PmvMvNCbJboq4stGu7x0QexBvMdl0/rC
         TxYMjo7yilYIqGriueB57OURaxf7ZmcNR7TEDEtz0KOI0Zql2bkRKeNWGYRdVEY5unkX
         A1uXyZsP2I3//zMk5Xg7LRTloD75Wa4TgH+71eBPWrMlSkjdSy9p+wyL8el0tv+1C5K8
         ZSu5OZk06E1VpD6JcqUOSLtHgNGQvKyEjEMCrvul7XOKZ7AeIczJ5GbYsHeUh0jhNKQh
         jFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066383; x=1688658383;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/swxzAIhMTtK/EY0/z9ZeYu33+BAh8PAW9NJY8kG8tw=;
        b=IvFPOGB0TZqBf4FrzMJ2DZMhMzJf7PFyyYDiplH9lGyBevLhk3YRrwI3bD0nm35W5r
         YONP2kGkSIB5lU9JIniSPCXJw1Da5cWyqK4Bh4nxg87/7IavOu3RmbIl29srW0tv5TNv
         ao4Ci4cNlZdYi+Kiz2qTTPEGrDcypLlM/g+yZIPthZo+gaDjzonzNM5rl9DNSAKVPpg4
         8LJNrxVCMOlS6HeBgfVfH9Tpj4ZD0DRp4A0iMOji6rKeBuOGm4OfCd+rJO0EHcu8e2H8
         irzapVxiebNEpztt67xI/pyhoYfmj8Xnq5eXFPCcAdxg6rgcJXZtrwaBnW5JyB43jvhX
         8XWA==
X-Gm-Message-State: AC+VfDwfUayc1vNdQ6XhbMkjRKoiIjUTaU7RhBp9+m0Sg3mvRvokgvj0
	hAXbYeaFRv7ogFnQ4vm4+fHo1Es1cJU=
X-Google-Smtp-Source: ACHHUZ52TXUc4mPyp2g6eknGk4cNOacaA/aYRhd8eHxzODI8hr3qW/grBfafKO5UOstlnmvjgLuVtA==
X-Received: by 2002:a05:6808:8fc:b0:39b:cac:7207 with SMTP id d28-20020a05680808fc00b0039b0cac7207mr1869707oic.4.1686066383562;
        Tue, 06 Jun 2023 08:46:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bn15-20020a056820180f00b005559f182cd6sm4317424oob.12.2023.06.06.08.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:46:22 -0700 (PDT)
Message-ID: <5a290730-f50b-cb27-e488-3ed605aa831a@gmail.com>
Date: Tue, 6 Jun 2023 10:40:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ap: Remove opt-out DisableHT for opt-in EnableHT
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230602145812.22010-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230602145812.22010-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> This deserves further investigation but its looking like more
> often than not users need to add DisableHT. This isn't so bad
> for AP profiles since the user has to create a profile anyways,
> but for the Start command its best if it "just works". To error
> on the side of caution DisableHT is being renamed to EnableHT
> making it opt-in rather than opt-out.

Our philosophy has always been to have the user perform the least amount of work 
for the best possible result.  Most modern hardware should support HT these 
days, so the 'just works' approach is to enable HT whenever possible and not 
make it 'opt-in'.  The current settings naming is just fine in my opinion.

The ideal solution to the above problem would be to figure out why HT isn't 
working on certain drivers and fix that.

If not possible, the next best approach would be to create a list of drivers we 
know do not work (or vice-versa) and do not attempt HT on the problematic ones 
and print a warning to the log.

Do we know which drivers don't work by the way?  I might take a look when / if I 
have time.

Regards,
-Denis
