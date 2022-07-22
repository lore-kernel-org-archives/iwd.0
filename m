Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDE4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 18:00:46 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-10cf9f5b500so7217358fac.2
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Vp9kNgycF3+S3aakIaotGD3cv8fYf9xU2PiZidlL48E=;
        b=eU8xSUdrATbwrp/MJr6GTA6YIuUq/R0lAffJttCrHF2c+TdclDtd2150+tRHZSIbjY
         v+BRCZmv4U8662IiTzPZH0fKI/oKVHJ2LFzERsuTHvDkeeatWyM/xOHEYPba5B0cY9EW
         ifYOGkn1C6wqwn82M/Fprpt+of8EsQetvAoM7VMwxrFlb3VOwSpwv5HOKaaMicmTpO/v
         0ib17lH60FgAb68Mj5E9zrnqb0SDcKuE4BWiq17aXxrfBjt18PX24CLj0uOzg0YpkMft
         6B5P3iVjlxiyuWgBX6qUeiIQevhJ6ZwmB5M9WcYOpLD1WDGMT5+pNhf/xRIYApWjFFVR
         M6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vp9kNgycF3+S3aakIaotGD3cv8fYf9xU2PiZidlL48E=;
        b=63i7mBbt8ZQVxPU0U2BO3ToQnP/+SZHCQwtp4nlbrOWsQy57SbPTi9ldWV8oz8bbQU
         sMU/qqa5Sn99J2t7JC/bQxDgkdVvEE68RbnHHnkmH8xxpufdMGr1XFQLgQsuGBdtXNhP
         ZRziN5PZDoBrV9eIyZ06idSSCQ654lhMLDIT8A9O+zYYMhtEnHu0KGR+GVntMysvXm63
         BZl1o6utGjzjI/b6goJ7T28oAEZue6RABlK3q4UMmUNqkVU+cL0lUiftW/Y+AwrLeprY
         qAtbl0k7y2BiKt2UBM+Ustvyehd60vcrsMgitbgODLRUvdiGlInSfnFmx800kEuK9Kxy
         +KFw==
X-Gm-Message-State: AJIora/0k+iTrzVEjhww8/pa+tFatLuFWMQxFkY/iJfpry/meyshHEhi
	hhxN4YzjnyOQP0VI83N/9buwXHpAQ4Q=
X-Google-Smtp-Source: AGRyM1tup+E72j93niONZGvq/U0+sM3xxI9YPJ8DM55b0YOqcO8LV3yiApJMjwgFe4JETFvdR7t+6w==
X-Received: by 2002:a05:6870:338e:b0:f3:1a36:9485 with SMTP id w14-20020a056870338e00b000f31a369485mr8565457oae.277.1658512845731;
        Fri, 22 Jul 2022 11:00:45 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id h4-20020a9d6f84000000b0061caee21a53sm2253888otq.54.2022.07.22.11.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:00:45 -0700 (PDT)
Message-ID: <7a6cc538-2ed4-b464-84c7-e7a92a3cb170@gmail.com>
Date: Fri, 22 Jul 2022 12:41:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] util: add scan_freq_set_max
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220722163417.1119334-1-prestwoj@gmail.com>
 <20220722163417.1119334-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220722163417.1119334-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/22/22 11:34, James Prestwood wrote:
> Finds the maximum frequency in the set
> ---
>   src/util.c | 19 +++++++++++++++++++
>   src/util.h |  1 +
>   2 files changed, 20 insertions(+)
> 

Do you really need this, or is scan_freq_set_get_bands() enough?

Regards,
-Denis

