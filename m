Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090C6ADB
	for <iwd@lists.linux.dev>; Mon, 24 Oct 2022 22:27:04 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13ae8117023so13518320fac.9
        for <iwd@lists.linux.dev>; Mon, 24 Oct 2022 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdVMm4UcnlwjJtdoxGZd2EsKAY/Jn5kOBnxZ3zYQVqI=;
        b=jlTOtTUueNKccugriyOm9gOrE9f9BySWWf5T44P/tQADozMtW4/Ckfqe2x9N5DlRZA
         I+OSiBmioyANpPjB9nAjmNNEReBbAIPwv+KzJ2Z2DDhJPAMm9gaMA5CgHPIHRpEsrEgn
         LCVfUKmHjU0PcObUjJi1KKLpnPxqerUkDHSqWhO3K5q3MYcPNhV/SjRf8uGXWqY0NIJX
         AvCLHUPb7g8Skj5XUHUSSPdtHSPeXGc6X2TVxNMZ7qmKBZTf3OUrq56dIR+sGqH0yCon
         cCfLptFuBRyKLn0lfsxACwruJAnsVI6UH1mGj0h4z83jViXByU3/Y4qCfQFYUzwNVehV
         QIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdVMm4UcnlwjJtdoxGZd2EsKAY/Jn5kOBnxZ3zYQVqI=;
        b=1YKuywBbgKnUvrfEXny1ZMe/cjyeffKp1iZBBqz4MlaA9ZBUhNY4drpouAPHqefpwU
         1Dm3V/W5X1MB9gTKiwrrsinx5COduOnwFJ/aK9SpHrhxz7cLsPDE5k7F+Ve+BG5UiiW/
         0rwYtCqy7smXQh9CfaswBGS8QFUsZnU16uu9z1IgdI2c3+aA0JxoUjeFo5iYWeXYevxE
         rGqD4l0S0+q1RuECig3hcd9F4YJjZ84shabN2E/UlafvwIG2gXqjF/FMbfhCCyetzald
         aBU0ns2MT2MmlRQUk4nRG33JViBroe8DQS0eB61yn2dwITP6ACLfNY48EjRBJsxfdBC7
         yDRA==
X-Gm-Message-State: ACrzQf1UltUjv5xUDzsFGvUwJdWEm4oW3wqiShnIeXkIqLhbjcgDtyW7
	H3JsyRuvxVskTAG0hyCSUKQ=
X-Google-Smtp-Source: AMsMyM7pHYVIirStWCHHZnoh7jnhLu9mEnxE3lyN2FAtktIQQ7ykJC5tFeYEFFKxzjQcympApoMbwg==
X-Received: by 2002:a05:6870:b4a8:b0:132:21a3:f71e with SMTP id y40-20020a056870b4a800b0013221a3f71emr39115907oap.266.1666650424183;
        Mon, 24 Oct 2022 15:27:04 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d2-20020a9d4f02000000b00663d087dd36sm321164otl.23.2022.10.24.15.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:27:03 -0700 (PDT)
Message-ID: <f059b416-ee48-fbf7-88ba-30a2791df935@gmail.com>
Date: Mon, 24 Oct 2022 17:26:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ap: disallow TKIP and 'use group cipher'
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221024204710.163107-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221024204710.163107-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/24/22 15:47, James Prestwood wrote:
> The EAPoL SM does not support either of these ciphers when acting
> as an authenticator since ARC4 encryption is not implemented.
> (see eapol_encrypt_key_data() for key descriptor version 1)
> 
> This can cause 4-way failures if e.g. the hardware only supports
> TKIP. Rather than fail the 4-way its better to not even start the
> AP and return NotSupported.
> ---
>   src/ap.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 

Well, I have a patch pending that limits the ciphers to TKIP or CCMP since P2P 
only works with those.  No sense in choosing GCMP, CCMP-256, etc yet.  So we can 
implement the missing bits in eapol_encrypt_key_data, or simply check whether 
CCMP is supported and only use that.

Regards,
-Denis
