Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAE2563
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 17:28:53 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10dc1b16c12so3628601fac.6
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=58hb/veEQQPPZtH1BmU/Ew0BupopxpWiwTa3wlZBP4Q=;
        b=ij7+upq01NJwCEb0XwC0COaqRQwz+xoKWGfq4u6SzBZgcqgkOz8rOVc5rYxAUjq2nP
         qdGLfeRIohMgSrLAF3jmuaeXU7jizUdr3u1RQZ+cL3B+C5/0NBeq7JBBxzoHHWNIF9aU
         Kh8Zy72voq8eUjy5bJOThd2rJEyjcWnVdxZFiUdyLhCdPBwrZ2hjpc+LLuWVbL8MOYHz
         npzwPBclAElNrJJt5u41jE97MnSQQZerVEWl/UkKKvXEOXEXJTiiq3v7L02v3Q0tVCqY
         J5HiEx6jgaD4+15TsQYSWO40j7Oz1TcQfEVPc+BZYVib3k3399BJXL6yJnfTh56Ro68I
         78xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=58hb/veEQQPPZtH1BmU/Ew0BupopxpWiwTa3wlZBP4Q=;
        b=iHGTH0SFoRjtGCTQyvTdKpRQsoR9GWhoELweqvDIlwunmn048XtlrM4lESDWa2t/8S
         EZ4UdvZmOp1st8A/ulu55iyJJyCkx85WpJPeufgzLONsBNdFY3D139gVA7lCOLVzPByy
         vQGitATZJNh8Bx2QTokw1ggqii7+keJ9HMbTOUrseKLV1702lRBiT9+iWP4mGyF5CR/w
         n9PVWei6TVH3DaZ566/6Fyv2sCHptTb6GJTaKFNXjsCUBdkBOunOBHro87AWkwetYMWI
         /ypjW33baGBxWZl8DWIWDs11othRpQ++5VvuD8ldGhtvQbncHiQWnSQwM8yh9EJ0vKEZ
         xkfw==
X-Gm-Message-State: ACgBeo37yOUs0pEwkY9w85F5abCU1sAXCJf/jPnQLUqunqctL+G49eHh
	WJhvzHyN4CWjSp+EWQjhjBE=
X-Google-Smtp-Source: AA6agR4065F4fd6/GPBTb+U0JBNs4bMsCBrEL+sZA061Lf8KsrM1edwGgABgvN/Zak/ORv2+Gel0Mw==
X-Received: by 2002:a05:6871:7a7:b0:10d:3fb6:b632 with SMTP id o39-20020a05687107a700b0010d3fb6b632mr3568527oap.237.1659720532738;
        Fri, 05 Aug 2022 10:28:52 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g27-20020a4a925b000000b004279be23ed4sm802382ooh.41.2022.08.05.10.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:28:52 -0700 (PDT)
Message-ID: <ef0c3d80-2080-ee51-6f91-47a894a14177@gmail.com>
Date: Fri, 5 Aug 2022 12:27:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] util: guard against NULL 'freqs' in scan_freq_set_free
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220805172801.637589-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220805172801.637589-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/5/22 12:28, James Prestwood wrote:
> Since this can be used with the _auto_ macro it must be able to handle
> a NULL input for error paths.
> ---
>   src/util.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

