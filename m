Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F212D532
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 19:22:04 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id j130so26791176oif.4
        for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VoofZglj7GWoaOljUWZS82MF7FMB56fWR89kl4fppA=;
        b=b1jWCLU9xk2fxdbxDR7pv0sO3Jg5nyy27w+mT+DTEgSDLVvx/yIhPMZnXawyKlfIv9
         1YLDOx/cKMEBbndQSupgywe/3Ntyg5PYJ8pY01Py4/u2Rih6uvwqjjuJE9WQ9KEWC1G3
         2L2FvzCOsUUAGbki4jpCZufSxQpOfaV6/ekQ31m5UrGxt67lt4rDx00j92eVW3KuZ404
         w9JJLkC4qKzafNezY85HyalHUEy+OW2bNQcfbu7r70vM8mwOcKrZGEYIsSryIYAZgyi4
         zrBsuQFRBId/5SiGvTZJht42B7pGH46FgAjAof8K81c6/McK5zIWQExlljz/2WwTKBU5
         ItcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VoofZglj7GWoaOljUWZS82MF7FMB56fWR89kl4fppA=;
        b=o1xW3oiiPsslctHua6xi8PLWpLuT5wHlQr1F5RvUhPFDlH7sGK+6BryyOD2jaEeqaV
         MxCNVdf6SMT2ZheDmKUSGFo0pL6sfdKA3xI9HoreurcqpRuYOQe3eZ7QjMMq6OgFdUb4
         KMlf98elawHjj12QlIxatZIpkuWc9DQmvPh5aF36G1RNA7YKCt8VCodvVGNgbMq/J9wn
         lTAEawdoWFEqfuusUmhBQI0eO5OBNMyNiDJ9cMIKzBP1axdI0VWHIYxGg1fkE3j8FsV4
         IUNh9+NFr8itU4QjqT7/tcU/wBqQgUH7ph/UGEKF74RYFzJx/fjGVcMGEvmssE53gLyx
         WFpA==
X-Gm-Message-State: AFqh2kpklXlZF9fiqWmd0Rat8ubD4+7E0hoRWR2pgScWKbpHDnMmxfl2
	HCHw61G9ZjOeMsIskGQLiiw=
X-Google-Smtp-Source: AMrXdXuK8Erl4cF3mpBuMgpI/xCcgkyRXFSQO1UjIxdxDRm0ZcHYMyrdlVJ3VOUVwkgDfisDB1p/yw==
X-Received: by 2002:a05:6808:1144:b0:35e:6a80:5e17 with SMTP id u4-20020a056808114400b0035e6a805e17mr2879101oiu.56.1673983323255;
        Tue, 17 Jan 2023 11:22:03 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056808020a00b00360e46a1edasm15040765oie.22.2023.01.17.11.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:22:02 -0800 (PST)
Message-ID: <dff07e30-f04e-0dce-4ae8-11d81af8c26a@gmail.com>
Date: Tue, 17 Jan 2023 13:12:20 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] wiphy: prevent multiple wiphy registrations
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230117180343.1451626-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230117180343.1451626-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/17/23 12:03, James Prestwood wrote:
> With really badly timed events a wiphy can be registered twice. This
> happens when IWD starts and requests a wiphy dump. Immediately after
> a NEW_WIPHY event comes in (presumably when the driver loads) which
> starts another dump. The NEW_WIPHY event can't simply be ignored
> since it could be a hotplug (e.g. USB card) so to fix this we can
> instead just prevent it from being registered.
> 
> This does mean both dumps will happen but the information will just
> be added to the same wiphy object.
> ---
>   src/wiphy.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Both applied, thanks.

Regards,
-Denis

