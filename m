Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56517624
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 16:59:18 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id e205so12857299oif.11
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ynuAdl7KuwSI53kZQ3XKlzzo2ZKBUTrqvwMAjsF1x0=;
        b=Q2KHK9woHL395H7LeJnrgE2H6IRA87+iy+dXMp4LEDLgTpn6mid4C13O75W18WkYpe
         1s2vwgUyT+3ChPreJj2HQKLJ8pvX4jY34+VQjsf6WhaYHl+Ec/ETeyRiugL+qhsm40Sr
         YhD98RFNU/o9o84ovNQk1nFvCxhf0iU76jZd+P7sF/jpXnM/vg7wb0Qgodt74MNzss2M
         FyHxStT0hrrVndUumqB8gOUo1MDXw6AJg//I4//SqiSvKWp0JZTHxvLFP9o/hKiB0CpV
         9I+mOYlfub2o+x+LwyjcbubnQHnih1egVQ6TFU+QZNwAXgiDVNA9W173I+tbEu/coKsc
         qTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ynuAdl7KuwSI53kZQ3XKlzzo2ZKBUTrqvwMAjsF1x0=;
        b=gT0JDGn2yiyneyopWuVzMI0GneT5WrztzJuXLW2EUUKqajJi1UytTzcmwj6iJOEmOS
         vi/mKV9cO3LZYz9B1i6hwrNa/qzBxuDUZzq3yYS/t3qwGv7Re4xXZBabJEMFCBy6Vxbw
         TdMNWUEYbJgBvgLQXewzIkTPl2SNQuhCklILSurUwvAAv7dWz0t7rH/C95WQ0db8tI/J
         dkgrv97FgCSqpsiV2lbadNPO/bFVkU6aKGc0U16brb4eKaiUXmawonSjwB9uv18X8QdX
         Q+MlycK+uDeJbWR/OExpnzU+JsZGnusCFP4+OUtGqt4fmOCdSlgzSx+JggRjqQo0YvGT
         M8Iw==
X-Gm-Message-State: AFqh2koL3Veo6H3QUJbYp1gHDilmw1T1BvM0cG+G/DeH8Lc9jR9LLF31
	0qIp29KdJFRkoEwBYfbZtcb9AEu8NO4=
X-Google-Smtp-Source: AMrXdXv6ZRz7S9F6TDWa9R0H2I5KtgvgisAYozXD171dOrL68byEO6WXsAEauYQz+MIMNsnwVL3giA==
X-Received: by 2002:a05:6808:238e:b0:35a:2325:7b40 with SMTP id bp14-20020a056808238e00b0035a23257b40mr13764248oib.23.1672160357262;
        Tue, 27 Dec 2022 08:59:17 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id k83-20020aca3d56000000b0035a2f3e423esm6011362oia.32.2022.12.27.08.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:59:16 -0800 (PST)
Message-ID: <93a09a95-268c-d1fd-0728-b7d18128c8f6@gmail.com>
Date: Tue, 27 Dec 2022 10:48:37 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] netconfig: Don't load settings in netconfig_new
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221222024143.632455-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221222024143.632455-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 12/21/22 20:41, Andrew Zaborowski wrote:
> Move the l_netconfig_set_route_priority() and
> l_netconfig_set_optimistic_dad_enabled() calls from netconfig_new, which
> is called once for the l_netconfig object's lifetime, to
> netconfig_load_settings, which is called before every connection attempt.
> This is needed because we clean up the l_netconfig configuration by calling
> l_netconfig_reset_config() at different points in connection setup and
> teardown so we'd reset the route priority that we've set in netconfig_new,
> back to 0 and never reload it.
> ---
>   src/netconfig.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

