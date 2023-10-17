Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44634368F
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0AZPl0a"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c4fc2ce697so4051313a34.0
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555953; x=1698160753; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTSUBBtD6Fqc/CwwW6XzH7BdKuH2DC9uEqus98+1EPI=;
        b=e0AZPl0aCliAxZf4vPxo9yUgeJWpbmibDaFfluChginTZw1U8e8NNF3GsWvPCk7u1O
         l6rxU+iz4FfXE014kY+WQxqD3SczjRXS6/MUtz3dhzOUBTZtw+NlR8NKVmXeuIsZ26yV
         ByTkvBDk6Fv7mfreBodvE9txkeNr8pOjc7BggUCU8dGISzfu/iyFpjktgPAft6xb/UxU
         7ZJLooKAF5qiVVgquSCFxw2lRhfmL3IYPpILwiOKn34G8IoqQeTfl+bERRD+DNe+uzNb
         GTNeXqpaJUngumXoZWqlCwO3CG/rQ/xRi+WztQ0pW2MODzkR2Rga2/aZ3dc/3kZ5mb8U
         gxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555953; x=1698160753;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTSUBBtD6Fqc/CwwW6XzH7BdKuH2DC9uEqus98+1EPI=;
        b=W2vl+GbCyrcZ08gAtZjj2IB2FzvYW1fpRnBrKW2oCAP20Lgc74iigzgAoS5b6j6d+U
         R6jFay/+muNJrkj92JvbU4SbPVLahE7NbDGa86RIgILgmNGxBFyTL9ioTceBK8dH8s8h
         Cr+3RRuB9svxO1zYRd9zmRl6GSSo43dxpKPg66DQbDPNJAq4Grk2dKh4DXQPW/qV0c4V
         CdMPFHvvs4BD7na3FMKueJRr6DXQGuCaqKtGjrCOXLwDOLUiPXJuR91Aq2IkPtmmU3XM
         uCxeeXLooBuEmQA21XeYzZMOcAd6S/GO/ghBbnr2tZyCIrNNSCOdBqr2k5wXMT6H/uSc
         pnsQ==
X-Gm-Message-State: AOJu0YwC9lV1qodZ1nWVRKORGD0wlfSfKa8SPu3hGIOcb0sJC/bZTaok
	8HiPaCwnVY/frCL9r6lehbO6/cYZy9E=
X-Google-Smtp-Source: AGHT+IECPToUyBy5zqa2Dew8QjCyYrwOQ6SVuvGcYDQpAstr3jFMIalLmLlqbEJsQ/e9fTsRbWEw2w==
X-Received: by 2002:a05:6830:3146:b0:6b8:9a3a:ea12 with SMTP id c6-20020a056830314600b006b89a3aea12mr2856299ots.12.1697555953700;
        Tue, 17 Oct 2023 08:19:13 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a9-20020a9d3e09000000b006c4727812fdsm294070otd.15.2023.10.17.08.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:19:13 -0700 (PDT)
Message-ID: <d469a933-694b-4382-a744-9abc00e478e7@gmail.com>
Date: Tue, 17 Oct 2023 10:19:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] dpp-util: fix typo "COMMIT_REVEAP_RESPONSE"
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> ---
>   src/dpp-util.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

