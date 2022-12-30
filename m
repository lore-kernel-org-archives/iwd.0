Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984C2F34
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 18:06:33 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso13488070ott.10
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6TKLhppGN5AbTUzUkj0/3S4MqAmwj52PWlGtyqkFFQ=;
        b=KsJu7GhQp3dIid8uu56+9IsR/2gPK1hQgUqlfUVOHGqy4xglrre1iL0yxCiGJuUq32
         wBy0yDQoVnxuYpWyuCgH797zbWrRhv/kdp3sCIgJeeXa1NH30QCD9Q4UPahe2tDFzEUb
         YQEDe/TUJq8sqr/KKOgvrwzwXEZ4dRHGcPlsyZEOCQrxjptT3BBHsXDN+cQ8cUV7UqPx
         B1K8hSMgr+v0alhGMpF2isJBNKGERxZyNGJJrqtY5gQDaf4+7nz2Hh2K9STnI7SYanpn
         AgE8yf8cjHoykW7Drt3uKZTKV5FBmsm7aHvsomusnZMxMsWyvbWiLsr95IREhWAUjdwY
         WlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6TKLhppGN5AbTUzUkj0/3S4MqAmwj52PWlGtyqkFFQ=;
        b=ip8mFzAkL5IEypqCE+5Gp52bj/gNRht34wHGtccAfUnkiQYCx+XB/W5fhv8l1UBm4o
         TUzHIzHlAdQMx6J3RJFXM95Vy0UfBig19ghq4YR1v/g5mFK/3y6cTYPcmnJAlNXYtoK+
         F+MmVFnieqhCJDWibHA9BkVGHmuKl7dDMhSdptL2Rjwd+eumLaGtOIRkpTSGDxh5hwaS
         H4zZpjKjWbbHODN3xIlsnJJ8OxVQ6AvwyRmzCmoc2WSvq7m+hn8/qJHSb1OSYP++DuLX
         wV4D9sC5fqXCvTpA2EqQgAtQoXk7/kRf8kuLCUJJstrnmhEEhHNdH2+uX5B0KUC2TMrf
         5Bbg==
X-Gm-Message-State: AFqh2kpgkNLegKQDOd9YTKOOpErnaxvWJ25mg4Vnr/9MhIsn+DreoMUZ
	gab2w9Y8zXqWC62+OU59YfQ=
X-Google-Smtp-Source: AMrXdXsT8CsVvq8J4iSs70U2NAb02ZnBPnUdja768aTjaHWrXaJ7242TFwZGQjcte6FU6q3Ic9Tqdg==
X-Received: by 2002:a9d:62cf:0:b0:66e:9542:3b1c with SMTP id z15-20020a9d62cf000000b0066e95423b1cmr16179657otk.34.1672423592683;
        Fri, 30 Dec 2022 10:06:32 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c1-20020a9d6c81000000b0066c15490a55sm10425567otr.19.2022.12.30.10.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 10:06:31 -0800 (PST)
Message-ID: <b1e4b9f8-20d5-f55a-c368-1f59c6727b93@gmail.com>
Date: Fri, 30 Dec 2022 12:05:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] monitor: fix buffer overrun parsing country IE
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221230002428.2870506-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221230002428.2870506-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/29/22 18:24, James Prestwood wrote:
> The country IE can sometimes have a zero pad byte at the end for
> alignment. This was not being checked for which caused the loop
> to go past the end of the IE and print an entry for channel 0
> (the pad byte) plus some garbage data.
> 
> Fix this by checking for the pad byte explicitly which skips the
> print and terminates the loop.
> ---
>   monitor/nlmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

