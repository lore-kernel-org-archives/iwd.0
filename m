Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F8A5A
	for <iwd@lists.linux.dev>; Thu,  6 Jul 2023 03:17:48 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78666f06691so5920539f.0
        for <iwd@lists.linux.dev>; Wed, 05 Jul 2023 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688613467; x=1691205467;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlHuUSIuU6c+//sm87z5PO2R8hMu0dhvYtmBLQlpBII=;
        b=mnxx9XDnuLEH3yPYWCpLSMfKbWkA5C4POW6wpnGxOuqphCTaMGlv+cK20nYkSOf7DL
         xEFywgjw5+Q4seEp2v8HSaKIwIfcx8GzhDMpxHDDsD85Mp1rdG+TV2wVNt1sO/hYB91M
         U1p1emhz3llyIPJ+pn1bDH66WSP6Ol4jtIRndhUQkxfInztXrxx1IcqGFSHrmDME3z26
         GYYOgWEDwS8JPMxYpdmM4TB3+8tPiW1AtBkCqmLAfcoA6T3N8JwXeXiP8hSbiyDGT73c
         EHHo6IzI1nzip5uHErnbpOgp5g1U0rrKyJq59+E5HkyRGpZr1pqUgH+oWsdz2c60n65U
         ke4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688613467; x=1691205467;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlHuUSIuU6c+//sm87z5PO2R8hMu0dhvYtmBLQlpBII=;
        b=hXNl+WibyvPGexz6MKWKqo6lJ5ervJeKvqzIe9O/7XhpYcrAo9IaW+vMx7aqV9AAQ2
         ubsWp8TLq9oZvKO7RghnBsEo4UIrmsqCJBQ+yjnxQ/cTj4+wvCoQATkx6R31ZPpRJz+4
         Pg6OZD4R+lnxZ2rz4C7oGGBHFqrlx9xH5S8E3wEq6qT0HGKKz4LRpNF6BrTxzAj48kex
         cs8jxJae8P+lRzbMmZz/bddYz0kFvw/TCjvDPljdvsQDUSnhelLs9Fxoa0lL4hLGdt4A
         EMNk9Z60IlVpr4RP5LGNWXGz0dnXzF+T6vUSu9PeaYMZqqs4NCHHMLyhMVGUOz2oQUJY
         9Tlw==
X-Gm-Message-State: ABy/qLZm7WOWzEDxG1gICUuzTecxW+Q+lCsDjQJtDpswwLupMb3p7VTC
	k+vxakZS4EvvklfGSshH2rbA8zP3iS0=
X-Google-Smtp-Source: APBJJlGcI3VawdR7EbbwQSBZyJkRoqeljgSPGleCmmkNgZ2LeVkP0XWvrwfFSRMsQadmO97jo+0wVg==
X-Received: by 2002:a05:6602:3314:b0:783:5f87:6402 with SMTP id b20-20020a056602331400b007835f876402mr912906ioz.17.1688613467329;
        Wed, 05 Jul 2023 20:17:47 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id s11-20020a5eaa0b000000b00785cd25010esm161775ioe.11.2023.07.05.20.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 20:17:46 -0700 (PDT)
Message-ID: <c54f0b24-b359-e51b-b30b-2175348348d6@gmail.com>
Date: Wed, 5 Jul 2023 22:17:45 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 2/5] dbus: remove iwd.h dependency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230630191812.2884637-1-prestwoj@gmail.com>
 <20230630191812.2884637-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230630191812.2884637-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/30/23 14:18, James Prestwood wrote:
> Require a compile time flag to set the service
> ---
>   Makefile.am |  1 +
>   src/dbus.c  | 33 ++++++++++++++++-----------------
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 401d2ac5..2fb03aa9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -268,6 +268,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
>   
>   src_iwd_LDADD = $(ell_ldadd) -ldl
>   src_iwd_DEPENDENCIES = $(ell_dependencies)
> +src_iwd_CFLAGS = -DDBUS_SERVICE=\"net.connman.iwd\"
>   

I'm not really a fan of doing it this way.

> @@ -38,99 +37,99 @@ static dbus_agent_shutdown_func_t agent_shutdown;
>   
>   struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
>   {
> -	return l_dbus_message_new_error(msg, IWD_SERVICE ".InProgress",
> +	return l_dbus_message_new_error(msg, DBUS_SERVICE ".InProgress",
>   					"Operation already in progress");

I wonder if we can add this to ell instead.  We have almost the same code in 
oFono for example. And something very similar inside connman src/error.c.

Perhaps we can simply pull the name from l_dbus_name_acquire?  Our apps are 
unlikely to ever register more than a single service name on the bus?  Other ideas?

Regards,
-Denis
