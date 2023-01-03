Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345178466
	for <iwd@lists.linux.dev>; Tue,  3 Jan 2023 15:23:26 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so19265369oti.4
        for <iwd@lists.linux.dev>; Tue, 03 Jan 2023 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iF28CLKssbMz/kGa1VcuJRjSJ5SgeBXEZ5T75z3cqhY=;
        b=ThTAVRTLapDJ+E9G85ps0/RSiSlB2FHRLNPyEEqEfgzLUzYnPfkxYs2SU90d/U8LeY
         nObFX7QHJN1zB8ryrCXVYmWcelXgcUbk4TzChgTLeORWiubVOUGdteDtg9ZwhiAa1Fgr
         Zzf+7I6a1xZsxti6FQu/2PBGmjw6WIxCJeIxtkTCJZikO3hoAP3tMNWbVG9LJSJn48tn
         tqPIrPbp3Qvq7UEdU9tybH5Gx+mn66MGj18aRxOyr+RY5zG6uqRaKtzBeuwS3ULxkgOE
         3n3y2sgS5pPROFT6+zUmVTrg3sU9u/FPQ3WfX4bc+LTNuVEZbFy3+t3t4WVH//lP2PeD
         bMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iF28CLKssbMz/kGa1VcuJRjSJ5SgeBXEZ5T75z3cqhY=;
        b=1WrujEdcCnMEaVglaYzU/z1Y7GoZg+maN0BhZLYuguw694Gqc7o1rW+eLu8xTmlGxv
         R5SQJr+DCN2k2fEiHhFBa2PsDAwVnHFxzkXoXoiJ4i19RYOvsGvORid1JsFhnt+IYmc6
         9C+lQBjhRAVcoo5lAA3br7VRZtRsFGyI2+UXHgYsr58YJu/VV605O8sS2pY0prDSSKSB
         4nHMF+Yp7HA1CxiNY95m+w8yjX/myWfSft1zgYHVjGsHq6JkwR2meWHFW3LhX2N7hEIA
         la3o/UUGI4VQBMfB6QggK/aFxxWQwXeHIZh8gSjvDYxcIgH/9KgCKbRuJ5ltl7qo2VEU
         VLhQ==
X-Gm-Message-State: AFqh2kp8QQk8jTVbRnvAO2LvlZ+nFcir/OQc/Bfbh+rlXwzX38gCK7ca
	wUowxJt9PuFRtPUoZEyscf4=
X-Google-Smtp-Source: AMrXdXtjj0kxeBBAQrMEx8yr6DTlO9sJjp2QlZegP3tUnGB+5lhofL5Ndnar3HyUtnFAXnbJcDuAsA==
X-Received: by 2002:a05:6830:904:b0:670:83e9:5b90 with SMTP id v4-20020a056830090400b0067083e95b90mr28044287ott.37.1672759405262;
        Tue, 03 Jan 2023 07:23:25 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d12-20020a0568301b6c00b006391adb6034sm14836757ote.72.2023.01.03.07.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:23:24 -0800 (PST)
Message-ID: <fb0755cd-9348-297c-f110-03510b21dc5d@gmail.com>
Date: Tue, 3 Jan 2023 09:19:48 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] wiphy: add wiphy_get_frequency_info_list
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221230221216.2985011-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221230221216.2985011-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/30/22 16:12, James Prestwood wrote:
> Gets the entire list of frequency attributes advertised. This is
> needed for AP mode to create a country IE which includes subband
> triplet fields.
> ---
>   src/wiphy.c | 17 +++++++++++++++++
>   src/wiphy.h |  5 +++++
>   2 files changed, 22 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

