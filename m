Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7004681
	for <iwd@lists.linux.dev>; Tue, 12 Jul 2022 18:02:25 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-10bf634bc50so11282590fac.3
        for <iwd@lists.linux.dev>; Tue, 12 Jul 2022 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/RGd0JoWH8PDw321UscLiepIJqbKaiRhPDrOiJgzYQg=;
        b=B219RDGBAaLg6hjT40iaHra/nfGxf10juT33Cdwvz5phya6Hp0TB77xpOJ5hYdKP6E
         xua141EoCJT/Wu53fOVp6haOgcTxAWZIGgAslqT2mJ1BgsFnrnZZXeY+jdazRUnXo1sS
         9l/ZYzbCf0c7gEhuugI99fOaNbv9KlSbgbmkaxjjpzX4w8cF130y+N+uFkYMdiPoDL0x
         erSpLsHKPMbo1J8thUJNhJTkAJNopd9fzp9JcOhfNMUeaFF57XYdcYS6/6V1mTLvVunJ
         eJkG9dHoXjI5e1flqGfVqWoiA9WMWp0SqXw9OzrNebG8xB9sLh3YdAZLzUlxoRhyGjBR
         Mhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/RGd0JoWH8PDw321UscLiepIJqbKaiRhPDrOiJgzYQg=;
        b=y5pj3iQEno9z+0q0tJ+McxHQRV/Lbtfa6+U0kGoykywQtPET6u5Y8rpy8pg31ZeCn4
         aadt8o3TMRacPTtWGwhvo1n4jZ9fzUvJyIqhW48ausXqraFzCs/B1z8Z4anAwvBF1LtU
         Zuqj13/WtB5UoBd2/BZu4o0LvlXggBKjW+vW6+hDMAU3tth01NMgku7+TV/CPcJYgpeo
         7gy6iYP/Vt0VAbN5WBkXZNRYPe/d7LaRmztSEPMoz8SJ7alLK1mOqQpXCInRi70ofXrH
         dQUqupNDwlEde82DZU3zg8zz2UfmFk60JYSo02VeZIeciW1wk3QRCFVRgPH/RRJyEkyh
         qImA==
X-Gm-Message-State: AJIora9t0SS/6xGtw7TbRtnOoLBmuCRGjkUZaB/PnvF3q82AqkbZ760j
	V4JNCCZQHL5AQq0WupS9gS4=
X-Google-Smtp-Source: AGRyM1uh1vBDRtPx2/rWWDjVhUMqnZM3vVzWQMOv55HIROc5m+IUF5jNlEh6fU6KCqj6gjLouoKy7w==
X-Received: by 2002:a05:6870:b3a7:b0:10c:224c:a0b6 with SMTP id w39-20020a056870b3a700b0010c224ca0b6mr2421614oap.248.1657648944646;
        Tue, 12 Jul 2022 11:02:24 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id u3-20020a056870d58300b000f34dacf350sm5079713oao.6.2022.07.12.11.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:02:24 -0700 (PDT)
Message-ID: <f83c458b-4d6d-4f07-d253-b27b1e48250d@gmail.com>
Date: Tue, 12 Jul 2022 12:48:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] test-runner: Support running hostapd in namespaces
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/8/22 19:23, Andrew Zaborowski wrote:
> The kernel will not let us test some scenarios of communication between
> two hwsim radios (e.g. STA and AP) if they're in the same net namespace.
> For example, when connected, you can't add normal IPv4 subnet routes for
> the same subnet on two different interfaces in one namespace (you'd
> either get an EEXIST or you'd replace the other route), you can set
> different metrics on the routes but that won't fix IP routing.  For
> testNetconfig the result is that communication works for DHCP before we
> get the inital lease but renewals won't work because they're unicast.
> Allow hostapd to run on a radio that has been moved to a different
> namespace in hw.conf so we don't have to work around these issues.
> ---
> changes in v2:
>   - ensure at least one hostapd session starts if the [HOSTAPD] section
>     is present to mimic original behaviour and fix testEAD
> v3:
>   - make sure Radio.ns and Interface.ns are always valid (equal ctx
>     instead of None) to simplify Process(namespace=self.ns) calls
> 
>   tools/run-tests | 90 ++++++++++++++++++++++++++++++-------------------
>   tools/utils.py  |  2 +-
>   2 files changed, 57 insertions(+), 35 deletions(-)

All applied, thanks.

Regards,
-Denis

