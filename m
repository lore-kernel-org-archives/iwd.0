Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1882585
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 15:44:43 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10d845dcf92so24694453fac.12
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=z4RpsKaGiTjo/YQdAMMhmmDm9tB35OJdUyIeGX0mpTA=;
        b=TZx5I2usCw9pXmPqco/sdIJ+cDuoOqfZLfVi/rirhF3MNZrQf/snxpzKKWMpKrVb92
         pBx9XUzS4kAX3nJRwsxWQCG03zrMOgV3iwq6NM/JCIVWDAe3eQqxIMNwNChxA5935OZD
         y5D92oCLt2YVgkenCGOhZEVQjChNpFgf2mcXTYmSqqYiAzylkG2UZD7V+LFbz+VClPn5
         BHkq7brGpAB2w+RkalT2shclhWJZio4uXZOL/5k4Z9EoCldY8CyEt6YMaNEFgQcnFBUl
         IZT+M1Dm76sSucvTjfIlULZ5zEtHWvrzskSu36FN0J0sqfu0i5p8a0duIDP3hpH+JP2v
         GupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=z4RpsKaGiTjo/YQdAMMhmmDm9tB35OJdUyIeGX0mpTA=;
        b=jfIKTSTnobq8DOaX4m7W/kMNpxI9DGLbSHGE8UDeEqwIpCdR6/0F+ujKe5uO7pHY8d
         CyeQHvlK8su5RRbyC6E9E89z7+pJqF/Vw1PiVThNp8dy9chysDz02IMe6apLYxFYmvW5
         m9qpw6pzbX3lsvNLMRv48qxe9KOrDELHv1YQCCoAMnrzdZosZomQ0+FBN7VUc1ZdoK+N
         xulz9WUSSM8OxrxuK/0E/fpTcES+1JXy7TghZ43HZQaAxnUMriMph68vkC7c5g3VFpuL
         8iKfpUSLpiL7oncHGmJWUGn06elHkeUMzevBvXuVd4D884r5+ET2BcDVM4TcaFcggaa1
         cKhg==
X-Gm-Message-State: ACgBeo3O5g/1JCmBSMAA9dDAh4RBsOlqnRFK5BGUpMu4fX7z4oMXl4ln
	3jeo3rfdeIa5tHShf6HlZZS8QJps13U=
X-Google-Smtp-Source: AA6agR6vt+8f7ezx9UXxEamJasvOHQ8RNSVKRodFegGZfpeM+H/7omo6kCiy/uxe2+HVJwsT88PZIg==
X-Received: by 2002:a05:6870:e60c:b0:10c:1358:3a40 with SMTP id q12-20020a056870e60c00b0010c13583a40mr1168243oag.218.1659627882754;
        Thu, 04 Aug 2022 08:44:42 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f17-20020a056870899100b0010d3438b20esm172713oaq.29.2022.08.04.08.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:44:42 -0700 (PDT)
Message-ID: <dac673fe-cebb-31cf-4885-426fec523e35@gmail.com>
Date: Thu, 4 Aug 2022 10:31:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/13] wiphy: add two regulatory domain state events
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220803213644.277534-1-prestwoj@gmail.com>
 <20220803213644.277534-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220803213644.277534-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/3/22 16:36, James Prestwood wrote:
> Events to indicate when a regulatory domain wiphy dump has
> started and ended. This is important because certain actions
> such as scanning need to be delayed until the dump has finished.
> ---
>   src/device.c | 2 ++
>   src/wiphy.h  | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index 02da2cdc..d7eb6adb 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -282,6 +282,8 @@ static void device_wiphy_state_changed_event(struct wiphy *wiphy,
>   			netdev_set_powered(device->netdev, true,
>   							NULL, NULL, NULL);
>   		break;
> +	default:
> +		break;

nit: Prefer to not use default: when possible.  The reason is that if a new 
enumeration is added (like you do here), the compiler will warn when it isn't 
handled.  Prefer to be paranoid and explicitly add all the enumerations instead, 
so that any new enumerations are not left mistakenly unhandled.

>   	}
>   }
>   

I amended this patch to do the above and applied, thanks!

Regards,
-Denis
