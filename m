Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006064A11
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 17:36:42 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id o64so16148046oib.12
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/OGghEGg4j9pgJewTwkQO8pvR0wxb9noiw/KzUKmUTk=;
        b=o8FtL4ualruSp/1QmDJQDnvzB4QPA2912ovLEIQgIkqi/SKpO7j4+d9d6Sz5Vpdldc
         sbbpKa1WJk+EIdThuFtNbBxphR758rAtoBlFPMx90q0cM2iPWeQqy3uTy8jHE0z3argq
         W1MxJqw2jFqMmTVEv5o/gBGG6dyvuYh1D7wNRAXhYV1A04ByoncJpPvlM0NraHmjwOXH
         Cixnvu06yS6ejWSJf3ngRkYOTJLaayO7F9sZ0rzflFQVGkplnR/yIOhT1BU4UuY7PdUZ
         +4GeDmDVmY3e9r9fNkwR1jX3jVD1pAlXNm0ipYqeTVe8Gx5fzgzq2lMzkF6J2ss9l7n3
         TwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/OGghEGg4j9pgJewTwkQO8pvR0wxb9noiw/KzUKmUTk=;
        b=8RVQSF3E4OgxTxkcs6PJzwD3l6O/0fZtLDcNErLBv0jcsR21FtLaRz8nbycCaCRC8K
         r5FU0aYhAHdH6cC4jYb56q65TEUyMVkVgM7iRj8m4FjZr5k9AXljhGalkpoloIBd4nBd
         lsLiez6HBShIVCDgDS9DrPaPs77FB8AHZ/ASo1JA4LXT31Fa6CiqHlqouX2X1vTIU2jd
         kE6WFs161tzeqIbnbUqX54ZaWePUQrF5AWcEbrKOYjik2FC8xkziSQt9mNSgIpwXJQo+
         2rPuwulNNvRRZ1q7DS1JDu199azBySoSCq3ORGFWLKBnnerHUX7/8uY6aP45GVd5BMn3
         OiIQ==
X-Gm-Message-State: ACrzQf235A1KbGi8wnBATXf6WnfAXthfAE6t2l2K6pnzc1Hc1ZXBpEt0
	SuPrRbtiQ1lSQLcfmudWZeSJ2Y3KDm0=
X-Google-Smtp-Source: AMsMyM4T6fGygxshSh92fBdkQHoX7wyay5qpZ0x6zfGowwOwWAlJo1oerh04QDA2zcVgKrc6ZV6s/A==
X-Received: by 2002:aca:1a12:0:b0:34d:d44e:1b5c with SMTP id a18-20020aca1a12000000b0034dd44e1b5cmr4841220oia.31.1664386602132;
        Wed, 28 Sep 2022 10:36:42 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056808130400b003512f3195d7sm2097857oiv.30.2022.09.28.10.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:36:41 -0700 (PDT)
Message-ID: <8351d720-f38e-3686-d964-066f767bea10@gmail.com>
Date: Wed, 28 Sep 2022 12:36:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] station: reorder AP roam logic
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220928163637.344656-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220928163637.344656-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/22 11:36, James Prestwood wrote:
> There are a few checks that can be done prior to parsing the
> request, in addition the explicit check for preparing_roam was
> removed since this is taken care of by station_cannot_roam().
> ---
>   src/station.c | 55 +++++++++++++++++++++++----------------------------
>   1 file changed, 25 insertions(+), 30 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

