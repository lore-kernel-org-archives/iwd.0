Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64D746B
	for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 16:25:54 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1720433ba75so7934576fac.5
        for <iwd@lists.linux.dev>; Mon, 27 Feb 2023 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKqJqulazxf2ZLjWQfPFJoPgaAZnuHpE2ufG3BYS/Cc=;
        b=j/TPTP8DIP4FtPNMt7CdzP91N1CnnQu2n5hdoqzaUVfLvx5araR1s3mExkcdHUSzoR
         2+6fdg3JJa5ipAZF/VYM+XJSz2vMHuUWozQDFCdf8Iqx8P353hojFmn45aXdTuUvnGRa
         uR9JFlLOK5Favhmxuf/l1O9J0O2057uPCtBzW4f8LQpEizL8+FYGCjDacrl0wnm+jkg9
         tdvKzNCgW6kua9tgeYl437YlVVAPc7E6m7jjYb+qQd61RkDl5QSkpNpdBaiWs5FusMN2
         408Cdme2FzF4zsw4aGn8breGXjjnPgwM8Br8+c/YAHvgayOYpNSW5Jt5ibq3HL2dHpkv
         G+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKqJqulazxf2ZLjWQfPFJoPgaAZnuHpE2ufG3BYS/Cc=;
        b=6Ju8CRPa34fiO5seXfZRWL+eDjSFwLb9bD58SVBKAHw27/lyuafD70HK0N/n6Zli53
         bODR3IBmiZw/5Mnp4o9YTs24tmfXFwj5sSNx19z1A9ZtIycmO+M1HmeNPOQVFTOywNSj
         eGdPeKogCLXutf0VOjb9FvSzPN+ocuIpsWvJKk2d1a6U2JADMc2378pZdvil952pfUzf
         XXMefiM+x+ZM0uEUdONTbDr7daGUYgiIrayq63To1ql7uSXdNmDxPE7CAxwmYhuomsNk
         S31amEWT4mVq0jUZ/8NWtV5JfUR7Ua6hxA5L/7RgdE/Yjpi2xlVWKFRSoNlEmDOJQS7c
         evrA==
X-Gm-Message-State: AO0yUKUFLMZCSdpRV+09ZjzXG8uZfK6JzxDa7neUEWMEixChcJZb3lz5
	yn3B8M01pHIltX1pNbiWT4s=
X-Google-Smtp-Source: AK7set8nVRRO2Hl8Rt2WhGIIScMmLv70yD/z1OH2mLbUKlKjRVtdLlgktCIPHGDATsJzyHJlyJ0d5w==
X-Received: by 2002:a05:6870:a693:b0:16e:8556:41e4 with SMTP id i19-20020a056870a69300b0016e855641e4mr24449479oam.3.1677515153524;
        Mon, 27 Feb 2023 08:25:53 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t2-20020a05687044c200b001726cfeea97sm2422713oai.29.2023.02.27.08.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:25:52 -0800 (PST)
Message-ID: <1c6dec0b-4c4c-a599-9557-bf2470c6f31a@gmail.com>
Date: Mon, 27 Feb 2023 10:25:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] monitor: print contents of beacon head/tail, and
 probe attributes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230223181417.1384624-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230223181417.1384624-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/23/23 12:14, James Prestwood wrote:
> ---
>   monitor/nlmon.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)

Both applied, thanks.

Regards,
-Denis

