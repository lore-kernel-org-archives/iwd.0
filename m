Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D5746B
	for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 16:27:22 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id s41so4824714oiw.13
        for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIlJcqY2mmgQRTtZKXW+rMOPQBeOmmXkgx8Q3GGcx/U=;
        b=KOtOZZR+gQDWGSVgrC2EPiN2vAm2Fw6c9dhExu3g9T12j/hOIxnod112QsM+3wLFCc
         Y+pDJWQdlQj4Jg7zRvq/oJY6nOtzvQMrq9cEk51+ckn9bkOOmRaOEC/Mmb3gR55SmfAN
         z3Fp0XqCLs5gT5S0Dgp/GVYfsftZ/IoH/SG+510X4zPdgz+TUrSY3RTiXq7TdoVveHDP
         yLIXIo0xqBrTdD7DBBqwLkol/S/haI1c6h28six7gB7WQHF4R0ByTvqk6ZrbirwFyMzj
         57KkpQU5iEkxZd8n5QjePzYa2UiUIf2dAyA4mGaa3oRSVC97ExYm1pavWP99/QDZ/hxU
         EJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIlJcqY2mmgQRTtZKXW+rMOPQBeOmmXkgx8Q3GGcx/U=;
        b=hF06lNR/cddF/2Tyxee5TYY/rzMfSuO5fyIPLRsURAgTMCvwA338vN7bkkzT/OP5/t
         fipdN+UFt1vIV4YsTSPux+jKcMcv/yN6t+qPxxcwH0d5boAPSSv854q32XUgPXMBLi8l
         NvFW2DCNMQkocTXA3/bWEehu1UuoZIT5aBL5dTswVTuqSSHKhLYhb/WfiQFPnqNYU1to
         Qfcbgttp4onjNowgROl7WbkNAmW0WnGEPHZze5mS/Z68KqUANqg/f5HDIdk8PLGyII8h
         ENxhRW3L3r/Zpq4wvjUe6SB46P19D4AQVgWL5fNXA+6sHqBaH6ordrRodv2F4HD0cenK
         jM/Q==
X-Gm-Message-State: AO0yUKWLQhK61usCk8m9az6rKbqDMBq9J/+ZYEJdpe/zAUBEW/xdiaq1
	NrFh4ZBoUi+TOQzqvvCVxgLAF4vyvMM=
X-Google-Smtp-Source: AK7set9dDUBtmDpilS8btPBnHVOJ9sktcKwQtVva5gQLuy/mFBsvmA365IhVVtz3/1ZMSc6menGObw==
X-Received: by 2002:a05:6808:b13:b0:37f:ab79:a18a with SMTP id s19-20020a0568080b1300b0037fab79a18amr11433291oij.6.1677515241525;
        Mon, 27 Feb 2023 08:27:21 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u13-20020a4ad0cd000000b0052037988717sm2817342oor.4.2023.02.27.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:27:20 -0800 (PST)
Message-ID: <7e5cb898-ba2f-2587-a85c-d342a863f324@gmail.com>
Date: Mon, 27 Feb 2023 10:27:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] doc: document DisableHT AP setting
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230224005723.1411083-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230224005723.1411083-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/23/23 18:57, James Prestwood wrote:
> ---
>   src/iwd.ap.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

