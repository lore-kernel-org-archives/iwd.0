Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738A53A7
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 22:28:48 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id r82so8817231oig.2
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1j4Tt2xTo9RD82dWZysbhAIIla31UCrtlRuN3iLRwxg=;
        b=oZf1E4jugCCLqBp4+BeAJZJbKsC2sQDYDazY+wBamBHl+K3/p6pH9DLg3BW/q7/rIW
         MJrMwUWnj1v9rMijCdBAEqFLmPDbfcMqhvxnqQWOGpdzV295RPwqWQ3QB3UtcStmRqu9
         VtZVZFpE75MenL15OA6r5H8xM+nedWvvHX4l+VffyrMCIKm3xa6FKmum9e5vtLkJqBMO
         8CEflsWjlV5mMUKmjL0S//3V/aZHT69qukFwL3hOK8cGccQ5HJmosDFcjb69Z/xg3mS/
         LwD3pOC1vW3mAmlTxvCc8gmnM3lsSudJa+FSRctMN9jrSgkgP05k9Z1KNnJjkXV6bO2K
         0RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1j4Tt2xTo9RD82dWZysbhAIIla31UCrtlRuN3iLRwxg=;
        b=nWEBEE/qW7LBXXQsyHQfTyLAuIZqFTu3VDw1aSRewDpSc4DuX8dHiiXR3IPzwN6frx
         EPe3gghPA9goBWsJ8+vdHrnqT91hzaL8YxFwlN1kO7J+Tpj8LySQh6lE5lKoeRth+Nvi
         2hf6/NBYcqOFJABtl6ypqfOxrSmvL3eIONNEAu69+tryzVfaz1X/KGamMFuyT2Iw5qxU
         ovne3tjB28DoiHi0hG9Jjh1Ba8phN2gyvtMOZ1XDHJ75acHSVsQFCdlAbg7jAI389m+a
         RqkQ3znb7M1jAgR9ebqAoXlM/YxGFvIey+VgctEoLfifa5OqSXBBsMWNA2DJOIJPeIY7
         iGlA==
X-Gm-Message-State: AJIora8UDFIUzdzBISm/qBDr+7CeRtmWMflpm9+AdgNdDSwKf/9MGQYq
	Hna//0fp96wfPFEb6Kw/skI=
X-Google-Smtp-Source: AGRyM1su3qLE5iuhvV7HDoyrA9Xa29EaSNhByI2FVwiddyJlPEoIBjxA7DopsgJ5lN13shHy+CaJgA==
X-Received: by 2002:a05:6808:238d:b0:33a:8965:3a9d with SMTP id bp13-20020a056808238d00b0033a89653a9dmr865815oib.167.1658269727749;
        Tue, 19 Jul 2022 15:28:47 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id q19-20020a056830233300b0061c5621e352sm6711481otg.1.2022.07.19.15.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:28:47 -0700 (PDT)
Message-ID: <440a941d-a684-f17f-5e79-1de12da1dc9f@gmail.com>
Date: Tue, 19 Jul 2022 17:11:45 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/12] scan: add colocated scan flag
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220719185544.456727-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/19/22 13:55, James Prestwood wrote:
> ---
>   src/scan.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

I went ahead and applied patches 1-9 and 12.

Regards,
-Denis

