Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C563222
	for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 18:07:52 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6a5febde157so673080a34.3
        for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682878071; x=1685470071;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26gTyhDFxmLmcoIonHV0gg7iT57UV/0oj0E3Uon6Ahk=;
        b=Fdyn3SzDUDW4BFdjyGO2EaT5UYjXkBJrAaQ/tNc16DSsU1d/r4lWpZKWDlIveng1iJ
         rPn6rQ20W4mt5cbE4PXoEmidiEtJYn84QRlZrYPTqEMR1FI0LysPVe32W9kyTIRX1QsH
         pariS29llKFbOrB15jPVQBKGMc/mtVagSpt0jkgrYMZsEt/+1jm7bLE/qUW0wFsl0ueM
         P/EadEuem0d/0ZGZ2JuMVHn6evspbFhvhoEfgBDmK8/vVg9ZkorRC3ulGKl2AETqthXC
         DYMg/BS4bPkr8bbW6hotmhtRy4chbDjDzBaOq7BfMPVgnczC9PPApsmVJodYa+sKXZTv
         j7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682878071; x=1685470071;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26gTyhDFxmLmcoIonHV0gg7iT57UV/0oj0E3Uon6Ahk=;
        b=Rgv7OvL/bQtxaDXFEePP/j3wTq3/RiBqm+z5XqNXOl2CkCcIxpWJxz7wXicmogy8DN
         9q4cZbSipeWvh9GgN0a0nyUUQIwoy5T3uTOjn0z/gKXHXFfwihCV8BW3kH87kSELQcRi
         1OphC2UOPGIubMj/msyLL3rQ8b4HlSmewx4ZKSWTj/2tHar+65uspSrZjx4w4U1bwEqU
         R3+WJlUORfOwsmWgF0srhNL57Mhym15lPGwNlq32NfaaTsGKFJKIevUbpOPCFlqK9nef
         4HxrimGBMdqNjVuvvTpO/2s7Nzna5doo+BfxNKcD5Ur7YrgXuyi4O+AV9MnaerGPF17M
         8pWw==
X-Gm-Message-State: AC+VfDzC1fTJ0q7rvi7sdv6cB5nwV2xbNw0Oqa+G1V/Z3UWzslyZntDb
	W9FBiRZbZIOZ6ptstYed+vMNwzR/aVeZkA==
X-Google-Smtp-Source: ACHHUZ4dez5HrN4kPalHe3YtLj0dTM0LBb25Ck7EHs7+5j6q079WoEs42zQTr3K7UlVIVGb9GgpElg==
X-Received: by 2002:a9d:6b98:0:b0:6a5:f147:5255 with SMTP id b24-20020a9d6b98000000b006a5f1475255mr6456202otq.6.1682878071419;
        Sun, 30 Apr 2023 11:07:51 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g24-20020a056830161800b006a205a8d5bdsm10807738otr.45.2023.04.30.11.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 11:07:50 -0700 (PDT)
Message-ID: <ef0d61cf-5b09-f18e-d5e7-b6eb446acac4@gmail.com>
Date: Sun, 30 Apr 2023 13:04:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dpp: fix incorrect offchannel usage as configurator
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230425205700.36822-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230425205700.36822-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/25/23 15:57, James Prestwood wrote:
> When acting as a configurator the enrollee can start on a different
> channel than IWD is connected to. IWD will begin the auth process
> on this channel but tell the enrollee to transition to the current
> channel after the auth request. Since a configurator must be
> connected (a requirement IWD enforces) we can assume a channel
> transition will always be to the currently connected channel. This
> allows us to simply cancel the offchannel request and wait for a
> response (rather than start another offchannel).
> 
> Doing this improves the DPP performance and reduces the potential
> for a lost frame during the channel transition.
> 
> This patch also addresses the comment that we should wait for the
> auth request ACK before canceling the offchannel. Now a flag is
> set and IWD will cancel the offchannel once the ACK is received.
> ---
>   src/dpp.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 

I re-flowed the logic in this patch a little bit (dpp_mlme_notify).  Please 
check that you agree / I didn't screw anything up.

Applied, thanks.

Regards,
-Denis

