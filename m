Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD828DD1
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvV/mkaa"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5962f7ef806so105988eaf.2
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704392367; x=1704997167; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVFldU2CoFOSyRjdXVrRYsA1wiXud+4BO1XesuVlURg=;
        b=PvV/mkaap9TuFvVg43ls3haCKoNXdKZBjsM22Xf/wgnrHd4NKDS9ogpz4Lwpcwipck
         s/uxWLPwRgJXAzvfgwBp7TsJlbHM/dHD8bYxTX9HBRfdUK+CmOogTlf6qFHXEOJmetv2
         p5DlQvz7TyMtoDqjWjTsmhRzo+6sOqe6kMm/XLqUWO3S7sRqrOFmFTQ9/YKM3MKIqrjY
         yH4GCcOIMaqF81u3LX0vUx7ewbsTZJSFfJq9AMmBYDasJzwV2l3lOzpZvo/0iLd/FEbR
         NBqe0fCFXJwoHdzDfzuxzZ/CFSP6724QJLcm9E2Cu1/KdfaILDorIc1OgfsmxtObDOBu
         gXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392367; x=1704997167;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVFldU2CoFOSyRjdXVrRYsA1wiXud+4BO1XesuVlURg=;
        b=MzijF2v9fxFRUtym23YPgkiOnYeffo0szb3NI+AE9qvUaXy5RtB9TWz06J27dYrVLS
         4JhfmsIuj8b9X9aF2u1P9BRWHbgHVYiLrCM12sLV/nSfVAkdjluHxP7Ult57x6j6aqEy
         ilWaLfBUHenXgfaSKQznm1FzCbB0i6gswXZZxa1l87PSRC8qXCqPTgxIl3oE1N0iEdpT
         qyBFmFHb8/e7auL2UzKSGchzwodcJiG+r9BaPAN207jasm1NmhYf8Iv5WD6PmK7EFGfr
         1PSpIWKMbi3zhK1ld7+oBQgGNwyMoednaf/T0haU9bHAk0pEmrnDlOPMEqbRN50ij3rZ
         rRkw==
X-Gm-Message-State: AOJu0YwDxzDP9/rekjqxD+PPAun41yYKiNgQFIYJTZZlhxnvmg3TcMs4
	tD+sWrvKBNnAKKgo/wZQPNKQinMpjOg=
X-Google-Smtp-Source: AGHT+IHAnbuu9ED4j0Z5KOeUWoTijdaSjWLXLm+epzYjkKflRvV78Nitut/qMU3RI25OyqJSP7H5TQ==
X-Received: by 2002:a4a:9293:0:b0:595:fcd8:52c5 with SMTP id i19-20020a4a9293000000b00595fcd852c5mr888007ooh.9.1704392367201;
        Thu, 04 Jan 2024 10:19:27 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id o185-20020a4a44c2000000b005954c783f46sm2188877ooa.20.2024.01.04.10.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:19:27 -0800 (PST)
Message-ID: <03cebb28-c1f1-4018-b240-502478893fd6@gmail.com>
Date: Thu, 4 Jan 2024 12:19:26 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] client: fix AP PairwiseCiphers parsing
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240104160030.614736-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240104160030.614736-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/4/24 10:00, James Prestwood wrote:
> This property was being parsed as "s" when it should be "as". This
> results in "ap <wlan> show" having an empty entry for the
> PairwiseCiphers list.
> ---
>   client/ap.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

